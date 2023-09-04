import uuid
from datetime import datetime

from sqlalchemy import Column, String, ForeignKey, Date, text, ForeignKeyConstraint
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session, relationship

import base.database
from base.database import Base


class StationServiceContractModel(Base):
    __tablename__ = "station_service_contracts"
    station_id = Column(postgresql.UUID(as_uuid=True), index=True, primary_key=True, )
    contract_id = Column(postgresql.UUID(as_uuid=True), ForeignKey("service_contracts.id"), index=True,
                         primary_key=True)
    components_id_list = relationship("ComponentServiceContractModel", lazy="joined")


class ComponentServiceContractModel(Base):
    __tablename__ = "component_service_contracts"
    component_id = Column(postgresql.UUID(as_uuid=True), index=True, primary_key=True, )
    station_id = Column(postgresql.UUID(as_uuid=True), index=True,
                        primary_key=True, )
    contract_id = Column(postgresql.UUID(as_uuid=True), index=True,
                         primary_key=True)
    __table_args__ = (ForeignKeyConstraint((station_id, contract_id),
                                           (StationServiceContractModel.station_id,
                                            StationServiceContractModel.contract_id)), {})

class ServiceContractModel(Base):
    __tablename__ = "service_contracts"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    created_at = Column(Date, nullable=False)
    valid_from = Column(Date, nullable=False)
    valid_until = Column(Date, nullable=False)
    name = Column(String, nullable=False)
    station_id_list = relationship("StationServiceContractModel", lazy="joined")


def _get_db():
    return base.database.get_sesionmaker()


def save_new(contract: ServiceContractModel):
    with _get_db() as db:
        db.add(contract)
        db.commit()
        db.refresh(contract)


def get_contract_by_station_id(station_id: uuid) -> list[ServiceContractModel]:
    db: Session
    with _get_db() as db:
        return db.query(ServiceContractModel).join(ServiceContractModel.station_id_list, aliased=True).filter_by(
            station_id=station_id)


def get_contract_by_id(contract_id) -> ServiceContractModel:
    db: Session
    with _get_db() as db:
        return db.query(ServiceContractModel).get(contract_id)


def get_all_contracts(only_active=False):
    with _get_db() as db:
        query = db.query(ServiceContractModel)
        if only_active:
            query = query.filter(ServiceContractModel.valid_until >= datetime.now().date(),
                                 ServiceContractModel.valid_from <= datetime.now().date())
        return query.all()


def search(query) -> list[ServiceContractModel]:
    query = f"{query}:*"
    with _get_db() as db:
        sql = db.query(ServiceContractModel).filter(
            text("unaccent(service_contracts.name) @@ to_tsquery(unaccent(:query))")).params(query=query)
        return sql.all()
