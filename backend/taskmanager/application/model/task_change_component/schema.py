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


class TaskSchema(TaskIdSchema, TaskChangeComponentSchemaBASE):
    state: TaskState


class AddComponentRequestSchema(BaseModel):
    new_asset_id: uuid.UUID
    assigned_component: Optional[uuid.UUID]
    state: TaskComponentState
    pass


class RemoveComponentRequestSchema(BaseModel):
    assigned_component_id: uuid.UUID
    pass


class TaskChangeComponentsSchema(TaskIdSchema, TaskChangeComponentSchemaBASE):
    created_at: datetime.datetime
    add: list[AddComponentRequestSchema]
    remove: list[RemoveComponentRequestSchema]
