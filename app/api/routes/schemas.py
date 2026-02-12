from pydantic import BaseModel

class RoutingQuery(BaseModel):
    start: int
    stop: int
