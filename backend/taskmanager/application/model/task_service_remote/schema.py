import datetime
import uuid
from typing import Optional

from pydantic import BaseModel

from taskmanager.application.model.task.schema import TaskIdSchema
from taskmanager.domain.model.task_state import TaskState


class TaskServiceRemoteSchemaBASE(BaseModel):
    station_id: uuid.UUID
    name: str
    description: str
    pass


class TaskServiceRemoteNewSchema(TaskServiceRemoteSchemaBASE):
    pass


class TaskServiceRemoteSchema(TaskIdSchema, TaskServiceRemoteSchemaBASE):
    state: TaskState
    created_at: datetime.datetime
    finished_at: Optional[datetime.datetime]
