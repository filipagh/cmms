import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.assigned_component import AssignedComponent
from stationmanager.infrastructure.persistence import assigned_component_repo
from stationmanager.infrastructure.persistence.assigned_component_repo import AssignedComponentModel


class AssignedComponentProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(AssignedComponent.CreatedEvent)
    def _(self, domain_event: AssignedComponent.CreatedEvent, process_event):
        model = assigned_component_repo.AssignedComponentModel(
            id=domain_event.originator_id,
            asset_id=domain_event.asset_id,
            station_id=domain_event.station_id,
            status=domain_event.status

        )
        assigned_component_repo.save(model)

    @policy.register(AssignedComponent.AssignedComponentRemoved)
    def _(self, domain_event: AssignedComponent.AssignedComponentRemoved, process_event):
        component = assigned_component_repo.get_by_id(domain_event.originator_id)
        component.status = domain_event.new_status
        assigned_component_repo.save(component)

    def get_by_id(self, id: uuid.UUID) -> AssignedComponentModel:
        return assigned_component_repo.get_by_id(id)

    def get_by_station(self, segment_id: uuid.UUID) -> list[AssignedComponentModel]:
        return assigned_component_repo.get_by_station(segment_id)
