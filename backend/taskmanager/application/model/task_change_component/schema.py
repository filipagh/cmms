import datetime
import uuid
from typing import Optional

from pydantic import BaseModel

from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState


class TaskChangeComponentSchemaBASE(BaseModel):
    station_id: uuid.UUID
    name: str
    description: str
    pass


class TaskComponentAddNewSchema(BaseModel):
    new_asset_id: uuid.UUID
    pass


class TaskComponentRemoveNewSchema(BaseModel):
    assigned_component_id: uuid.UUID
    pass


class TaskChangeComponentsNewSchema(TaskChangeComponentSchemaBASE):
    add: list[TaskComponentAddNewSchema]
    remove: list[TaskComponentRemoveNewSchema]


class TaskIdSchema(BaseModel):
    id: uuid.UUID


class TaskChangeComponentRequestId(BaseModel):
    id: uuid.UUID


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
