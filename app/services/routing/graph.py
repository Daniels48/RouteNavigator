from collections import defaultdict
from typing import Dict, List, Tuple
from sqlalchemy.ext.asyncio import AsyncSession

from app.services.routing.graph_builder import get_full_graph


graph_cache: Tuple[defaultdict[int, List[dict]], Dict[int, dict]] | None = None


async def get_cached_graph(db: AsyncSession) -> Tuple[defaultdict[int, List[dict]], Dict[int, dict]]:
    global graph_cache
    if graph_cache is None:
        graph_cache = await get_full_graph(db)
    return graph_cache