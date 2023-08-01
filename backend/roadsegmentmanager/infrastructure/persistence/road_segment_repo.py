import uuid

from sqlalchemy import Column, String, text
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session
from sqlalchemy.sql import expression

import base.database
from base.database import Base


class RoadSegmentModel(Base):
    __tablename__ = "road_segment"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    name = Column(String)
    ssud = Column(String)
    is_active = Column(postgresql.BOOLEAN, nullable=False, server_default=expression.true())


def _get_db():
    return base.database.get_sesionmaker()


def get_road_segments(only_active: bool = False) -> list[RoadSegmentModel]:
    with _get_db() as db:
        query = db.query(RoadSegmentModel)
        if only_active:
            query = query.where(RoadSegmentModel.is_active == True)
        return query.all()


def save(road_segment: RoadSegmentModel):
    with _get_db() as db:
        db.add(road_segment)
        db.commit()


def get_by_id(id: uuid.UUID):
    db: Session
    with _get_db() as db:
        return db.query(RoadSegmentModel).get(id)


def search(query: str, only_active: bool = False) -> list[RoadSegmentModel]:
    query = query + ":*"
    db: Session
    with _get_db() as db:
        sql = db.query(RoadSegmentModel)
        if only_active:
            sql = sql.where(RoadSegmentModel.is_active == True)
        sql = sql.filter(text("unaccent(road_segment.name) @@ to_tsquery(unaccent(:query))")).params(query=query)

        return sql.all()
