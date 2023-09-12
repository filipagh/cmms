import datetime
import uuid

from pydantic import BaseModel


class ServiceContractStationComponentsSchema(BaseModel):
    station_id: uuid.UUID
    component_id_list: list[uuid.UUID]

class ServiceContractSchemaBASE(BaseModel):
    name: str
    valid_from: datetime.date
    valid_until: datetime.date
    stations_list: list[ServiceContractStationComponentsSchema]


class ServiceContractNewSchema(ServiceContractSchemaBASE):
    pass


class ServiceContractIdSchema(BaseModel):
    id: uuid.UUID


class ServiceContractSchema(ServiceContractIdSchema, ServiceContractSchemaBASE):
    created_at: datetime.date
