import uuid

from sqlalchemy import Column, Integer, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class RoadSegmentModel(Base):
    __tablename__ = "road_segment"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    name = Column(String)
    ssud = Column(String)


def _get_db():
    return base.database.get_sesionmaker()


def get_road_segments() -> list[RoadSegmentModel]:
    with _get_db() as db:
        return db.query(RoadSegmentModel).all()


def save(road_segment: RoadSegmentModel):
    with _get_db() as db:
        db.add(road_segment)
        db.commit()


def get_by_id(id: uuid.UUID):
    db: Session
    with _get_db() as db:
        return db.query(RoadSegmentModel).get(id)
