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
        storage_item_repo.save_new(model)
