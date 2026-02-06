from geopy.distance import geodesic
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload
from app.db.models import BusRoute, Route, Bus


def get_meters_both_coordinates(from_, to_):
    return geodesic(from_, to_).meters # lat,lon

async def recalculate_all_travel_time(db: AsyncSession):
    query = (
        select(Route)
        .join(BusRoute)
        .options(
            selectinload(Route.bus).selectinload(Bus.schedule),
            selectinload(Route.stops).selectinload(BusRoute.stop)
        )
    )
    result = await db.execute(query)
    routes = result.scalars().all()

    for route in routes:
        bus = route.bus
        stops_sorted = sorted(route.stops, key=lambda br: br.order)
        for index, item in enumerate(stops_sorted):
                if index > 0 :
                    item_pre = stops_sorted[index - 1]
                    from_coordinate = (item_pre.stop.lat, item_pre.stop.lon)
                    to_coord = (item.stop.lat, item.stop.lon)
                    meters = get_meters_both_coordinates(from_coordinate, to_coord)  # (lat lon), (lat,lon)
                    time_put_sec = meters / (bus.speed * 1000 / 3600)
                    stop_time_sec = bus.time_stop.hour * 3600 + bus.time_stop.minute * 60 + bus.time_stop.second
                    time_travel_sec = int(time_put_sec + stop_time_sec)
                    item.travel_time = time_travel_sec
    await db.commit()