import uuid

from eventsourcing.domain import Aggregate, event


class StorageItem(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid.UUID

    class AssetAddedToStorage(Aggregate.Event):
        count_number: int

    class AssetAllocated(Aggregate.Event):
        asset_id: uuid.UUID
        task_id: uuid.UUID

    class AssetsUnAllocated(Aggregate.Event):
        count: int
        asset_id: uuid.UUID
        task_id: uuid.UUID

    class AssetUsed(Aggregate.Event):
        asset_id: uuid.UUID
        task_id: uuid.UUID

    class AssetCountOverriden(Aggregate.Event):
        new_count: int
        old_count: int
        reason: str

    @event(AssetAddedToStorage)
    def add_to_storage(self, count_number: int):
        self.in_storage += count_number

    @event(CreatedEvent)
    def __init__(self, asset_id: uuid.UUID):
        self.asset_id: uuid.UUID = asset_id
        self.in_storage: int = 0
        self.allocated: int = 0

    @event(AssetAllocated)
    def allocate(self, task_id: uuid.UUID, asset_id: uuid.UUID):
        self.in_storage = self.in_storage - 1
        self.allocated = self.allocated + 1
        pass

    @event(AssetsUnAllocated)
    def unallocate(self, count: int, asset_id: uuid.UUID, task_id: uuid.UUID):
        self.allocated -= count
        self.in_storage += count

    @event(AssetUsed)
    def used(self, asset_id: uuid.UUID, task_id: uuid.UUID):
        self.allocated -= 1

    @event(AssetCountOverriden)
    def _asset_count_override(self, new_count: int, old_count: int, reason: str):
        self.in_storage = new_count

    def asset_count_override(self, new_count: int, reason: str):
        """
        :param new_count:
        :param reason:
        :throws ValueError:
        """
        if new_count < 0:
            raise ValueError("New count cannot be negative")
        if reason == "":
            raise ValueError("Reason cannot be empty")

        self._asset_count_override(new_count=new_count, old_count=self.in_storage, reason=reason)
