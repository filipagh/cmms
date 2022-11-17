import uuid
from typing import Optional

from pydantic import BaseModel

from taskmanager.domain.model.task_component import TaskComponentState


class TaskComponentSchemaBASE(BaseModel):
    asset_id: uuid.UUID


class TaskComponentNewSchema(TaskComponentSchemaBASE):
    assigned_component: Optional[uuid.UUID]
    pass


class TaskComponentIdSchema(BaseModel):
    id: uuid.UUID


class TaskComponentSchema(TaskComponentIdSchema, TaskComponentSchemaBASE):
    assigned_component: uuid.UUID
    action_id: uuid.UUID
    state: TaskComponentState
