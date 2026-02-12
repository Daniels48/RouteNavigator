from pydantic import BaseModel, Field
from typing_extensions import Annotated

Latitude = Annotated[float, Field(ge=-90, le=90)]
Longitude = Annotated[float, Field(ge=-180, le=180)]

class Stop(BaseModel):
    lat: Latitude
    lon: Longitude
    name: str
    id: int
