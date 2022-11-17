import uuid
from enum import Enum

from eventsourcing.domain import Aggregate, event


class TaskComponentState(str, Enum):
    AWAITING = "awaiting",
    ALLOCATED = "allocated",
    INSTALLED = "installed",
    REMOVED = "removed"


class TaskComponent(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid.UUID
        assigned_component: uuid.UUID
        action_id: uuid.UUID
        state: TaskComponentState

    @event(CreatedEvent)
    def __init__(self, asset_id: uuid.UUID, assigned_component: uuid.UUID, action_id: uuid.UUID,
                 state: TaskComponentState):
        self.asset_id = asset_id
        self.assigned_component = assigned_component
        self.action_id = action_id
        self.state = state
