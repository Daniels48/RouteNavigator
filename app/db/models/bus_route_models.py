from sqlalchemy import Column, Integer, ForeignKey
from app.db.base import Base
from sqlalchemy.orm import  relationship


class BusRoute(Base):
    __tablename__ = "bus_routes"

    id = Column(Integer, primary_key=True, index=True)

    route_id = Column(Integer, ForeignKey("routes.id"))
    stop_id = Column(Integer, ForeignKey("stops.id"), nullable=False)

    order = Column(Integer, nullable=False)

    travel_time = Column(Integer, nullable=False, server_default="0")

    route = relationship("Route", back_populates="stops")
    stop = relationship("Stop", back_populates="routes")