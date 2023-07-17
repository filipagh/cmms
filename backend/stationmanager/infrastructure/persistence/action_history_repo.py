import uuid

from sqlalchemy import Column, String, DateTime
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class ActionHistoryModel(Base):
    __tablename__ = "action_history"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    station_id = Column(postgresql.UUID(as_uuid=True), nullable=False, index=True)
    text = Column(String, nullable=False)
    datetime = Column(DateTime, nullable=False)


def _get_db():
    return base.database.get_sesionmaker()


def save(station: ActionHistoryModel):
    with _get_db() as db:
        db.add(station)
        db.commit()


def get_by_station(station: uuid.UUID) -> list[ActionHistoryModel]:
    db: Session
    with _get_db() as db:
        return db.query(ActionHistoryModel).order_by(ActionHistoryModel.datetime).where(
            ActionHistoryModel.station_id == station).all()
