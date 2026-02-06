from datetime import time, datetime, timedelta
from fastapi import APIRouter, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, func, case
from sqlalchemy.orm import aliased

from app.db.models import BusRoute, Stop, Route, Bus
from app.db.session_db import get_async_db
from app.services.routing.astar import RouteAStarFinder

search_router = APIRouter()


def generate_schedule(start_time: time, end_time: time, interval_minutes: int):
    schedule = []
    current = datetime.combine(datetime.today(), start_time)
    end = datetime.combine(datetime.today(), end_time)

    while current <= end:
        schedule.append(current.time())
        current += timedelta(minutes=interval_minutes)

    return schedule


async def get_direct_routes(db: AsyncSession, start_id: int, end_id: int):
    rs_start = aliased(BusRoute)
    rs_end = aliased(BusRoute)

    subq = (
        select(
            rs_start.route_id.label("route_id"),
            rs_start.order.label("start_order"),
            rs_end.order.label("end_order")
        )
        .join(rs_end, rs_start.route_id == rs_end.route_id)
        .where(
            rs_start.stop_id == start_id,
            rs_end.stop_id == end_id,
            rs_start.order < rs_end.order
        )
        .subquery()
    )

    query = (
        select(
            BusRoute.stop_id,
            BusRoute.order,
            Stop.lat,
            Stop.lon,
            Stop.name.label("stop_name"),
            Bus.name.label("bus_name")
        )
        .join(subq, BusRoute.route_id == subq.c.route_id)
        .join(Stop, BusRoute.stop_id == Stop.id)
        .join(Route, Route.id == BusRoute.route_id)
        .join(Bus, Bus.id == Route.bus_id)
        .where(
            BusRoute.order >= subq.c.start_order,
            BusRoute.order <= subq.c.end_order
        )
        .order_by(BusRoute.order)
    )

    result = await db.execute(query)
    rows = result.mappings().all()
    return [dict(row) for row in rows]


class OneTransferRouteFinder:
    @staticmethod
    def get_start_subq(start_id):
        start_route_ids = (
            select(BusRoute.route_id, BusRoute.order)
            .where(BusRoute.stop_id == start_id)
            .subquery()
        )

        # Берём все остановки маршрута после start_id
        start_routes = (
            select(
                BusRoute.route_id,
                BusRoute.stop_id,
                BusRoute.order
            )
            .join(start_route_ids, start_route_ids.c.route_id == BusRoute.route_id)
            .where(BusRoute.order > start_route_ids.c.order)
            .subquery()
        )
        return start_routes

    @staticmethod
    def get_end_subq(end_id):
        end_route_ids = (
            select(BusRoute.route_id, BusRoute.order)
            .where(BusRoute.stop_id == end_id)
            .subquery()
        )

        end_routes = (
            select(
                BusRoute.route_id,
                BusRoute.stop_id,
                BusRoute.order
            )
            .join(end_route_ids, end_route_ids.c.route_id == BusRoute.route_id)
            .where(BusRoute.order < end_route_ids.c.order)  # только до конца
            .subquery()
        )
        return end_routes

    @staticmethod
    def get_all_route_in_start_and_end(start_routes, end_routes):
        transfer_points = (
            select(
                start_routes.c.stop_id.label("transfer_stop_id"),
                start_routes.c.route_id.label("first_route_id"),
                start_routes.c.order.label("start_order"),
                end_routes.c.route_id.label("second_route_id"),
                end_routes.c.order.label("end_order")
            )
            .join(end_routes, start_routes.c.stop_id == end_routes.c.stop_id)
            .where(start_routes.c.route_id != end_routes.c.route_id)
            .distinct()
        )
        return transfer_points

    @staticmethod
    def get_route_ids_and_map(res_tras):
        list_dict = []
        list_route_ids = set()

        for row in res_tras.mappings().all():
            row_dict = dict(row)
            idx_start = row_dict["first_route_id"]
            idx_end = row_dict["second_route_id"]

            list_dict.append(row_dict)

            list_route_ids.add(idx_start)
            list_route_ids.add(idx_end)

        return list_route_ids, list_dict

    @staticmethod
    def get_all_stops_for_routes(list_route_ids, start_id=None, end_id=None):

        route_bounds = (
            select(
                BusRoute.route_id,
                func.min(
                    case((BusRoute.stop_id == start_id, BusRoute.order))
                ).label("start_order"),
                func.min(
                    case((BusRoute.stop_id == end_id, BusRoute.order))
                ).label("end_order"),
            )
            .where(BusRoute.route_id.in_(list(list_route_ids)))
            .group_by(BusRoute.route_id)
            .subquery()
        )

        query = (
            select(
                BusRoute.order,
                BusRoute.stop_id,
                BusRoute.route_id,
                Bus.name.label("bus_name"),
                Stop.name.label("stop_name"),
                Stop.lat,
                Stop.lon,
                BusRoute.travel_time,
            )
            .join(Route, Route.id == BusRoute.route_id)
            .join(Bus, Bus.id == Route.bus_id)
            .join(Stop, Stop.id == BusRoute.stop_id)
            .where(BusRoute.route_id.in_(list(list_route_ids)))
            .order_by(BusRoute.route_id, BusRoute.order)
        )

        if route_bounds is not None:
            query = query.add_columns(
                route_bounds.c.start_order,
                route_bounds.c.end_order,
            ).join(route_bounds, route_bounds.c.route_id == BusRoute.route_id)

        return query

    async def get_1_route(self, db, start_id, end_id):
        start_query = self.get_start_subq(start_id)
        end_query = self.get_end_subq(end_id)
        transfer_points = self.get_all_route_in_start_and_end(start_query, end_query)

        res_tras = await db.execute(transfer_points) # stop_id, route_start, route_end

        list_route_ids, list_dict = self.get_route_ids_and_map(res_tras) # stop_id -> (route_start, route_end)

        all_stops_query = self.get_all_stops_for_routes(list_route_ids, start_id, end_id)
        res2 = await db.execute(all_stops_query)# order_id, stop_id,route_id, bus_name, stop_name,
        # lat, lon, time, order_start, order_end

        dict_route_map = {} # route_id -> [all_data, .... ]

        for item in res2.mappings().all():
            row_dict = dict(item)
            print()
            print(row_dict)
            print()
            route_id = row_dict.get("route_id")
            if route_id in dict_route_map:
                dict_route_map[route_id].append(row_dict)
            else:
                dict_route_map[route_id] = [row_dict]

        for key, values in dict_route_map.items():
            dict_route_map[key] = sorted(values, key= lambda x: x["order"])

        routes_with_transfer = []

        # list_dict -> stop_id, route_start, route_end
        # dict_route_map -> route_id -> list _stops
        list_map_time = {}
        for transfer in list_dict:
            transfer_stop = transfer["transfer_stop_id"]
            first_route = transfer["first_route_id"]
            second_route = transfer["second_route_id"]
            start_transfer_order = transfer["start_order"]
            end_transfer_order = transfer["end_order"]

            lst_stops_st = dict_route_map[first_route]
            lst_stops_end = dict_route_map[second_route]

            first_stops = []
            end_stops = []
            first_stops_view = []
            end_stops_view = []
            first_sum_time = 0
            end_sum_time = 0
            PENALTY_TRANSFER = 30

            get_dict = lambda obj: obj["stop_name"]
            get_bus_info = lambda obj: obj["bus_name"]
            bus_name_start = None
            bus_name_end = None

            for stop in lst_stops_st:
                stop_order = stop["order"]
                start_order_stop = stop.get("start_order")
                if start_order_stop:
                    if start_order_stop <= stop_order <= start_transfer_order:
                        travel_time = stop["travel_time"] if start_order_stop < stop_order else 0
                        first_sum_time += travel_time
                        first_stops.append(stop)
                        if bus_name_start is None:
                            bus_name_start = get_bus_info(stop)
                        first_stops_view.append(get_dict(stop))


            for stop in lst_stops_end:
                stop_order = stop["order"]
                end_order_stop = stop.get("end_order")
                if end_order_stop:
                    if end_order_stop >= stop_order >= end_transfer_order:
                        travel_time = stop["travel_time"] if end_order_stop > stop_order else 0
                        end_sum_time += travel_time
                        end_stops.append(stop)
                        end_stops_view.append(get_dict(stop))
                        if bus_name_end is None:
                            bus_name_end = get_bus_info(stop)

            full_time = first_sum_time + end_sum_time + PENALTY_TRANSFER
            # Склеиваем обе ветки

            first_route_ = {"route": first_stops}
            end_route_ = {"route": end_stops}
            full_route = {"first": first_route_, "end": end_route_}
            full_route_view = {"first": {"bus_name": bus_name_start, "stops":first_stops_view},

                               "end": {
                                   "bus_name": bus_name_end,
                                   "stops":end_stops_view}}

            if full_time not in list_map_time:
                list_map_time[full_time] = []

            get_info_front = lambda obj: {"stop_name": obj["stop_name"], "lat": obj["lat"], "lon": obj["lon"]}

            def _format_time(seconds: int) -> str:
                hours = seconds // 3600
                minutes = (seconds % 3600) // 60
                secs = seconds % 60
                return f"{hours:02d}:{minutes:02d}:{secs:02d}"

            list_map_time[full_time].append({
                "transfer_stop": get_info_front(first_stops[-1]),
                "route_start": get_info_front(first_stops[0]),
                "route_end": get_info_front(end_stops[-1]),
                "route_time": _format_time(full_time),
                "stops": full_route_view,
            })

        sorted_items = sorted(list_map_time.items(), key=lambda x: x[0])[:7]

        # Если нужно вернуть в виде списка маршрутов
        routes_with_transfer = []
        for _, routes in sorted_items:
            routes_with_transfer.extend(routes)

        return routes_with_transfer

async def formatting(db, start_id, end_id):
    result = await get_direct_routes(db, start_id, end_id)
    new_res = {"old": result, "new": {}}

    for index, item in enumerate(result):
        bus_name = item.get("bus_name")
        if bus_name not in new_res.get("new"):
            new_res["new"][bus_name] = [f"{index} - {item.get('stop_name')}"]
        else:
            new_res["new"][bus_name].append(f"{index} - {item.get('stop_name')}")


    return new_res

@search_router.get("/search")
async def get_route(request: Request, db: AsyncSession = Depends(get_async_db)):
    start_id = int(request.query_params.get("start"))
    end_id = int(request.query_params.get("stop"))
    transfer = request.query_params.get("transfer")

    print(transfer, "dappes")
    astarfinder = RouteAStarFinder()

    if int(transfer) == 0:
        return {"result": await formatting(db, start_id, end_id)}

    if int(transfer) == 1:
        oneTransRouteFinder = OneTransferRouteFinder()
        return {"result": await oneTransRouteFinder.get_1_route(db, start_id, end_id)}

    return await astarfinder.execute(start_id, end_id, db)