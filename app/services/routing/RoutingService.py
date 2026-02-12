from app.services.routing.finders.astar import RouteAStarFinder
from app.services.routing.formatter import Formatter
from app.services.routing.graph import get_cached_graph


class RoutingService:
    def __init__(self):
        self.finder = RouteAStarFinder()

    async def find_route(self, start_id: int, end_id: int, db):
        graph, stops_info = await get_cached_graph(db)

        path, time, transfers = self.finder.find(
            graph, stops_info, start_id, end_id
        )

        if not path:
            return {"result": None}

        return {
            "result": Formatter.format_path_with_transfers(path, time, transfers)
        }
