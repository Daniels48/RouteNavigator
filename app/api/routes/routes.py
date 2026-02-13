from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.routes.schemas import RoutingQuery
from app.core.decorator import log_execution_time
from app.db.session_db import get_async_db
from app.services.routing.RoutingService import RoutingService


search_router = APIRouter(prefix="/search")


@search_router.get("/")
@log_execution_time
async def get_route(
    dataQuery: RoutingQuery = Depends(),
    db: AsyncSession = Depends(get_async_db),
):
    service = RoutingService()
    return await service.find_route(dataQuery.start, dataQuery.stop, db)
