from fastapi import APIRouter

from app.api.buses.routes import bus_routers
from app.api.routes.routes import search_router

api_router = APIRouter()

api_router.include_router(bus_routers)
api_router.include_router(search_router)
