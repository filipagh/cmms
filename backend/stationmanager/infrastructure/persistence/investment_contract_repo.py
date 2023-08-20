import uuid
from datetime import datetime

from sqlalchemy import Column, String, Date, Integer
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import Session

import base.database
from base.database import Base


class InvestmentContractModel(Base):
    __tablename__ = "investment_contracts"
    id = Column(postgresql.UUID(as_uuid=True), primary_key=True, index=True, default=uuid.uuid4)
    created_at = Column(Date, nullable=False)
    valid_from = Column(Date, nullable=False)
    valid_until = Column(Date, nullable=False)
    identifier = Column(String, nullable=False)
    warranty_period_days = Column(Integer, nullable=False)


def _get_db():
    return base.database.get_sesionmaker()


def save_new(contract: InvestmentContractModel):
    with _get_db() as db:
        db.add(contract)
        db.commit()
        db.refresh(contract)


def get_contract_by_id(contract_id) -> InvestmentContractModel:
    db: Session
    with _get_db() as db:
        return db.query(InvestmentContractModel).get(contract_id)


def get_all_contracts(only_active=False):
    with _get_db() as db:
        query = db.query(InvestmentContractModel)
        if only_active:
            query = query.filter(InvestmentContractModel.valid_until >= datetime.now().date(),
                                 InvestmentContractModel.valid_from <= datetime.now().date())
        return query.all()
