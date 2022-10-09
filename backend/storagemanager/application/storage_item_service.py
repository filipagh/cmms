import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from assetmanager.domain.model.asset import Asset
from storagemanager.domain.model.sotrageitem import StorageItem


class StorageItemService(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(Asset.Created)
    def _(self, domain_event: Asset.Created, process_event):
        storage_item = StorageItem(domain_event.originator_id)
        process_event.collect_events(storage_item)

