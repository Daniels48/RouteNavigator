from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.orm import joinedload

from app.db.models import Route, Bus
from app.db.models.bus_route_models import BusRoute


class BusRepository:

    @staticmethod
    async def get_routes_with_stops_by_bus_id(
        db: AsyncSession,
        bus_id: int
    ) -> list[Route]:
        stmt = (
            select(Route)
            .options(
                joinedload(Route.stops)
                .joinedload(BusRoute.stop)
            )
            .where(Route.bus_id == bus_id)
        )

        result = await db.execute(stmt)
        return list(result.unique().scalars())

    @staticmethod
    async def get_list_bus(db: AsyncSession) -> list[dict]:
        query = select(Bus.id, Bus.name)
        result = await db.execute(query)

        return [dict(row) for row in result.mappings().all()]

