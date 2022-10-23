import uuid

import eventsourcing.application
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from assetmanager.domain.model.asset import Asset
from storagemanager.application.model import schema
from storagemanager.domain.model.sotrageitem import StorageItem


class StorageItemService(ProcessApplication):

    def add_to_storage(self, assets_list: list[schema.AssetItemToAdd]):
        unresolved = []
        for i in assets_list:
            try:
                if i.count_to_add < 1:
                    continue
                storage_item: StorageItem = self.repository.get(i.storage_item_id)
                storage_item.add_to_storage(i.count_to_add)
                self.save(storage_item)
            except eventsourcing.application.AggregateNotFound:
                unresolved.append(i)
        return unresolved

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(Asset.Created)
    def _(self, domain_event: Asset.Created, process_event):
        storage_item = StorageItem(domain_event.originator_id)
        process_event.collect_events(storage_item)
