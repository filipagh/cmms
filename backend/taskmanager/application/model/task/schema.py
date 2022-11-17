import uuid

from pydantic import BaseModel

from taskmanager.application.model.task_action.schema import TaskActionNewSchema
from taskmanager.domain.model.task import TaskState


class TaskSchemaBASE(BaseModel):
    station_id: uuid.UUID
    name: str
    description: str
    pass


class TaskNewSchema(TaskSchemaBASE):
    actions: list[TaskActionNewSchema]


class TaskIdSchema(BaseModel):
    id: uuid.UUID


class TaskSchema(TaskIdSchema, TaskSchemaBASE):
    state: TaskState
