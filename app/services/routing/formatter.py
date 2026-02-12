from typing import Any, Dict, List, Optional


StopDict = Dict[str, Any]
PathEdge = Dict[str, Any]


class Formatter:
    @staticmethod
    def format_path_with_transfers(
        path_edges: List[PathEdge],
        total_time: float,
        transfers: int
    ) -> Optional[Dict[str, Any]]:
        if not path_edges:
            return None

        routes_res: Dict[str, List[StopDict]] = {}
        routes_view_res: Dict[str, List[str]] = {}
        prev_bus: Optional[str] = None
        col_: int = 0

        def get_key(name_bus: str, count: int) -> str:
            return f"{name_bus};  {count}-ая пересадка"

        for i, edge in enumerate(path_edges):
            bus_name: str = edge["bus_name"]

            obj_prev: Optional[StopDict] = Formatter._obj_to_dict(
                edge.get("obj_stop_prev")
            )
            obj_curr: Optional[StopDict] = Formatter._obj_to_dict(
                edge["obj_stop"]
            )

            obj_prev_name: Optional[str] = Formatter._obj_to_dict_name(
                obj_prev, i, current=False
            )
            obj_curr_name: Optional[str] = Formatter._obj_to_dict_name(
                obj_curr, i
            )

            if prev_bus is None:
                routes_res[get_key(bus_name, col_)] = [obj_curr]
                routes_view_res[get_key(bus_name, col_)] = [obj_curr_name]
                prev_bus = bus_name
            else:
                if bus_name != prev_bus:
                    col_ += 1
                    prev_bus = bus_name
                    routes_res[get_key(bus_name, col_)] = [obj_prev, obj_curr]
                    routes_view_res[get_key(bus_name, col_)] = [
                        obj_prev_name,
                        obj_curr_name,
                    ]
                else:
                    routes_res[get_key(bus_name, col_)].append(obj_curr)
                    routes_view_res[get_key(bus_name, col_)].append(obj_curr_name)

        return {
            "from": Formatter._obj_to_dict(path_edges[0]["obj_stop"]),
            "to": Formatter._obj_to_dict(path_edges[-1]["obj_stop"]),
            "travel_time": Formatter._format_time(total_time),
            "transfers": transfers,
            "routes": routes_res,
            "count_stops": len(path_edges) - 1,
            "routes_view": routes_view_res,
        }

    @staticmethod
    def _obj_to_dict_name(
        obj: Optional[StopDict],
        index: int,
        current: bool = True
    ) -> Optional[str]:
        if not obj:
            return None

        raw_value: Optional[str] = obj.get("name")
        if raw_value is None:
            return None

        prefix = index if index > 0 and current else "-"
        return f"{prefix} {raw_value}"

    @staticmethod
    def _obj_to_dict(obj: Optional[Any]) -> Optional[StopDict]:
        if not obj:
            return None

        keys = ("name", "lat", "lon")
        result: StopDict = {}

        for key in keys:
            if isinstance(obj, dict):
                result[key] = obj.get(key)
            else:
                result[key] = getattr(obj, key, None)

        return result

    @staticmethod
    def _format_time(seconds: float) -> str:
        total_seconds: int = int(seconds)
        hours: int = total_seconds // 3600
        minutes: int = (total_seconds % 3600) // 60
        secs: int = total_seconds % 60
        return f"{hours:02d}:{minutes:02d}:{secs:02d}"


    @staticmethod
    def format_routes_for_view(routes):
        # Формируем JSON по маршрутам
        bus_routes_list = []
        for route in routes:
            stops_list = [
                {
                    "order": br.order,
                    "name": br.stop.name if br.stop else None,
                    "lat": br.stop.lat if br.stop else None,
                    "lon": br.stop.lon if br.stop else None
                }
                for br in sorted(route.stops, key=lambda br: br.order)
            ]
            bus_routes_list.append({
                "route_id": route.id,
                "route_name": route.name,
                "stops": stops_list
            })

        return bus_routes_list


