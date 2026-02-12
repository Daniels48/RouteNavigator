from fastapi import FastAPI
from pathlib import Path
from starlette.staticfiles import StaticFiles

from app.api.router import api_router
from app.views.router import web_router

app = FastAPI()
app.include_router(api_router, prefix="/api")
app.include_router(web_router)

BASE_DIR = Path(__file__).resolve().parent


app.mount("/static", StaticFiles(directory= BASE_DIR / "static"), name="static")
app.mount("/tiles",StaticFiles(directory=BASE_DIR / "static" / "tiles"),name="tiles")