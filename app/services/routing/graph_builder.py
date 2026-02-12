from collections import defaultdict
from typing import Dict, List, Tuple
from sqlalchemy.ext.asyncio import AsyncSession

from app.repositories.routes_repositories import RoutingRepository

graph_cache: Tuple[defaultdict[int, List[dict]], Dict[int, dict]] | None = None


def _set_stop_info(stop, stops_info):
    if not stop:
        return

    if stop.id not in stops_info:
        stops_info[stop.id] = {"lat": stop.lat, "lon": stop.lon, "name": stop.name}


def _create_edge_for_graph(prev_stop, item, route):
    return {
        "stop_id": item.stop.id,
        "travel_time": item.travel_time,
        "route_id": route.id,
        "obj_stop": item.stop,
        "obj_stop_prev": prev_stop,
        "name_bus": route.bus.name,
    }


async def get_full_graph(db: AsyncSession) -> Tuple[defaultdict[int, List[dict]], Dict[int, dict]]:
    graph = defaultdict(list)
    seen_edges = defaultdict(set)  # prev_stop_id -> set((curr_stop_id, route_id))
    stops_info = {}

    routes = await RoutingRepository.get_routes_with_stops(db)

    for route in routes:
        stops_sorted = sorted(route.stops, key=lambda br: br.order)
        for index, item in enumerate(stops_sorted[1:], 1):  # начиная со второго
            prev_stop = stops_sorted[index - 1].stop
            curr_stop = item.stop
            edge_key = (curr_stop.id, route.id)

            # Заполняем stops_info (lat/lon)
            _set_stop_info(prev_stop, stops_info)
            _set_stop_info(curr_stop, stops_info)

            if edge_key in seen_edges[prev_stop.id]:
                continue  # уже добавлено

            seen_edges[prev_stop.id].add(edge_key)

            graph[prev_stop.id].append(_create_edge_for_graph(prev_stop, item, route))

    return graph, stops_info