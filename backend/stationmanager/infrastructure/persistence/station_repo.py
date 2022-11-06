import uuid

from sqlalchemy import Column, Integer, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class StationModel(Base):
    __tablename__ = "station"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    name = Column(String, nullable=False)
    road_segment_id = Column(postgresql.UUID(as_uuid=True), nullable=False)


def _get_db():
    return base.database.get_sesionmaker()


def get_road_segments() -> list[StationModel]:
    with _get_db() as db:
        return db.query(StationModel).all()


def save(station: StationModel):
    with _get_db() as db:
        db.add(station)
        db.commit()


def get_by_id(id: uuid.UUID):
    db: Session
    with _get_db() as db:
        return db.query(StationModel).get(id)
