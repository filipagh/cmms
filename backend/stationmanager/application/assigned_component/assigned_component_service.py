import uuid
from datetime import datetime
from typing import Optional

from DateTime import DateTime
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.assigned_component import AssignedComponent, AssignedComponentState, \
    AssignedComponentWarranty, ComponentWarrantySource
from stationmanager.domain.model.service_contract import ServiceContract
from taskmanager.application.model.task_change_component.schema import ComponentWarranty
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents


class AssignedComponentsService(ProcessApplication):

    def create_new_component(self, asset_id: uuid, station_id: uuid, task_id: uuid,
                             warranty: AssignedComponentWarranty,
                             service_contracts_id: list[uuid]):
        component: AssignedComponent = AssignedComponent(asset_id=asset_id, station_id=station_id,
                                                         status=AssignedComponentState.AWAITING,
                                                         task_id=task_id,
                                                         serial_number=None,
                                                         warranty=warranty,
                                                         service_contracts_id=service_contracts_id)
        self.save(component)
        return component.id

    def create_installed_component(self, asset_id: uuid, station_id: uuid, component_warranty_until: Optional[datetime],
                                   components_warranty_source: ComponentWarrantySource,
                                   paid_service_until: Optional[datetime],
                                   installation_date: DateTime,
                                   component_warranty_id: Optional[uuid.UUID],
                                   serial_number: Optional[str], service_contracts_id: list[uuid]):
        component: AssignedComponent = AssignedComponent(asset_id=asset_id, station_id=station_id,
                                                         status=AssignedComponentState.AWAITING,
                                                         task_id=None, warranty=AssignedComponentWarranty(
                component_warranty_id=component_warranty_id,
                component_warranty_until=component_warranty_until, component_warranty_days=0,
                component_warranty_source=components_warranty_source,
                component_prepaid_service_until=paid_service_until, component_prepaid_service_days=0),
                                                         serial_number=serial_number,
                                                         service_contracts_id=service_contracts_id)
        self.save(component)
        component = self.repository.get(component.id)
        component.install_component(task_id=None, installed_at=installation_date, serial_number=serial_number)
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

    def force_remove_installed_component(self, assigned_component_id: uuid, uninstall_date: datetime = datetime.now()):
        component: AssignedComponent = self.repository.get(assigned_component_id)
        match component.status:
            case AssignedComponentState.REMOVED:
                pass
            case AssignedComponentState.INSTALLED:
                component.force_remove_component(uninstall_date=uninstall_date)
                self.save(component)
            case _:
                raise Exception("NOW CANT REMOVE COMONENT WHICH ARE NOT IN STATE INSTALLED")
        return component.id

    def override_warranty(self, component_id: uuid, component_warranty_until: Optional[datetime],
                          component_warranty_id: Optional[uuid.UUID],
                          component_warranty_source: ComponentWarrantySource,
                          paid_service_until: Optional[datetime],
                          service_contracts_id: list[uuid]):
        component: AssignedComponent = self.repository.get(component_id)
        component.overwrite_component_warranty(
            AssignedComponentWarranty(component_warranty_until=component_warranty_until, component_warranty_days=0,
                                      component_warranty_source=component_warranty_source,
                                      component_warranty_id=component_warranty_id,
                                      component_prepaid_service_until=paid_service_until,
                                      component_prepaid_service_days=0,
                                      component_technical_warranty_until=component.warranty.component_technical_warranty_until,
                                      component_technical_warranty_id=component.warranty.component_technical_warranty_id,
                                      ), service_contracts_id=service_contracts_id)

        self.save(component)

    def calculate_replacement_warranty(self, component_id: uuid):
        component: AssignedComponent = self.repository.get(component_id)
        return ComponentWarranty(**component.calculate_replacement_warranty().dict())

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        for add in domain_event.components_to_add:
            warranty = AssignedComponentWarranty(
                component_warranty_until=add.warranty.component_warranty_until,
                component_warranty_days=add.warranty.component_warranty_days,
                component_warranty_source=add.warranty.component_warranty_source,
                component_warranty_id=add.warranty.component_warranty_id,
                component_prepaid_service_until=add.warranty.component_prepaid_service_until,
                component_prepaid_service_days=add.warranty.component_prepaid_service_days,
                component_technical_warranty_until=add.warranty.component_technical_warranty_until,
                component_technical_warranty_id=add.warranty.component_technical_warranty_id,
            )
            self.create_new_component(add.new_asset_id, domain_event.station_id, domain_event.originator_id,
                                      warranty, add.service_contracts_id)
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

    @policy.register(ServiceContract.Created)
    def _(self, domain_event: ServiceContract.Created, process_event):
        component_list = []
        for station in domain_event.station_id_with_component_ids_list.keys():
            for component in domain_event.station_id_with_component_ids_list[station]:
                component_list.append(component)
        for component_to_proccess in component_list:
            component: AssignedComponent = self.repository.get(component_to_proccess)
            component.adjust_technical_warranty(domain_event.originator_id, datetime(domain_event.valid_until.year,
                                                                                     domain_event.valid_until.month,
                                                                                     domain_event.valid_until.day))
            self.save(component)

    @policy.register(ServiceContract.ComponentAddedToContract)
    def _(self, domain_event: ServiceContract.ComponentAddedToContract, process_event):

        component: AssignedComponent = self.repository.get(domain_event.component_id)
        component.adjust_technical_warranty(domain_event.originator_id, datetime(domain_event.valid_until.year,
                                                                                 domain_event.valid_until.month,
                                                                                 domain_event.valid_until.day))
        self.save(component)

    @policy.register(ServiceContract.ComponentRemovedFromContract)
    def _(self, domain_event: ServiceContract.ComponentRemovedFromContract, process_event):
        component: AssignedComponent = self.repository.get(domain_event.component_id)
        component.remove_technical_warranty(service_contract_id=domain_event.originator_id)
        self.save(component)
