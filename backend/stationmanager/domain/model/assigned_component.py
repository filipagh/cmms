import datetime
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
        created_at: datetime.datetime
        task_id: uuid

    class AssignedComponentRemoved(Aggregate.Event):
        new_status: AssignedComponentState
        station_id: uuid
        asset_id: uuid
        changed_at: datetime.datetime

    class AssignedComponentStateChanged(Aggregate.Event):
        new_status: AssignedComponentState
        task_id: uuid
        pass

    @event(CreatedEvent)
    def __init__(self, asset_id, station_id, status: AssignedComponentState,
                 created_at: datetime.datetime, task_id: uuid):
        self.status = status
        self.asset_id = asset_id
        self.station_id = station_id
        self.created_at = created_at
        self.task_id = task_id

    @event(AssignedComponentRemoved)
    def remove_component(self, station_id, asset_id, new_status,
                         changed_at: datetime.datetime):
        self.status = new_status
        self.changed_at = changed_at

    @event(AssignedComponentStateChanged)
    # todo test this
    def set_component_to_be_removed(self, task_id: uuid, new_status=AssignedComponentState.WILL_BE_REMOVED):
        self.task_id = task_id
        self.status = new_status
