import uuid
from enum import Enum

import sqlalchemy
from sqlalchemy import Column, String, DateTime
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base
from taskmanager.domain.model.task_state import TaskState


class TaskType(str, Enum):
    COMPONENT_CHANGE = "component_change",
    REMOTE_SERVICE = 'remote_service'
    ON_SITE_SERVICE = "on_site_service",


class TaskModel(Base):
    __tablename__ = "tasks"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    name = Column(String)
    description = Column(String)
    state: TaskState = Column('task_state', sqlalchemy.types.Enum(TaskState), nullable=False)
    task_type = Column('task_type', sqlalchemy.types.Enum(TaskType), nullable=False)
    station_id = Column(postgresql.UUID(as_uuid=True), index=True, nullable=False)
    station_name = Column(String, nullable=False)
    road_segment_name = Column(String, nullable=False)
    created_on = Column(DateTime, nullable=False)
    finished_at = Column(DateTime, nullable=True)


def _get_db():
    return base.database.get_sesionmaker()


def save(road_segment: TaskModel):
    with _get_db() as db:
        db.add(road_segment)
        db.commit()


def get_by_id(id: uuid.UUID) -> TaskModel:
    db: Session
    with _get_db() as db:
        return db.query(TaskModel).get(id)


def get_all(station_id, filter_state: list[TaskState] = None, page=None, page_size=None) -> list[TaskModel]:
    db: Session
    with _get_db() as db:
        select = db.query(TaskModel)
        select = select.order_by(TaskModel.created_on.desc())
        if station_id:
            select = select.where(TaskModel.station_id == station_id)
        if filter_state:
            select = select.where(TaskModel.state.in_(filter_state))
        if page and page_size:
            select = select.offset((page - 1) * page_size).limit(page_size)
        return select.all()
