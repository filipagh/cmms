import uuid
from datetime import datetime
from typing import Optional

from eventsourcing.domain import Aggregate, event


class AssignedComponent(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid
        station_id: uuid

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
    def __init__(self, asset_id, station_id):
        self.asset_id = asset_id
        self.station_id = station_id
