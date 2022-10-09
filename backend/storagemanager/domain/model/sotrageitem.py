import uuid

from eventsourcing.domain import Aggregate, event


class StorageItem(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid.UUID

    @event(CreatedEvent)
    def __init__(self, asset_id: uuid.UUID):
        self.asset_id: uuid.UUID = asset_id
        self.in_storage: int = 0
        self.allocated: int = 0
