import uuid
from enum import Enum

from eventsourcing.domain import Aggregate, event


class TaskActionState(str, Enum):
    AWAITING = "awaiting",
    IN_PROGRESS = "in_progress",
    FINISHED = "finished"


class TaskActionJobType(str, Enum):
    INSTALL = "install",
    REMOVE = "remove",
    REMOTE_SERVICE = "remote_service"


class TaskAction(Aggregate):
    class CreatedEvent(Aggregate.Created):
        task_id: uuid.UUID
        job_type: TaskActionJobType
        state: TaskActionState

    @event(CreatedEvent)
    def __init__(self, task_id: uuid.UUID, job_type: TaskActionJobType, state: TaskActionState):
        self.task_id = task_id
        self.state = state
        self.job_type = job_type
