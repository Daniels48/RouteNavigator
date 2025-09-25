from datetime import time, datetime, timedelta
from fastapi import APIRouter, Depends, Request
from sqlalchemy import select, func
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import aliased, selectinload

from app.db.models import BusRoute, Route, Bus, Stop
from app.db.session_db import get_async_db


from app.services.graph import get_cached_graph

search_router = APIRouter()


async def search_bus(request: Request, db: AsyncSession = Depends(get_async_db)):
    start = request.query_params.get("start")
    stop = request.query_params.get("stop")

    start = int(start)
    stop = int(stop)

    br_start = aliased(BusRoute)
    br_stop = aliased(BusRoute)

    # Подзапрос: маршруты, содержащие start и stop
    valid_routes = (
        select(Route.id)
        .join(br_start, Route.id == br_start.route_id)
        .join(br_stop, Route.id == br_stop.route_id)
        .where(br_start.stop_id == start)
        .where(br_stop.stop_id == stop)
        .where(br_start.order < br_stop.order)
        .subquery()
    )

    br_all = aliased(BusRoute)

    query = (
        select(
            Route.id,
            Route.name,
            Bus.name.label("bus_name"),
            func.jsonb_agg(
                func.jsonb_build_object(
                    "id", Stop.id,
                    "name", Stop.name,
                    "lat", Stop.lat,
                    "lon", Stop.lon,
                    "order", br_all.order
                )
            ).label("stops")
        )
        .join(Bus, Route.bus_id == Bus.id)
        .join(br_all, Route.id == br_all.route_id)
        .join(Stop, Stop.id == br_all.stop_id)
        .where(Route.id.in_(select(valid_routes.c.id)))
        .group_by(Route.id, Route.name, Bus.name)
        .order_by(Route.id)
    )

    result = await db.execute(query)
    routes = result.mappings().all()
    return routes

def generate_schedule(start_time: time, end_time: time, interval_minutes: int):
    schedule = []
    current = datetime.combine(datetime.today(), start_time)
    end = datetime.combine(datetime.today(), end_time)

    while current <= end:
        schedule.append(current.time())
        current += timedelta(minutes=interval_minutes)

    return schedule


class MinHeap:
    def __init__(self):
        self.data = []

    def push(self, item):
        self.data.append(item)
        self._sift_up(len(self.data) - 1)

    def pop(self):
        if not self.data:
            return None
        self.data[0], self.data[-1] = self.data[-1], self.data[0]
        item = self.data.pop()
        self._sift_down(0)
        return item

    def _sift_up(self, index):
        parent = (index - 1) // 2
        while index > 0:
            if self.data[index][:2] < self.data[parent][:2]:
                self.data[index], self.data[parent] = self.data[parent], self.data[index]
                index = parent
                parent = (index - 1) // 2
            else:
                break

    def _sift_down(self, index):
        child = 2 * index + 1
        while child < len(self.data):
            right = child + 1
            if right < len(self.data) and self.data[right][:2] < self.data[child][:2]:
                child = right
            if self.data[index][:2] <= self.data[child][:2]:
                break
            self.data[index], self.data[child] = self.data[child], self.data[index]
            index = child
            child = 2 * index + 1

def format_path_with_transfers(path_edges, total_time, transfers):
    if not path_edges:
        return None

    routes_res = {}
    current_bus = None
    current_segment = []

    def obj_to_dict(obj):
        return {"name": obj.name, "lat": obj.lat, "lon": obj.lon}

    for i, edge in enumerate(path_edges):
        bus_name = edge["bus_name"]
        obj_prev = edge.get("obj_stop_prev")
        obj_curr = edge["obj_stop"]

        # Начало нового маршрута
        if bus_name != current_bus:
            if current_bus is not None:
                # Сохраняем предыдущий сегмент
                routes_res[current_bus] = current_segment
            current_segment = []
            # Добавляем стыковочную остановку (если есть)
            if obj_prev is not None:
                current_segment.append(obj_to_dict(obj_prev))
            current_bus = bus_name

        # Добавляем текущую остановку
        current_segment.append(obj_to_dict(obj_curr))

    # Сохраняем последний сегмент
    if current_bus is not None:
        routes_res[current_bus] = current_segment

    return {
        "from": obj_to_dict(path_edges[0]["obj_stop_prev"]),
        "to": obj_to_dict(path_edges[-1]["obj_stop"]),
        "travel_time": total_time,
        "transfers": transfers,
        "routes": routes_res
    }


#
# def format_path_with_transfers(path_edges, total_time, transfers):
#     if not path_edges:
#         return None
#
#     routes_res = {}
#     current_bus = None
#
#     obj_start = path_edges[0].get("obj_stop_prev")
#     obj_finish = path_edges[-1].get("obj_stop")
#
#     def format_seconds(seconds: int) -> str:
#         h = seconds // 3600
#         m = (seconds % 3600) // 60
#         s = seconds % 60
#         return f"{h:02}:{m:02}:{s:02}"
#
#     get_valid_dict = lambda obj: {"name": obj.name, "lat": obj.lat, "lon": obj.lon}
#
#     # Добавляем первую остановку
#     first_edge = path_edges[0]
#     first_bus = first_edge["bus_name"]
#     first_stop = first_edge["obj_stop_prev"]  # предположительно объект Stop предыдущей остановки
#     routes_res[first_bus] = [get_valid_dict(first_stop)]
#     current_bus = first_bus
#
#     for edge in path_edges:
#         bus_name = edge["bus_name"]
#         obj_stop = edge["obj_stop"]
#
#         if bus_name not in routes_res:
#             routes_res[bus_name] = []
#
#         # Если сменился автобус — добавляем первую остановку нового сегмента
#         if bus_name != current_bus:
#             routes_res[bus_name].append(get_valid_dict(edge["obj_stop_prev"]))
#
#         # Добавляем текущую остановку
#         routes_res[bus_name].append(get_valid_dict(obj_stop))
#         current_bus = bus_name
#
#     return {
#         "from": get_valid_dict(obj_start),
#         "to": get_valid_dict(obj_finish),
#         "travel_time": format_seconds(int(total_time)),
#         "transfers": transfers,
#         "routes": routes_res
#     }


def dijkstra_routes(graph, start, end):
    """
    graph: { stop_id: [ {"stop_id", "travel_time", "route_id", "obj_stop", "name_bus"} ] }
    Возвращает путь с минимальным временем и минимальным числом пересадок.
    """
    heap = MinHeap()
    heap.push((0, 0, start, [], None))  # (curr_time, transfers, stop_id, path_edges, last_route_id)
    visited = dict()  # stop_id -> (min_time, min_transfers)

    while True:
        item = heap.pop()
        if not item:
            break

        curr_time, transfers, stop_id, path_edges, last_route_id = item

        if stop_id in visited:
            old_time, old_transfers = visited[stop_id]
            if curr_time > old_time or (curr_time == old_time and transfers >= old_transfers):
                continue

        visited[stop_id] = (curr_time, transfers)

        if stop_id == end:
            return path_edges, curr_time, transfers

        for edge in graph.get(stop_id, []):
            next_stop = edge["stop_id"]
            travel_time = edge["travel_time"]
            route_id = edge["route_id"]

            new_transfers = transfers + (0 if route_id == last_route_id else 1)

            new_path_edges = path_edges + [{
                "from_stop": stop_id,
                "stop_id": next_stop,
                "route_id": route_id,
                "travel_time": travel_time,
                "obj_stop": edge["obj_stop"],
                "obj_stop_prev": edge["obj_stop_prev"],
                "bus_name": edge["name_bus"]
            }]

            heap.push((curr_time + travel_time, new_transfers, next_stop, new_path_edges, route_id))

    return None, None, None  # путь не найден


@search_router.get("/search")
async def search(request: Request, db: AsyncSession = Depends(get_async_db)):
    start_id = int(request.query_params.get("start"))
    end_id = int(request.query_params.get("stop"))
    time_ = request.query_params.get("time")  # можно использовать для фильтрации расписания

    # 1. Граф с кешированием
    graph = await get_cached_graph(db)

    path_edges, curr_time, transfers = dijkstra_routes(graph, start_id, end_id)
    print()
    print(1)
    print()
    if not path_edges:
        return {"result": None}

    # 5. Форматируем путь с пересадками
    formatted = format_path_with_transfers(path_edges, curr_time, transfers)
    print(2)
    return {"result": formatted}







    name_start = None
    name_stop = None

    # if len(time_.split(":")) == 1:
    #     time_ = f"{time_}:00"
    # elif len(time_.split(":")) == 2:
    #     time_ = f"{time_}:00"
    #
    # parts = time_.split(":")
    # if len(parts) == 2:
    #     time_ += ":00"  # "08:00" → "08:00:00"
    #
    # # превращаем в datetime.time
    # time_obj = datetime.strptime(time_, "%H:%M:%S").time()
    # time_dt = datetime.combine(datetime.today(), time_obj)
    # time_dt_plus_1h = time_dt + timedelta(minutes=30)
    #
    # # time_2 = datetime.strptime(time_, "%H:%M:%S")
    # # delta = time_2 + timedelta(minutes=30)
    #
    # stmt = (
    #     select(Route)
    #     .join(BusRoute)
    #     .where(BusRoute.stop_id == int(start))
    #     .options(
    #         selectinload(Route.bus).selectinload(Bus.schedule),
    #         selectinload(Route.stops).selectinload(BusRoute.stop)
    #     )
    # )
    #
    # result = await db.execute(stmt)
    # routes = result.scalars().all()
    #
    # # Пример обработки
    # data = []
    # for route in routes:
    #     bus = route.bus
    #     schedule = bus.schedule if bus else None
    #
    #     times_for_bus = generate_schedule(start_time=schedule.start_time,
    #                                       end_time=schedule.end_time,
    #                                       interval_minutes=schedule.interval_minutes
    #                                       )
    #     stops_sorted = sorted(route.stops, key=lambda br: br.order)
    #     time_list_start = None
    #     time_list_stop = None
    #     for time__ in times_for_bus:
    #         time_end = datetime.combine(datetime.today(), time__)
    #
    #         for indx, item in enumerate(stops_sorted):
    #             valid_start = int(start) == int(item.stop.id)
    #             valid_stop = int(stop) == int(item.stop.id)
    #             if valid_start or valid_stop :
    #                 if valid_start:
    #                     name_start = item.stop.name
    #                     if time_dt < time_end < time_dt_plus_1h:
    #                         time_list_start = time_end.strftime("%H:%M:%S")
    #
    #                 if valid_stop:
    #                     name_stop = item.stop.name
    #                     time_list_stop = time_end.strftime("%H:%M:%S")
    #                     break
    #             else:
    #                 item_pre = stops_sorted[indx-1]
    #                 from_coordinate = (item_pre.stop.lat, item_pre.stop.lon)
    #                 to_coord = (item.stop.lat, item.stop.lon)
    #                 meters = get_meters_both_coordinates(from_coordinate, to_coord)  # (lat lon), (lat,lon)
    #                 time_put = meters / (bus.speed * 1000 / 3600)
    #                 time_end += timedelta(seconds=time_put)
    #                 stop_minutes = bus.time_stop.hour * 60 + bus.time_stop.minute + bus.time_stop.second / 60
    #                 time_end += timedelta(minutes=stop_minutes)
    #
    #         if name_stop and name_start:
    #             break
    #     if time_list_stop and time_list_start:
    #         t1 = datetime.strptime(time_list_stop, "%H:%M:%S")
    #         t2 = datetime.strptime(time_list_start, "%H:%M:%S")
    #         delta = t1-t2
    #         hours, remainder = divmod(delta.seconds, 3600)
    #         minutes, seconds = divmod(remainder, 60)
    #
    #         if time_list_start:
    #             data.append (
    #                 {"bus": bus.name,
    #                  "from": name_start,
    #                   "to_": name_stop,
    #                  "time_start": time_list_start,
    #                  "time_finish": time_list_stop,
    #                  "time_delta": f"{hours:02}:{minutes:02}:{seconds:02}"
    #                  }
    #             )
    #
    # return {"len":len(data) ,"result": data}
    return {"result": "ok"}


