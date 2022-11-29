import eventsourcing.application
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from assetmanager.domain.model.asset import Asset
from storagemanager.application.model import schema
from storagemanager.domain.model.sotrageitem import StorageItem
from storagemanager.infrastructure.persistance import storage_item_repo
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents


class StorageItemService(ProcessApplication):

    def try_to_allocate_component(self, asset_id, task_id):
        storage_item: StorageItem = self.repository.get(storage_item_repo.get_by_asset_id(asset_id).id)
        if storage_item.in_storage > 0:
            storage_item.allocate(task_id, asset_id)
            self.save(storage_item)

    def add_used_component(self):
        pass

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

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        for c in domain_event.components_to_add:
            self.try_to_allocate_component(c.new_asset_id, domain_event.originator_id)

    @policy.register(Asset.Created)
    def _(self, domain_event: Asset.Created, process_event):
        storage_item = StorageItem(domain_event.originator_id)
        process_event.collect_events(storage_item)
