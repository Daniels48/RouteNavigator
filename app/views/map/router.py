import logging

from fastapi import Request, Depends, APIRouter
from sqlalchemy.ext.asyncio import AsyncSession

from app.core.decorator import log_execution_time
from app.core.templates import templates
from app.db.session_db import get_async_db

from app.repositories.bus_repositories import BusRepository
from app.repositories.stop_respositories import StopRepository

map_router = APIRouter()
logger = logging.getLogger(__name__)


@map_router.get("/")
@log_execution_time
async def show_map(request: Request, db: AsyncSession = Depends(get_async_db)):
    list_bus = await BusRepository.get_list_bus(db)
    list_stops = await StopRepository.get_all(db)
    return templates.TemplateResponse("map.html", {"request": request, "stops": list_stops, "bus": list_bus})