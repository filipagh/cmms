import datetime
import uuid
from enum import Enum
from typing import Optional

from eventsourcing.domain import Aggregate, event, ProgrammingError

from stationmanager.domain.waranty_calculator_service import warranty_until_date_calc


class AssignedComponentState(str, Enum):
    AWAITING = "awaiting",
    INSTALLED = "installed",
    WILL_BE_REMOVED = "willBeRemoved",
    REMOVED = "removed"


class AssignedComponent(Aggregate):
    class CreatedEvent(Aggregate.Created):
        asset_id: uuid
        station_id: uuid
        status: AssignedComponentState
        task_id: uuid
        serial_number: Optional[str]
        warranty_period_until: Optional[datetime.date]
        warranty_period_days: int

    class AssignedComponentRemoved(Aggregate.Event):
        new_status: AssignedComponentState
        task_id: Optional[uuid.UUID]
        station_id: uuid
        asset_id: uuid
        removed_at: datetime.datetime
        serial_number: Optional[str]

    class AssignedComponentStateChanged(Aggregate.Event):
        new_status: AssignedComponentState
        task_id: uuid
        pass

    class AssignedComponentRemoveReverted(Aggregate.Event):
        new_status: AssignedComponentState

    class AssignedComponentInstallReverted(Aggregate.Event):
        pass

    class AssignedComponentInstalled(Aggregate.Event):
        warranty_period_until: datetime.date
        new_status: AssignedComponentState
        task_id: uuid.UUID
        installed_at: datetime.datetime
        serial_number: Optional[str]
        station_id: uuid
        asset_id: uuid

    @event(CreatedEvent)
    def __init__(self, asset_id, station_id, status: AssignedComponentState,
                 task_id: uuid, warranty_period_until: Optional[datetime.date], warranty_period_days: int,
                 serial_number: Optional[str]):
        self.status = status
        self.asset_id = asset_id
        self.station_id = station_id
        self.task_id = task_id
        self.warranty_period_until = warranty_period_until
        self.warranty_period_days = warranty_period_days
        self.serial_number = serial_number

    def force_remove_component(self, uninstall_date: datetime.datetime):
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

        warranty_period_until = warranty_until_date_calc(installed_at.date(), self.warranty_period_days)
        self._install_component(task_id, installed_at, AssignedComponentState.INSTALLED, warranty_period_until,
                                serial_number, self.station_id, self.asset_id)

    @event(AssignedComponentInstalled)
    def _install_component(self, task_id, installed_at: datetime.datetime, new_status,
                           warranty_period_until: datetime.date, serial_number: Optional[str], station_id: uuid,
                           asset_id: uuid):
        self.warranty_period_until = warranty_period_until
        self.status = new_status
        self.task_id = None
        self.serial_number = serial_number

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
        self.task_id = None
