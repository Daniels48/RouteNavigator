from app.services.routing.heap import MinHeap
from app.services.utils import get_meters_both_coordinates


class RouteAStarFinder:
    def __init__(self):
        self.avg_speed_m_s = 5 # 18 km/h
        self.TRANSFER_PENALTY = 30 # sec


    def find(self, graph, stops_info, start, end_id):
        heap = MinHeap()

        self._add_first_stop_in_heap(graph, start, end_id, stops_info, heap)

        visited = dict() #(stop_id, route_id) -> (min_time, min_transfers)

        while True:
            item = heap.pop()
            if not item:
                break

            s_score, current_time, transfers, stop_id, route_id, path_edges = item
            key = (stop_id, route_id)

            if not self._check_worse_path(key, current_time, transfers, visited):
                visited[key] = (current_time, transfers)

                if stop_id == end_id:
                    return path_edges, current_time, transfers

                for edge in graph.get(stop_id, []):
                    new_edge = self._create_new_edge(edge, transfers, route_id, current_time, end_id, stops_info, path_edges, stop_id)
                    heap.push(new_edge)

        return None, None, None


    def _add_first_stop_in_heap(self, graph, start, end_id, stops_info, heap):
        for edge in graph[start]:
            route_id = edge["route_id"]
            travel_time = edge["travel_time"]
            stop_id = edge["stop_id"]
            s_score = travel_time + self._get_heuristic_time(stop_id, end_id, stops_info)

            first_path_edge = (
                {
                    "from_stop": None,
                    "stop_id": start,
                    "route_id": route_id,
                    "travel_time": 0,
                    "obj_stop": stops_info.get(start),
                    "obj_stop_prev": None,
                    "bus_name": edge["name_bus"]
                },
                self._create_new_path_edge(start, edge),
            )

            heap.push((s_score, travel_time, 0, stop_id, route_id, first_path_edge))

    def _create_new_edge(self, edge, transfers, route_id, current_time, end_id, stops_info, path_edges, stop_id):
        next_stop = edge["stop_id"]
        next_route_id = edge["route_id"]
        travel_time = edge["travel_time"]

        new_transfers = transfers + (0 if next_route_id == route_id else 1)
        new_current_time = current_time + travel_time
        new_h_score = self._get_heuristic_time(next_stop, end_id, stops_info)

        is_transfer = 0 if next_route_id == route_id else 1
        s_score = new_current_time + new_h_score + is_transfer * self.TRANSFER_PENALTY

        new_edge = self._create_new_path_edge(stop_id, edge)
        new_path_edges = path_edges + (new_edge, )

        return s_score, new_current_time, new_transfers, next_stop, next_route_id, new_path_edges

    def _get_heuristic_time(self, stop_id, end_id, stops_info):
        from_, to_ = stops_info[stop_id], stops_info[end_id]
        distance_m = get_meters_both_coordinates((from_["lat"], from_["lon"]), (to_["lat"], to_["lon"]))
        time_to_end_sec = distance_m / self.avg_speed_m_s
        return time_to_end_sec

    def _check_worse_path(self, key, current_time, transfers, visited):
        score_with_penalty = current_time + transfers * self.TRANSFER_PENALTY

        if key in visited:
            old_time, old_transfers = visited[key]
            old_score = old_time + old_transfers * self.TRANSFER_PENALTY
            if score_with_penalty >= old_score:
                return True

        return False

    @staticmethod
    def _create_new_path_edge(stop_id, edge):
        return {
            "from_stop": stop_id,
            "stop_id": edge["stop_id"],
            "route_id": edge["route_id"],
            "travel_time": edge["travel_time"],
            "obj_stop": edge["obj_stop"],
            "obj_stop_prev": edge["obj_stop_prev"],
            "bus_name": edge["name_bus"]
        }