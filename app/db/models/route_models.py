from app.db.base import Base
from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.orm import relationship



class Route(Base):
    __tablename__ = "routes"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    direction = Column(String, nullable=True)

    bus_id = Column(Integer, ForeignKey("buses.id"), nullable=False)
    bus = relationship("Bus", back_populates="routes")

    stops = relationship("BusRoute", back_populates="route", cascade="all, delete-orphan")