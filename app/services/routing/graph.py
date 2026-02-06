from collections import defaultdict
from typing import Optional, List, Dict, Tuple

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.db.models import Route, BusRoute

graph_cache: Tuple[defaultdict[int, List[dict]], Dict[int, dict]] | None = None


async def get_full_graph(db: AsyncSession) -> Tuple[defaultdict[int, List[dict]], Dict[int, dict]]:
    graph = defaultdict(list)
    seen_edges = defaultdict(set)  # prev_stop_id -> set((curr_stop_id, route_id))
    stops_info = {}

    query = (
        select(Route)
        .join(BusRoute)
        .options(
            selectinload(Route.bus),
            selectinload(Route.stops).selectinload(BusRoute.stop)
        )
    )
    result = await db.execute(query)
    routes = result.scalars().all()

    for route in routes:
        stops_sorted = sorted(route.stops, key=lambda br: br.order)
        for index, item in enumerate(stops_sorted[1:], 1):  # начиная со второго
            prev_stop = stops_sorted[index - 1].stop
            curr_stop = item.stop
            edge_key = (curr_stop.id, route.id)

            # Заполняем stops_info (lat/lon)
            if prev_stop.id not in stops_info:
                stops_info[prev_stop.id] = {"lat": prev_stop.lat, "lon": prev_stop.lon, "name": prev_stop.name}
            if curr_stop.id not in stops_info:
                stops_info[curr_stop.id] = {"lat": curr_stop.lat, "lon": curr_stop.lon, "name": curr_stop.name}


            if edge_key in seen_edges[prev_stop.id]:
                continue  # уже добавлено

            seen_edges[prev_stop.id].add(edge_key)
            graph[prev_stop.id].append({
                "stop_id": curr_stop.id,
                "travel_time": item.travel_time,
                "route_id": route.id,
                "obj_stop": item.stop,
                "name_bus": route.bus.name,
                "obj_stop_prev": stops_sorted[index - 1].stop
            })

    return graph, stops_info

async def get_cached_graph(db: AsyncSession) -> Tuple[defaultdict[int, List[dict]], Dict[int, dict]]:
    global graph_cache
    if graph_cache is None:
        graph_cache = await get_full_graph(db)
    return graph_cache