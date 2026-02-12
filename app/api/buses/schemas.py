from pydantic import BaseModel

from app.api.stops.schemas import Stop


class BusQuery(BaseModel):
    id: int
    name: str


class BusRouteData(BaseModel):
    obj: Stop
    order: int