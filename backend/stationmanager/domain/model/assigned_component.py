import json
import uuid
from datetime import datetime
from enum import Enum
from typing import Optional

from eventsourcing.domain import Aggregate, event, ProgrammingError
from eventsourcing.persistence import Transcoding
from pydantic import BaseModel


class AssignedComponentState(str, Enum):
    AWAITING = "awaiting",
    INSTALLED = "installed",
    WILL_BE_REMOVED = "willBeRemoved",
    REMOVED = "removed"


class ComponentWarrantySource(str, Enum):
    INVESTMENT_CONTRACT = "INVESTMENT_CONTRACT",
    COMPANY_WARRANTY = "COMPANY_WARRANTY",
    NAN = "NAN",


class AssignedComponentWarranty(BaseModel):
    component_warranty_until: Optional[datetime]
    component_warranty_days: int
    component_warranty_source: ComponentWarrantySource
    component_warranty_id: Optional[uuid.UUID]

    component_prepaid_service_until: Optional[datetime]
    component_prepaid_service_days: int

    component_technical_warranty_until: Optional[datetime]
    component_technical_warranty_id: Optional[uuid.UUID]

    def __init__(self, component_warranty_until: Optional[datetime],
                 component_warranty_days: int,
                 component_warranty_source: ComponentWarrantySource,
                 component_prepaid_service_until: Optional[datetime],
                 component_prepaid_service_days: int,
                 component_warranty_id: Optional[uuid.UUID] = None,
                 component_technical_warranty_until: Optional[datetime] = None,
                 component_technical_warranty_id: Optional[uuid.UUID] = None,
                 ):
        super().__init__(
            component_warranty_until=component_warranty_until,
            component_warranty_days=component_warranty_days,
            component_warranty_source=component_warranty_source,
            component_prepaid_service_until=component_prepaid_service_until,
            component_prepaid_service_days=component_prepaid_service_days,
            component_warranty_id=component_warranty_id,
            component_technical_warranty_until=component_technical_warranty_until,
            component_technical_warranty_id=component_technical_warranty_id
        )


class AssignedComponentWarrantyAsStr(Transcoding):
    type = AssignedComponentWarranty
    name = "AssignedComponentWarranty"

    def encode(self, obj: AssignedComponentWarranty) -> str:
        return json.dumps(obj.__dict__, default=str)

    def decode(self, data: str) -> AssignedComponentWarranty:
        return json.loads(data, object_hook=lambda d: AssignedComponentWarranty(**d))


class AssignedComponent(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid
        station_id: uuid
        status: AssignedComponentState
        task_id: uuid
        serial_number: Optional[str]
        warranty: AssignedComponentWarranty
        service_contracts_id: list[uuid]

    class AssignedComponentRemoved(Aggregate.Event):
        new_status: AssignedComponentState
        task_id: Optional[uuid.UUID]
        station_id: uuid
        asset_id: uuid
        removed_at: datetime
        serial_number: Optional[str]

    class OverwriteComponentWarranty(Aggregate.Event):
        new_warranty: AssignedComponentWarranty
        service_contracts_id: list[uuid]
        station_id: uuid

    class AssignedComponentTechnicalWarrantyAdjusted(Aggregate.Event):
        warranty: AssignedComponentWarranty

    class AssignedComponentStateChanged(Aggregate.Event):
        new_status: AssignedComponentState
        task_id: uuid

    class AssignedComponentRemoveReverted(Aggregate.Event):
        new_status: AssignedComponentState

    class AssignedComponentInstallReverted(Aggregate.Event):
        pass

    class AssignedComponentInstalled(Aggregate.Event):
        new_status: AssignedComponentState
        task_id: uuid.UUID
        installed_at: datetime
        serial_number: Optional[str]
        station_id: uuid
        asset_id: uuid
        warranty: AssignedComponentWarranty

    @event(CreatedEvent)
    def __init__(self, asset_id, station_id, status: AssignedComponentState,
                 task_id: uuid, warranty: AssignedComponentWarranty, service_contracts_id: list[uuid],
                 serial_number: Optional[str]):
        self.status = status
        self.asset_id = asset_id
        self.station_id = station_id
        self.task_id = task_id
        self.serial_number = serial_number
        self.warranty = warranty
        self.service_contracts_id = service_contracts_id

    def force_remove_component(self, uninstall_date: datetime):
        self._remove_component(new_status=AssignedComponentState.REMOVED, removed_at=uninstall_date,
                               station_id=self.station_id,
                               asset_id=self.asset_id, task_id=None, serial_number=self.serial_number)

    @event(AssignedComponentStateChanged)
    def set_component_to_be_removed(self, task_id: uuid, new_status=AssignedComponentState.WILL_BE_REMOVED):
        self.task_id = task_id
        self.status = new_status

    def revert_remove_component(self):
        self._revert_remove_component(AssignedComponentState.INSTALLED)

    @event(AssignedComponentRemoveReverted)
    def _revert_remove_component(self, new_status: AssignedComponentState):
        self.task_id = None
        self.status = new_status

    @event(AssignedComponentInstallReverted)
    def revert_install(self):
        self.task_id = None

    def install_component(self, task_id, installed_at: datetime, serial_number: Optional[str]):
        if self.status != AssignedComponentState.AWAITING:
            raise ProgrammingError(f"assigned component {self.id} is in wrong state")
        import stationmanager.domain.waranty_calculator_service as warranty_calculator_service

        warranty = warranty_calculator_service.process_warranty_on_component_installation(self, installed_at)
        self._install_component(task_id=task_id, installed_at=installed_at, new_status=AssignedComponentState.INSTALLED,
                                serial_number=serial_number, station_id=self.station_id, asset_id=self.asset_id,
                                warranty=warranty)

    @event(AssignedComponentInstalled)
    def _install_component(self, task_id, installed_at: datetime, new_status,
                           serial_number: Optional[str], station_id: uuid, warranty: AssignedComponentWarranty,
                           asset_id: uuid):
        self.status = new_status
        self.task_id = task_id
        self.serial_number = serial_number
        self.installed_at = installed_at
        self.station_id = station_id
        self.asset_id = asset_id
        self.warranty = warranty

    def remove_component(self, task_id, removed_at):
        if self.status != AssignedComponentState.WILL_BE_REMOVED:
            raise ProgrammingError(f"assigned component {self.id} is in wrong state")
        self._remove_component(new_status=AssignedComponentState.REMOVED, task_id=task_id, removed_at=removed_at,
                               station_id=self.station_id,
                               asset_id=self.asset_id,
                               serial_number=self.serial_number
                               )

    @event(AssignedComponentRemoved)
    def _remove_component(self, new_status, removed_at, station_id, asset_id, task_id: Optional[uuid.UUID],
                          serial_number: Optional[str]):
        self.status = new_status
        self.task_id = task_id

    def overwrite_component_warranty(self, new_warranty: AssignedComponentWarranty, service_contracts_id: list[uuid]):
        import stationmanager.domain.waranty_calculator_service as warranty_calculator_service
        new_warranty = warranty_calculator_service.adjust_technical_warranty_if_based_from_investment_contract(
            new_warranty)
        self._overwrite_component_warranty(new_warranty=new_warranty,
                                           service_contracts_id=service_contracts_id, station_id=self.station_id)

    @event(OverwriteComponentWarranty)
    def _overwrite_component_warranty(self, new_warranty: AssignedComponentWarranty, service_contracts_id: list[uuid],
                                      station_id: uuid):
        self.warranty = new_warranty
        self.service_contracts_id = service_contracts_id
        self.station_id = station_id

    def adjust_technical_warranty(self, service_contract_id: uuid, valid_until: datetime):
        if self.warranty.component_technical_warranty_until is not None and self.warranty.component_technical_warranty_until.replace(
                tzinfo=None) > valid_until:
            return
        warranty = AssignedComponentWarranty(
            component_warranty_until=self.warranty.component_warranty_until,
            component_warranty_days=self.warranty.component_warranty_days,
            component_warranty_source=self.warranty.component_warranty_source,
            component_warranty_id=self.warranty.component_warranty_id,
            component_prepaid_service_until=self.warranty.component_prepaid_service_until,
            component_prepaid_service_days=self.warranty.component_prepaid_service_days,
            component_technical_warranty_until=valid_until,
            component_technical_warranty_id=service_contract_id
        )
        self._adjust_technical_warranty(warranty)

    @event(AssignedComponentTechnicalWarrantyAdjusted)
    def _adjust_technical_warranty(self, warranty: AssignedComponentWarranty):
        self.warranty = warranty

    def remove_technical_warranty(self, service_contract_id: uuid):
        if self.warranty.component_technical_warranty_id != service_contract_id:
            return
        import stationmanager.domain.waranty_calculator_service as warranty_calculator_service
        warranty = warranty_calculator_service.calculate_component_technical_warranty(self)
        self._adjust_technical_warranty(warranty)

    def calculate_replacement_warranty(self) -> AssignedComponentWarranty:
        if self.status != AssignedComponentState.INSTALLED:
            return None
        import stationmanager.domain.waranty_calculator_service as warranty_calculator_service
        return warranty_calculator_service.calculate_component_warranty_for_replacement(self)
