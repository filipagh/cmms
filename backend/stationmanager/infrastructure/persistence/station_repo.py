import uuid

from sqlalchemy import Column, String, text, func
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


def get_stations(active_only: bool = False, segment_id: uuid.UUID = None, page=None, page_size=None) -> list[
    StationModel]:
    with _get_db() as db:
        query = db.query(StationModel)
        if active_only:
            query = query.where(StationModel.is_active == True)
        if segment_id:
            query = query.where(StationModel.road_segment_id == segment_id)
        query = query.order_by(func.lower(StationModel.name))
        if page and page_size:
            query = query.limit(page_size).offset((page - 1) * page_size)
        return query.all()


def save(station: StationModel):
    with _get_db() as db:
        db.add(station)
        db.commit()


def get_by_id(id: uuid.UUID) -> StationModel:
    db: Session
    with _get_db() as db:
        return db.query(StationModel).get(id)


def get_by_road_segment(road_segment_id: uuid.UUID, active_only: bool = False) -> list[StationModel]:
    db: Session
    with _get_db() as db:
        query = db.query(StationModel)
        if active_only:
            query = query.where(StationModel.is_active == True)
        return query.where(StationModel.road_segment_id == road_segment_id).all()


def mark_station_as_inactive(station_id):
    db: Session
    with _get_db() as db:
        station = db.query(StationModel).get(station_id)
        station.is_active = False
        db.commit()


def search(query, page, page_size, active_only: bool = False) -> list[StationModel]:
    query = query + ":*"
    db: Session
    with _get_db() as db:
        sql = db.query(StationModel)
        if active_only:
            sql = sql.where(StationModel.is_active == True)
        sql = sql.filter(text("unaccent(station.name) @@ to_tsquery(unaccent(:query))")).params(
            query=query)
        return sql.order_by(func.lower(StationModel.name)).limit(page_size).offset((page - 1) * page_size).all()
