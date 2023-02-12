import datetime
import uuid

from pydantic import BaseModel


class ServiceContractSchemaBASE(BaseModel):
    name: str
    valid_from: datetime.date
    valid_until: datetime.date
    station_id_list: list[uuid.UUID]


class ServiceContractNewSchema(ServiceContractSchemaBASE):
    pass


class ServiceContractIdSchema(BaseModel):
    id: uuid.UUID


class ServiceContractSchema(ServiceContractIdSchema, ServiceContractSchemaBASE):
    created_at: datetime.date
