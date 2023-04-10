import uuid
from typing import Optional

from sqlalchemy import Column, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class RedmineTaskModel(Base):
    __tablename__ = "redmine_tasks"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True)
    redmine_id = Column(String, nullable=False)


def _get_db():
    return base.database.get_sesionmaker()


def save(task: RedmineTaskModel):
    with _get_db() as db:
        db.add(task)
        db.commit()
        return task.redmine_id


def get_by_id(task_id: uuid.UUID) -> Optional[RedmineTaskModel]:
    db: Session
    with _get_db() as db:
        return db.query(RedmineTaskModel).get(task_id)
