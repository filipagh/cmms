import uuid
from datetime import datetime
from typing import Optional

from sqlalchemy import Column, String
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class IssueModel(Base):
    __tablename__ = "issues"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    subject = Column(String, nullable=False)
    description = Column(String, nullable=False)
    user = Column(String, nullable=False)
    station_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    station_name = Column(String, nullable=False)
    road_segment_id = Column(postgresql.UUID(as_uuid=True), nullable=False)
    road_segment_name = Column(String, nullable=False)
    component_id = Column(String, nullable=True)
    active = Column(postgresql.BOOLEAN, nullable=False, default=True)
    created_on = Column(postgresql.TIMESTAMP, nullable=False, default=datetime.utcnow)
    is_external = Column(postgresql.BOOLEAN, nullable=False)


def _get_db():
    return base.database.get_sesionmaker()


def save(issue: IssueModel):
    with _get_db() as db:
        db.add(issue)
        db.commit()
        return issue.id


def get_by_id(issue_id: uuid.UUID) -> Optional[IssueModel]:
    db: Session
    with _get_db() as db:
        return db.query(IssueModel).get(issue_id)


def get_all_active() -> list[IssueModel]:
    db: Session
    with _get_db() as db:
        return db.query(IssueModel).filter(IssueModel.active == True).all()


def resolve_issue(task_id):
    db: Session
    with _get_db() as db:
        issue = db.query(IssueModel).get(task_id)
        issue.active = False
        db.commit()
