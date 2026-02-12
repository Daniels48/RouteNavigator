from fastapi import APIRouter

from app.views.map.router import map_router

web_router = APIRouter()
web_router.include_router(map_router)