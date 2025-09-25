from collections import defaultdict
from typing import Optional, List, Dict

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.db.models import Route, BusRoute

graph_cache: Optional[defaultdict[int, List[Dict[str, int]]]] = None


async def get_full_graph(db: AsyncSession) -> defaultdict[int, list]:
    graph = defaultdict(list)
    seen_edges = defaultdict(set)  # prev_stop_id -> set((curr_stop_id, route_id))

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
            prev_stop_id = stops_sorted[index - 1].stop.id
            curr_stop_id = item.stop.id
            edge_key = (curr_stop_id, route.id)

            if edge_key in seen_edges[prev_stop_id]:
                continue  # уже добавлено

            seen_edges[prev_stop_id].add(edge_key)
            graph[prev_stop_id].append({
                "stop_id": curr_stop_id,
                "travel_time": item.travel_time,
                "route_id": route.id,
                "obj_stop": item.stop,
                "name_bus": route.bus.name,
                "obj_stop_prev": stops_sorted[index - 1].stop
            })

    return graph

async def get_cached_graph(db: AsyncSession) -> defaultdict[int, List[Dict[str, int]]]:
    global graph_cache
    if graph_cache is None:
        graph_cache = await get_full_graph(db)
    return graph_cache