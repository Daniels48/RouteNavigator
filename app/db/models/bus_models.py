from sqlalchemy import Column, Integer, Float, String, Time, ForeignKey
from sqlalchemy.orm import relationship
from datetime import time

from app.db.base import Base


class Bus(Base):
    __tablename__ = "buses"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, unique=True)
    speed = Column(Float, nullable=False, default=40.0)
    time_stop = Column(Time, nullable=False, default=lambda: time(0,0, 30) )
    time_stop_in_over = Column(Time, nullable=False, default=lambda: time(0, 15))

    schedule_id = Column(Integer, ForeignKey("schedules.id"), nullable=True)
    schedule = relationship("Schedule", back_populates="buses")

    routes = relationship("Route", back_populates="bus", cascade="all, delete-orphan")