from pydantic import BaseModel


class ObjectStop(BaseModel):
    lat: float
    lon: float
    name: str
    id: int


class BusRouteData(BaseModel):
    obj: ObjectStop
    order: int


class BusName(BaseModel):
    id: int
    name: str