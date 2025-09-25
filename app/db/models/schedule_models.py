from sqlalchemy import Column, Integer, Time
from sqlalchemy.orm import relationship
from app.db.base import Base
from datetime import time


class Schedule(Base):
    __tablename__ = "schedules"

    id = Column(Integer, primary_key=True, index=True)
    interval_minutes = Column(Integer, nullable=False)
    start_time = Column(Time, nullable=False, default=lambda: time(8, 0))
    end_time = Column(Time, nullable=False, default=lambda: time(22, 0))

    buses = relationship("Bus", back_populates="schedule")