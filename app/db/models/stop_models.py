from sqlalchemy import Column, String, Integer,  Float
from sqlalchemy.orm import relationship
from app.db.base import Base


class Stop(Base):
    __tablename__ = "stops"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, unique=True)
    lat = Column(Float, nullable=False)
    lon = Column(Float, nullable=False)

    routes = relationship("BusRoute", back_populates="stop")

