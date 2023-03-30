import uuid
from typing import Optional

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
            status=domain_event.status,
            task_id=domain_event.task_id,
            installed_at=domain_event.timestamp,
            warranty_period_days=domain_event.warranty_period_days,
            warranty_period_until=domain_event.warranty_period_until,
            serial_number=domain_event.serial_number
        )
        assigned_component_repo.save(model)

    @policy.register(AssignedComponent.AssignedComponentStateChanged)
    def _(self, domain_event: AssignedComponent.AssignedComponentStateChanged, process_event):
        model = assigned_component_repo.get_by_id(domain_event.originator_id)
        model.task_id = domain_event.task_id
        model.status = domain_event.new_status
        assigned_component_repo.save(model)

    @policy.register(AssignedComponent.AssignedComponentRemoved)
    def _(self, domain_event: AssignedComponent.AssignedComponentRemoved, process_event):
        component = assigned_component_repo.get_by_id(domain_event.originator_id)
        component.removed_at = domain_event.removed_at
        component.status = domain_event.new_status
        assigned_component_repo.save(component)

    @policy.register(AssignedComponent.AssignedComponentRemoveReverted)
    def _(self, domain_event: AssignedComponent.AssignedComponentRemoveReverted, process_event):
        component = assigned_component_repo.get_by_id(domain_event.originator_id)
        component.status = domain_event.new_status
        component.task_id = None
        assigned_component_repo.save(component)

    @policy.register(AssignedComponent.AssignedComponentInstalled)
    def _(self, domain_event: AssignedComponent.AssignedComponentInstalled, process_event):
        component = assigned_component_repo.get_by_id(domain_event.originator_id)
        component.status = domain_event.new_status
        component.task_id = None
        component.warranty_period_until = domain_event.warranty_period_until
        component.serial_number = domain_event.serial_number

        assigned_component_repo.save(component)

    @policy.register(AssignedComponent.AssignedComponentInstallReverted)
    def _(self, domain_event: AssignedComponent.AssignedComponentInstallReverted, process_event):
        assigned_component_repo.delete_by_id(domain_event.originator_id)

    def get_by_id(self, id: uuid.UUID) -> AssignedComponentModel:
        return assigned_component_repo.get_by_id(id)

    def get_by_station(self, segment_id: Optional[uuid.UUID]) -> list[AssignedComponentModel]:
        return assigned_component_repo.get_by_station(segment_id)
