from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.buses.schemas import BusQuery
from app.core.decorator import log_execution_time
from app.db.session_db import get_async_db

from app.repositories.bus_repositories import BusRepository
from app.services.routing.formatter import Formatter

bus_routers = APIRouter(prefix="/bus_view")


@bus_routers.post("/")
@log_execution_time
async def view_route(dataQuery: BusQuery, db: AsyncSession = Depends(get_async_db)):
    bus_id = dataQuery.id

    routes = await BusRepository.get_routes_with_stops_by_bus_id(db, bus_id)

    bus_routes_list = Formatter.format_routes_for_view(routes)

    return {"result": bus_routes_list}