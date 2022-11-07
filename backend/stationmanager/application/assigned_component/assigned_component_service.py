import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.assigned_component import AssignedComponent


class AssignedComponentsService(ProcessApplication):

    def create_component(self, asset_id: uuid, station_id: uuid):
        component: AssignedComponent = AssignedComponent(asset_id=asset_id, station_id=station_id)
        self.save(component)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    # @policy.register(Asset.Created)
    # def _(self, domain_event: Asset.Created, process_event):
    #     storage_item = StorageItem(domain_event.originator_id)
    #     process_event.collect_events(storage_item)
