import uuid

from pydantic import BaseModel

from taskmanager.domain.model.task_state import TaskState
from taskmanager.infrastructure.persistence.tasks_repo import TaskType


class TaskSchemaBASE(BaseModel):
    station_id: uuid.UUID
    name: str
    description: str
    pass


class TaskIdSchema(BaseModel):
    id: uuid.UUID


class TaskSchema(TaskIdSchema, TaskSchemaBASE):
    state: TaskState
    task_type: TaskType



