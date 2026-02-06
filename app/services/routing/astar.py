from sqlalchemy.ext.asyncio import AsyncSession
from app.services.routing.graph import get_cached_graph
from app.services.routing.travel_time import get_meters_both_coordinates


class MinHeap:
    def __init__(self, count_param: int = 3):
        self.count_param = count_param # s_score, current_time, transfers,
        self.data = []

    def push(self, item):
        self.data.append(item)
        last_index_item = len(self.data) - 1
        self._sift_up(last_index_item)

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
            if self.data[parent][:self.count_param] > self.data[index][:self.count_param]:
                self.data[index], self.data[parent] = self.data[parent], self.data[index]
                index = parent
                parent = (index - 1) // 2
            else:
                break

    def _sift_down(self, parent):
        left_child = 2 * parent + 1
        max_index = len(self.data)
        while left_child < max_index:
            right_child = left_child + 1
            left_child = self._get_smaller_child_index(right_child, left_child)

            if self.data[parent][:self.count_param] > self.data[left_child][:self.count_param]:
                self.data[parent], self.data[left_child] = self.data[left_child], self.data[parent]
                parent = left_child
                left_child = 2 * parent + 1
            else:
                break

    def _get_smaller_child_index(self, right_child_idx, left_child_idx):
        if right_child_idx < len(self.data) and self.data[right_child_idx][:self.count_param] < self.data[left_child_idx][:self.count_param]:
            left_child_idx = right_child_idx
        return left_child_idx


class RouteAStarFinder:
    def __init__(self):
        self.avg_speed_m_s = 5 # 18 km/h
        self.TRANSFER_PENALTY = 30 # sec

    async def execute(self, start_id: int, end_id: int, db: AsyncSession):
        graph, stops_info = await get_cached_graph(db)

        path_edges, curr_time, transfers = self._astar_routes_all_buses(graph, stops_info, start_id, end_id)

        if not path_edges:
            return {"result": None}
        else:
            formatted = self._format_path_with_transfers(path_edges, curr_time, transfers)
            return {"result": formatted}

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

    def _astar_routes_all_buses(self, graph, stops_info, start, end_id):
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

    def _format_path_with_transfers(self, path_edges, total_time, transfers):
        if not path_edges:
            return None

        routes_res = {}
        routes_view_res = {}
        prev_bus = None
        col_ = 0

        get_key = lambda name_bus, count: f"{name_bus};  {count}-ая пересадка"

        for i, edge in enumerate(path_edges):
            bus_name = edge["bus_name"]
            obj_prev = self._obj_to_dict(edge.get("obj_stop_prev"))
            obj_curr = self._obj_to_dict(edge["obj_stop"])
            obj_prev_name = self._obj_to_dict_name(obj_prev, i, False)
            obj_curr_name = self._obj_to_dict_name(obj_curr, i)

            # Начало первого маршрута
            if prev_bus is None:
                routes_res[get_key(bus_name, col_)] = [obj_curr]
                routes_view_res[get_key(bus_name, col_)] = [obj_curr_name]
                prev_bus = bus_name
            else:
                if bus_name != prev_bus:
                    col_ += 1
                    prev_bus = bus_name
                    routes_res[get_key(bus_name, col_)] = [obj_prev, obj_curr]
                    routes_view_res[get_key(bus_name, col_)] = [obj_prev_name, obj_curr_name]
                else:
                    routes_res[get_key(bus_name, col_)].append(obj_curr)
                    routes_view_res[get_key(bus_name, col_)].append(obj_curr_name)

        return {
            "from": self._obj_to_dict(path_edges[0]["obj_stop"]),
            "to": self._obj_to_dict(path_edges[-1]["obj_stop"]),
            "travel_time": self._format_time(total_time),
            "transfers": transfers,
            "routes": routes_res,
            "count_stops": len(path_edges) - 1,
            "routes_view": routes_view_res
        }

    @staticmethod
    def _obj_to_dict(obj):
        if not obj:
            return None
        list_val = ("name", "lat", "lon")
        get_value = lambda obj_, name: obj.get(name) if isinstance(obj, dict) else getattr(obj, name, None)
        return {name: get_value(obj, name) for name in list_val}

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

    @staticmethod
    def _format_time(seconds: int) -> str:
        hours = seconds // 3600
        minutes = (seconds % 3600) // 60
        secs = seconds % 60
        return f"{hours:02d}:{minutes:02d}:{secs:02d}"

    @staticmethod
    def _obj_to_dict_name(obj, index, current=True):
        value = None
        if obj:
            raw_value = obj.get("name") if isinstance(obj, dict) else obj.name
            value = f"{index if index > 0 and current else '-'} {raw_value}"
        return value