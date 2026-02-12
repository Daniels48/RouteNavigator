# from sqlalchemy.ext.asyncio import AsyncSession
# from sqlalchemy.future import select
# from sqlalchemy.orm import joinedload
#
# from app.db.models import Route
# from app.db.models.bus_route_models import BusRoute
#
# class BusService:
#
#     @staticmethod
#     async def create_routes(db: AsyncSession, data):
#         for item in data:
#             db.add(
#                 BusRoute(
#                     order=item.order,
#                     stop_id=item.obj.id
#                 )
#             )
#         await db.commit()
#         return {"status": "ok"}
#
#     @staticmethod
#     async def view_routes(db: AsyncSession, bus_id: int):
#         stmt = (
#             select(Route)
#             .options(joinedload(Route.stops).joinedload(BusRoute.stop))
#             .where(Route.bus_id == bus_id)
#         )
#
#         result = await db.execute(stmt)
#         routes = result.unique().scalars().all()
#
#         bus_routes_list = []
#         for route in routes:
#             stops_list = [
#                 {
#                     "order": br.order,
#                     "name": br.stop.name,
#                     "lat": br.stop.lat,
#                     "lon": br.stop.lon,
#                 }
#                 for br in sorted(route.stops, key=lambda br: br.order)
#             ]
#
#             bus_routes_list.append({
#                 "route_id": route.id,
#                 "route_name": route.name,
#                 "stops": stops_list
#             })
#
#         return {"result": bus_routes_list}
#
#
#
#
#
#
#
#
#
#
# from typing import List
#
# from fastapi import APIRouter, Depends
# from sqlalchemy.ext.asyncio import AsyncSession, session
# from sqlalchemy.future import select
# from sqlalchemy.orm import joinedload
#
# from app.api.bus_routers.schemas import BusRouteData, BusName
# from app.db.models import Route
# from app.db.session_db import get_async_db
#
# from app.db.models.bus_route_models import BusRoute
#
# bus_routers = APIRouter()
#
# @bus_routers.post("/bus_routes")
# async def create_route(data: List[BusRouteData], db: AsyncSession = Depends(get_async_db)):
#     for item in data:
#         db.add(BusRoute(
#             order = item.order,
#             stop_id = item.obj.id
#         ))
#     await db.commit()
#     return {"status": "ok", "data": data}
#
# @bus_routers.post("/bus_view")
# async def view_route(data: BusName, db: AsyncSession = Depends(get_async_db)):
#     bus_id = data.id
#
#     # Берём все маршруты автобуса с их остановками
#     stmt = (
#         select(Route)
#         .options(joinedload(Route.stops).joinedload(BusRoute.stop))
#         .where(Route.bus_id == bus_id)
#     )
#
#     result = await db.execute(stmt)
#     routes = result.unique().scalars().all()
#
#     # Формируем JSON по маршрутам
#     bus_routes_list = []
#     for route in routes:
#         stops_list = [
#             {
#                 "order": br.order,
#                 "name": br.stop.name if br.stop else None,
#                 "lat": br.stop.lat if br.stop else None,
#                 "lon": br.stop.lon if br.stop else None
#             }
#             for br in sorted(route.stops, key=lambda br: br.order)
#         ]
#         bus_routes_list.append({
#             "route_id": route.id,
#             "route_name": route.name,
#             "stops": stops_list
#         })
#
#
#     return {"result": bus_routes_list}