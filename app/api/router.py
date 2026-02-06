from fastapi import APIRouter
from .bus_routers.routes import bus_routers
from app.services.routing.search_bus_for_route import search_router

api_router = APIRouter()
api_router.include_router(bus_routers)
api_router.include_router(search_router)
