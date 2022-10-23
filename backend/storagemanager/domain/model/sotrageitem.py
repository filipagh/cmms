import uuid

from eventsourcing.domain import Aggregate, event


class StorageItem(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid.UUID
    class AssetAddedToStorage(Aggregate.Event):
        count_number: int

    @event(AssetAddedToStorage)
    def add_to_storage(self, count_number: int):
        self.in_storage += count_number

    @event(CreatedEvent)
    def __init__(self, asset_id: uuid.UUID):
        self.asset_id: uuid.UUID = asset_id
        self.in_storage: int = 0
        self.allocated: int = 0
