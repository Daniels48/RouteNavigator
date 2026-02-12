from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.db.models import Stop


class StopRepository:

    @staticmethod
    async def get_all(db: AsyncSession) -> list[dict]:
        query = select(Stop.id, Stop.name, Stop.lat, Stop.lon)
        result = await db.execute(query)

        return [dict(row) for row in result.mappings().all()]
