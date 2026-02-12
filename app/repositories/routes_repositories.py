from typing import Sequence
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.db.models import Route, BusRoute


class RoutingRepository:

    @staticmethod
    async def get_routes_with_stops(
        db: AsyncSession
    ) -> Sequence[Route]:
        query = (
            select(Route)
            .join(BusRoute)
            .options(
                selectinload(Route.bus),
                selectinload(Route.stops).selectinload(BusRoute.stop)
            )
        )

        result = await db.execute(query)
        return result.scalars().all()
