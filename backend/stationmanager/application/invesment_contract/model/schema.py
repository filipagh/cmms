import datetime
import uuid

from pydantic import BaseModel


class InvestmentContractSchemaBASE(BaseModel):
    identifier: str
    valid_from: datetime.date
    valid_until: datetime.date
    warranty_period_days: int


class InvestmentContractNewSchema(InvestmentContractSchemaBASE):
    pass


class InvestmentContractIdSchema(BaseModel):
    id: uuid.UUID


class InvestmentContractSchema(InvestmentContractIdSchema, InvestmentContractSchemaBASE):
    created_at: datetime.date
