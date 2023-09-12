import datetime
import uuid
from typing import Optional

from pydantic import BaseModel

from stationmanager.domain.model.assigned_component import AssignedComponentState, ComponentWarrantySource


class AssignedComponentSchemaBASE(BaseModel):
    asset_id: uuid.UUID
    station_id: uuid.UUID
    serial_number: Optional[str]


class AssignedComponentNewSchema(AssignedComponentSchemaBASE):
    service_contracts_id: list[uuid.UUID]



class AssignedComponentIdSchema(BaseModel):
    id: uuid.UUID


class AssignedComponentSchema(AssignedComponentIdSchema, AssignedComponentSchemaBASE):
    status: AssignedComponentState
    task_id: Optional[uuid.UUID]
    installed_at: datetime.datetime
    removed_at: Optional[datetime.datetime]
    component_warranty_until: Optional[datetime.date]
    component_warranty_source: ComponentWarrantySource
    component_warranty_id: Optional[uuid.UUID]
    prepaid_service_until: Optional[datetime.date]
    service_contract_until: Optional[datetime.date]
    service_contract_id: Optional[uuid.UUID]
