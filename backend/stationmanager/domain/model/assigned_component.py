import uuid
from enum import Enum

from eventsourcing.domain import Aggregate, event


class AssignedComponentState(str, Enum):
    AWAITING = "awaiting",
    INSTALLED = "installed",
    WILL_BE_REMOVED = "willBeRemoved",
    REMOVED = "removed"


class AssignedComponent(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid
        station_id: uuid
        status: AssignedComponentState

    class AssignedComponentRemoved(Aggregate.Event):
        new_status: AssignedComponentState
        station_id: uuid
        asset_id: uuid

    @event(CreatedEvent)
    def __init__(self, asset_id, station_id, status: AssignedComponentState):
        self.status = status
        self.asset_id = asset_id
        self.station_id = station_id

    @event(AssignedComponentRemoved)
    def remove_component(self, station_id, asset_id, new_status):
        self.status = new_status
