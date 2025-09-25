from fastapi import FastAPI, Request, Depends
from fastapi.templating import Jinja2Templates
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from pathlib import Path

from starlette.staticfiles import StaticFiles

from app.db.session_db import get_async_db
from app.db.models import Stop
from app.api.router import api_router



app = FastAPI()
BASE_DIR = Path(__file__).resolve().parent
templates = Jinja2Templates(directory=BASE_DIR / "templates")
app.include_router(api_router, prefix="/api")


# Подключаем папку static
app.mount("/static", StaticFiles(directory= BASE_DIR / "static"), name="static")

@app.get("/")
async def show_map(request: Request, db: AsyncSession = Depends(get_async_db)):
    result = await db.execute(select(Stop.id, Stop.name, Stop.lat, Stop.lon))
    stops = [dict(row) for row in result.mappings().all()]
    return templates.TemplateResponse("map.html", {"request": request, "stops": stops})