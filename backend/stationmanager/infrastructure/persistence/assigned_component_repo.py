import uuid
from typing import Optional

from sqlalchemy import Column, Enum, DateTime, Date
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base
from stationmanager.domain.model.assigned_component import AssignedComponentState, ComponentWarrantySource


class AssignedComponentModel(Base):
    __tablename__ = "assigned_component"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    station_id = Column(postgresql.UUID(as_uuid=True), index=True, nullable=False)
    asset_id = Column(postgresql.UUID(as_uuid=True), index=True, nullable=False)
    status = Column('assigned_component_status', Enum(AssignedComponentState), nullable=False)
    task_id = Column(postgresql.UUID(as_uuid=True), nullable=True)
    installed_at = Column(DateTime, nullable=True)

    component_warranty_until = Column(Date, nullable=True)
    component_warranty_source = Column('component_warranty_source', Enum(ComponentWarrantySource), nullable=True)
    component_warranty_id = Column(postgresql.UUID(as_uuid=True), nullable=True)
    prepaid_service_until = Column(Date, nullable=True)
    service_contract_until = Column(Date, nullable=True)
    service_contract_id = Column(postgresql.UUID(as_uuid=True), nullable=True)

    removed_at = Column(DateTime, nullable=True)
    serial_number = Column(postgresql.TEXT, nullable=True)


def _get_db():
    return base.database.get_sesionmaker()


def save(component: AssignedComponentModel):
    with _get_db() as db:
        db.add(component)
        db.commit()
        db.refresh(component)
        return component


def get_by_id(component_id: uuid.UUID) -> AssignedComponentModel:
    db: Session
    with _get_db() as db:
        return db.query(AssignedComponentModel).get(component_id)


def delete_by_id(component_id: uuid.UUID):
    db: Session
    with _get_db() as db:
        db.query(AssignedComponentModel).filter(AssignedComponentModel.id == component_id).delete()
        db.commit()


def get_by_station(station_id: Optional[uuid.UUID]) -> list[AssignedComponentModel]:
    db: Session
    with _get_db() as db:
        query = db.query(AssignedComponentModel)
        if station_id:
            query = query.where(AssignedComponentModel.station_id == station_id)
        return query.all()
