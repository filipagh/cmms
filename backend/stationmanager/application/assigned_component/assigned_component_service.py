import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.assigned_component import AssignedComponent, AssignedComponentState


class AssignedComponentsService(ProcessApplication):

    def create_installed_component(self, asset_id: uuid, station_id: uuid):
        component: AssignedComponent = AssignedComponent(asset_id=asset_id, station_id=station_id,
                                                         status=AssignedComponentState.INSTALLED)
        self.save(component)
        return component.id

    def force_remove_installed_component(self, assigned_component_id: uuid):
        component: AssignedComponent = self.repository.get(assigned_component_id)
        match component.status:
            case AssignedComponentState.REMOVED:
                pass
            case AssignedComponentState.INSTALLED:
                component.remove_component(station_id=component.station_id, asset_id=component.asset_id,
                                           new_status=AssignedComponentState.REMOVED)
                self.save(component)
            case _:
                raise Exception("NOW CANT REMOVE COMONENT WHICH ARE NOT IN STATE INSTALLED")
        return component.id

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    # @policy.register(Asset.Created)
    # def _(self, domain_event: Asset.Created, process_event):
    #     storage_item = StorageItem(domain_event.originator_id)
    #     process_event.collect_events(storage_item)
