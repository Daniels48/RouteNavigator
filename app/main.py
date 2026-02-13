import logging
from pathlib import Path

from fastapi import FastAPI
from starlette.staticfiles import StaticFiles

from app.core.logging_config import setup_logging
from app.api.router import api_router
from app.views.router import web_router


# 🔹 Настройка логирования
setup_logging()
logger = logging.getLogger(__name__)

logger.info("Starting application...")

# 🔹 Создание приложения
app = FastAPI()

app.include_router(api_router, prefix="/api")
app.include_router(web_router)

BASE_DIR = Path(__file__).resolve().parent

app.mount("/static", StaticFiles(directory=BASE_DIR / "static"), name="static")
app.mount("/tiles", StaticFiles(directory=BASE_DIR / "static" / "tiles"), name="tiles")

logger.info("Application initialized successfully")
