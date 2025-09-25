from typing import List

from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from app.api.bus_routers.schemas import BusRouteData
from app.db.session_db import get_async_db

from app.db.models.bus_route_models import BusRoute

bus_routers = APIRouter()

@bus_routers.post("/bus_routes")
async def create_route(data: List[BusRouteData], db: AsyncSession = Depends(get_async_db)):
    for item in data:
        db.add(BusRoute(
            order = item.order,
            stop_id = item.obj.id
        ))
    await db.commit()
    return {"status": "ok", "data": data}