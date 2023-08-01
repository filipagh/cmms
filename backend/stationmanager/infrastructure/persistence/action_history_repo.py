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
    is_internal = Column(postgresql.BOOLEAN, nullable=False, default=True)


def _get_db():
    return base.database.get_sesionmaker()


def save(station: ActionHistoryModel):
    with _get_db() as db:
        db.add(station)
        db.commit()


def get_by_station(station: uuid.UUID, include_internal=False, page=None, page_size=None) -> list[ActionHistoryModel]:
    db: Session
    with _get_db() as db:
        actions = db.query(ActionHistoryModel).order_by(ActionHistoryModel.datetime).where(
            ActionHistoryModel.station_id == station)
        if not include_internal:
            actions = actions.where(ActionHistoryModel.is_internal == False)
        if page and page_size:
            actions = actions.offset((page - 1) * page_size).limit(page_size)
        return actions.all()
