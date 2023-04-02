import uuid
from datetime import datetime
from typing import Optional

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.assigned_component import AssignedComponent, AssignedComponentState
from stationmanager.domain.waranty_calculator_service import warranty_until_date_calc
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents


class AssignedComponentsService(ProcessApplication):

    def create_new_component(self, asset_id: uuid, station_id: uuid, task_id: uuid, warranty_period_days: int):
        component: AssignedComponent = AssignedComponent(asset_id=asset_id, station_id=station_id,
                                                         status=AssignedComponentState.AWAITING,
                                                         task_id=task_id, warranty_period_days=warranty_period_days,
                                                         warranty_period_until=None, serial_number=None)
        self.save(component)
        return component.id

    def create_installed_component(self, asset_id: uuid, station_id: uuid, warranty_period_days: int,
                                   serial_number: Optional[str]):
        component: AssignedComponent = AssignedComponent(asset_id=asset_id, station_id=station_id,
                                                         status=AssignedComponentState.INSTALLED,
                                                         task_id=None, warranty_period_until=warranty_until_date_calc(
                datetime.now().date(), warranty_period_days), warranty_period_days=warranty_period_days,
                                                         serial_number=serial_number)
        self.save(component)
        return component.id

    def set_component_to_be_removed(self, assigned_component_id, task_id: uuid):
        component: AssignedComponent = self.repository.get(assigned_component_id)
        match component.status:
            case AssignedComponentState.REMOVED:
                pass
            case AssignedComponentState.WILL_BE_REMOVED:
                pass
            case AssignedComponentState.AWAITING:
                pass
            case AssignedComponentState.INSTALLED:
                component.set_component_to_be_removed(task_id=task_id)
                self.save(component)

    def force_remove_installed_component(self, assigned_component_id: uuid):
        component: AssignedComponent = self.repository.get(assigned_component_id)
        match component.status:
            case AssignedComponentState.REMOVED:
                pass
            case AssignedComponentState.INSTALLED:
                component.force_remove_component()
                self.save(component)
            case _:
                raise Exception("NOW CANT REMOVE COMONENT WHICH ARE NOT IN STATE INSTALLED")
        return component.id

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        for add in domain_event.components_to_add:
            self.create_new_component(add.new_asset_id, domain_event.station_id, domain_event.originator_id,
                                      domain_event.warranty_period_days)
        for remove in domain_event.components_to_remove:
            self.set_component_to_be_removed(remove.assigned_component_id, domain_event.originator_id)

    @policy.register(TaskChangeComponents.TaskComponentInstalled)
    def _(self, domain_event: TaskChangeComponents.TaskComponentInstalled, process_event):
        component: AssignedComponent = self.repository.get(domain_event.assigned_component_id)
        component.install_component(domain_event.originator_id, domain_event.timestamp, domain_event.serial_number)
        self.save(component)

    @policy.register(TaskChangeComponents.TaskComponentRemoved)
    def _(self, domain_event: TaskChangeComponents.TaskComponentRemoved, process_event):
        component: AssignedComponent = self.repository.get(domain_event.assigned_component_id)
        component.remove_component(domain_event.originator_id, domain_event.timestamp)
        self.save(component)

    @policy.register(TaskChangeComponents.TaskCanceled)
    def _(self, domain_event: TaskChangeComponents.TaskCanceled, process_event):
        for ac in domain_event.assigned_component_to_revert:
            as_component: AssignedComponent = self.repository.get(ac)
            if as_component.status == AssignedComponentState.WILL_BE_REMOVED:
                as_component.revert_remove_component()
                self.save(as_component)
            if as_component.status == AssignedComponentState.AWAITING:
                as_component.revert_install()
                self.save(as_component)
