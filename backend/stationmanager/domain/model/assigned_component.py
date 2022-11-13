import uuid
from datetime import datetime
from enum import Enum
from typing import Optional

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

    # late DateTime? installed;
    # late DateTime created;
    # late DateTime? removed;
    # late AssignedComponentStateEnum actualState;
    # class AssetAddedToStorage(Aggregate.Event):
    #     count_number: int

    # @event(AssetAddedToStorage)
    # def add_to_storage(self, count_number: int):
    #     self.in_storage += count_number

    @event(CreatedEvent)
    def __init__(self, asset_id, station_id, status: AssignedComponentState):
        self.status = status
        self.asset_id = asset_id
        self.station_id = station_id
