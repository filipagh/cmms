import uuid
from enum import Enum

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
    LOCAL_INSPECTION = "local_inspection",


class TaskModel(Base):
    __tablename__ = "tasks"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    name = Column(String)
    description = Column(String)
    state: TaskState = Column('task_state', sqlalchemy.types.Enum(TaskState), nullable=False)
    task_type = Column('task_type', sqlalchemy.types.Enum(TaskType), nullable=False)
    station_id = Column(postgresql.UUID(as_uuid=True), index=True, nullable=False)
    created_on = Column(DateTime, nullable=False)


def _get_db():
    return base.database.get_sesionmaker()




def save(road_segment: TaskModel):
    with _get_db() as db:
        db.add(road_segment)
        db.commit()


def get_by_id(id: uuid.UUID)-> TaskModel:
    db: Session
    with _get_db() as db:
        return db.query(TaskModel).get(id)


def get_all(station_id) -> list[TaskModel]:
    db: Session
    with _get_db() as db:
        select = db.query(TaskModel)
        if station_id:
            select.filter(TaskModel.station_id==station_id)
        return select.all()