import datetime
import uuid
from typing import Optional

from pydantic import BaseModel

from stationmanager.domain.model.assigned_component import ComponentWarrantySource
from taskmanager.application.model.task.schema import TaskIdSchema
from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState


class TaskChangeComponentSchemaBASE(BaseModel):
    station_id: uuid.UUID
    name: str
    description: str


class ComponentWarranty(BaseModel):
    component_warranty_until: Optional[datetime.datetime]
    component_warranty_days: int
    component_warranty_source: ComponentWarrantySource
    component_warranty_id: Optional[uuid.UUID]

    component_prepaid_service_until: Optional[datetime.datetime]
    component_prepaid_service_days: int

    component_technical_warranty_until: Optional[datetime.datetime]
    component_technical_warranty_id: Optional[uuid.UUID]


class TaskComponentAddNewSchema(BaseModel):
    new_asset_id: uuid.UUID
    warranty: ComponentWarranty
    replaced_component_id: Optional[uuid.UUID]
    service_contracts_id: list[uuid.UUID]



class TaskComponentRemoveNewSchema(BaseModel):
    assigned_component_id: uuid.UUID


class TaskChangeComponentsNewSchema(TaskChangeComponentSchemaBASE):
    add: list[TaskComponentAddNewSchema]
    remove: list[TaskComponentRemoveNewSchema]


class TaskChangeComponentRequestId(BaseModel):
    id: uuid.UUID


class TaskChangeComponentRequestCompleted(TaskChangeComponentRequestId):
    serial_number: Optional[str]
    completed_at: datetime.date


class AddComponentRequestSchema(TaskChangeComponentRequestId):
    new_asset_id: uuid.UUID
    assigned_component: Optional[uuid.UUID]
    state: TaskComponentState
    pass


class RemoveComponentRequestSchema(TaskChangeComponentRequestId):
    assigned_component_id: uuid.UUID
    state: TaskComponentState
    pass


class TaskChangeComponentsSchema(TaskIdSchema, TaskChangeComponentSchemaBASE):
    state: TaskState
    created_at: datetime.datetime
    add: list[AddComponentRequestSchema]
    remove: list[RemoveComponentRequestSchema]
