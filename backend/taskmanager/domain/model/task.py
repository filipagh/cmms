from enum import Enum

from eventsourcing.domain import Aggregate, event


class TaskState(str, Enum):
    OPEN = "open",
    DONE = "done",
    REMOVED = "removed"


class Task(Aggregate):
    class CreatedEvent(Aggregate.Created):
        name: str
        description: str
        status: TaskState

    @event(CreatedEvent)
    def __init__(self, name: str, description: str, status: TaskState):
        self.name = name
        self.description = description
        self.status = status
