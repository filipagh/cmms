from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from storagemanager.domain.model.sotrageitem import StorageItem
from storagemanager.infrastructure.persistance import storage_item_repo


class StorageItemProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(StorageItem.CreatedEvent)
    def _(self, domain_event: StorageItem.CreatedEvent, process_event):
        model = storage_item_repo.StorageItemModel(id=domain_event.originator_id, asset_id=domain_event.asset_id,
                                                   in_storage=0,
                                                   allocated=0)
        storage_item_repo.save(model)

    @policy.register(StorageItem.AssetAddedToStorage)
    def _(self, domain_event: StorageItem.AssetAddedToStorage, process_event):
        model: storage_item_repo.StorageItemModel = storage_item_repo.get_by_id(domain_event.originator_id)
        model.in_storage += domain_event.count_number

        storage_item_repo.save(model)

    @policy.register(StorageItem.AssetAllocated)
    def _(self, domain_event: StorageItem.AssetAllocated, process_event):
        model: storage_item_repo.StorageItemModel = storage_item_repo.get_by_id(domain_event.originator_id)
        model.in_storage -= 1
        model.allocated += 1

        storage_item_repo.save(model)

    @policy.register(StorageItem.AssetUsed)
    def _(self, domain_event: StorageItem.AssetUsed, process_event):
        model: storage_item_repo.StorageItemModel = storage_item_repo.get_by_id(domain_event.originator_id)
        model.allocated -= 1

        storage_item_repo.save(model)

    @policy.register(StorageItem.AssetsUnAllocated)
    def _(self, domain_event: StorageItem.AssetsUnAllocated, process_event):
        model: storage_item_repo.StorageItemModel = storage_item_repo.get_by_id(domain_event.originator_id)
        model.in_storage += domain_event.count
        model.allocated -= domain_event.count

        storage_item_repo.save(model)

    @policy.register(StorageItem.AssetCountOverriden)
    def _(self, domain_event: StorageItem.AssetCountOverriden, process_event):
        model: storage_item_repo.StorageItemModel = storage_item_repo.get_by_id(domain_event.originator_id)
        model.in_storage = domain_event.new_count

        storage_item_repo.save(model)
