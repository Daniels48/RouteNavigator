from typing import Sequence
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload
from app.db.models import BusRoute, Route, Bus
from app.services.utils import get_meters_both_coordinates


async def load_routes_with_stops(db: AsyncSession) -> Sequence[Route]:
    query = (
        select(Route)
        .join(BusRoute)
        .options(
            selectinload(Route.bus).selectinload(Bus.schedule),
            selectinload(Route.stops).selectinload(BusRoute.stop)
        )
    )
    result = await db.execute(query)
    return result.scalars().all()

def calculate_travel_times_for_route(route: Route) -> None:
    bus = route.bus
    stops_sorted = sorted(route.stops, key=lambda br: br.order)

    for index in range(1, len(stops_sorted)):
        prev_item = stops_sorted[index - 1]
        item = stops_sorted[index]

        from_coord = (prev_item.stop.lat, prev_item.stop.lon)
        to_coord = (item.stop.lat, item.stop.lon)

        meters = get_meters_both_coordinates(from_coord, to_coord)

        speed_m_s = bus.speed * 1000 / 3600
        stop_time_sec = (
            bus.time_stop.hour * 3600
            + bus.time_stop.minute * 60
            + bus.time_stop.second
        )

        item.travel_time = int(meters / speed_m_s + stop_time_sec)

async def recalculate_all_travel_time(db: AsyncSession) -> None:
    routes = await load_routes_with_stops(db)

    for route in routes:
        calculate_travel_times_for_route(route)

async def recalculate_and_commit(db: AsyncSession) -> None:
    try:
        await recalculate_all_travel_time(db)
        await db.commit()
    except Exception:
        await db.rollback()
        raise