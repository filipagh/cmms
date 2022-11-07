import uuid

from sqlalchemy import Column, Integer, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class AssignedComponentModel(Base):
    __tablename__ = "assigned_component"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    station_id = Column(postgresql.UUID(as_uuid=True), index=True, nullable=False)
    asset_id = Column(postgresql.UUID(as_uuid=True), index=True, nullable=False)


def _get_db():
    return base.database.get_sesionmaker()


def save(component: AssignedComponentModel):
    with _get_db() as db:
        db.add(component)
        db.commit()


def get_by_id(id: uuid.UUID) -> AssignedComponentModel:
    db: Session
    with _get_db() as db:
        return db.query(AssignedComponentModel).get(id)


def get_by_station(station_id: uuid.UUID) -> list[AssignedComponentModel]:
    db: Session
    with _get_db() as db:
        return db.query(AssignedComponentModel).where(AssignedComponentModel.station_id == station_id).all()
