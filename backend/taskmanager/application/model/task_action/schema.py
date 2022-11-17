import uuid

from pydantic import BaseModel

from taskmanager.application.model.task_component.schema import TaskComponentNewSchema
from taskmanager.domain.model.task_ation import TaskActionState
from taskmanager.domain.model.task_component import TaskComponentState


class TaskActionSchemaBASE(BaseModel):
    job_type: TaskActionState
    pass


class TaskActionNewSchema(TaskActionSchemaBASE):
    task_components: list[TaskComponentNewSchema]
    pass


class TaskComponentIdSchema(BaseModel):
    id: uuid.UUID


class TaskActionSchema(TaskComponentIdSchema, TaskActionSchemaBASE):
    task_id: uuid.UUID
    state: TaskComponentState
