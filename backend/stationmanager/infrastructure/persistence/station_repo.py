import uuid

from sqlalchemy import Column, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session
from sqlalchemy.sql import expression

import base.database
from base.database import Base


class StationModel(Base):
    __tablename__ = "station"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    name = Column(String, nullable=False)
    is_active = Column(postgresql.BOOLEAN, nullable=False, server_default=expression.true())
    road_segment_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    km_of_road = Column(postgresql.FLOAT, nullable=True)
    km_of_road_note = Column(String, nullable=False)
    latitude = Column(postgresql.FLOAT, nullable=True)
    longitude = Column(postgresql.FLOAT, nullable=True)
    see_level = Column(postgresql.INTEGER, nullable=True)
    description = Column(String, nullable=False)
    legacy_ids = Column(String, nullable=False)

def _get_db():
    return base.database.get_sesionmaker()


def get_road_segments() -> list[StationModel]:
    with _get_db() as db:
        return db.query(StationModel).all()


def save(station: StationModel):
    with _get_db() as db:
        db.add(station)
        db.commit()


def get_by_id(id: uuid.UUID) -> StationModel:
    db: Session
    with _get_db() as db:
        return db.query(StationModel).get(id)


def get_by_road_segment(road_segment_id: uuid.UUID) -> list[StationModel]:
    db: Session
    with _get_db() as db:
        return db.query(StationModel).where(StationModel.road_segment_id == road_segment_id).all()


def mark_station_as_inactive(station_id):
    db: Session
    with _get_db() as db:
        station = db.query(StationModel).get(station_id)
        station.is_active = False
        db.commit()
