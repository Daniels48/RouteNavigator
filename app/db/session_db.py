import logging
from typing import AsyncGenerator

from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker

from app.core.config import config

logger = logging.getLogger(__name__)
ASYNC_SQLALCHEMY_DATABASE_URL = f"postgresql+asyncpg://{config.user}:{config.password}@{config.host}:{config.port}/{config.name}"

async_engine = create_async_engine(url=ASYNC_SQLALCHEMY_DATABASE_URL)

async_SessionLocal = async_sessionmaker(
    bind=async_engine,
    class_=AsyncSession,
    autoflush=False,
    expire_on_commit=False,
)


async def get_async_db() -> AsyncGenerator[AsyncSession, None]:
    async with async_SessionLocal() as db:
        try:
            yield db
            await db.commit()
        except Exception as e:
            await db.rollback()
            logger.error(f"Database error: {e}")
            raise