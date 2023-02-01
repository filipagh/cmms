import datetime
import json
import uuid
from typing import Optional

from eventsourcing.domain import Aggregate, event, ProgrammingError
from eventsourcing.persistence import Transcoding

from taskmanager.application.model.task_change_component.schema import TaskChangeComponentRequestId
from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState


class AddComponentRequest:
    id: str
    new_asset_id: str
    assigned_component_id: Optional[str]
    state: TaskComponentState

    def __init__(self, id: uuid.UUID, new_asset_id: uuid.UUID, state: TaskComponentState,
                 assigned_component_id: Optional[uuid.UUID] = None
                 ):
        self.id = str(id)
        self.new_asset_id = str(new_asset_id)
        if assigned_component_id:
            self.assigned_component_id = str(assigned_component_id)
        else:
            self.assigned_component_id = None
        self.state = state


class AddComponentRequestAsStr(Transcoding):
    type = AddComponentRequest
    name = "AddComponentRequest"

    def encode(self, obj: AddComponentRequest) -> str:
        return json.dumps(obj.__dict__)

    def decode(self, data: str) -> AddComponentRequest:
        return json.loads(data, object_hook=lambda d: AddComponentRequest(**d))


class RemoveComponentRequest:
    id: str
    assigned_component_id: Optional[str]
    state: TaskComponentState

    def __init__(self, id: uuid.UUID, state: TaskComponentState,
                 assigned_component_id: uuid.UUID
                 ):
        self.id = str(id)
        self.assigned_component_id = str(assigned_component_id)
        self.state = state


class RemoveComponentRequestAsStr(Transcoding):
    type = RemoveComponentRequest
    name = "RemoveComponentRequest"

    def encode(self, obj: RemoveComponentRequest) -> str:
        return json.dumps(obj.__dict__)

    def decode(self, data: str) -> RemoveComponentRequest:
        return json.loads(data, object_hook=lambda d: RemoveComponentRequest(**d))


class TaskChangeComponents(Aggregate):
    class TaskChangeComponentsCreated(Aggregate.Created):
        name: str
        description: str
        status: TaskState
        station_id: uuid.UUID
        components_to_add: list[AddComponentRequest]
        components_to_remove: list[RemoveComponentRequest]
        warranty_period_days: int
        created_at: datetime.datetime

    class TaskChangeComponentsComponentAssigned(Aggregate.Event):
        asset_id: uuid.UUID
        assigned_component_id: uuid.UUID
        pass

    class TaskChangeComponentsComponentAllocated(Aggregate.Event):
        asset_id: uuid.UUID
        pass

    class TaskChangeComponentsStatusChanged(Aggregate.Event):
        new_status: TaskState
        old_status: TaskState
        pass

    class TaskCanceled(Aggregate.Event):
        assigned_component_to_revert: list[str]
        assets_to_free: list[str]
        new_status: TaskState
        pass

    class TaskComponentInstalled(Aggregate.Event):
        added_task_item_id: uuid.UUID
        asset_id: uuid.UUID
        assigned_component_id: uuid.UUID
        pass

    class TaskComponentRemoved(Aggregate.Event):
        removed_task_item_id: uuid.UUID
        assigned_component_id: uuid.UUID

    class DetailChanged(Aggregate.Event):
        name: str
        description: str

    @event(TaskChangeComponentsCreated)
    def __init__(self, name: str, description: str, station_id: uuid.UUID, status: TaskState,
                 components_to_add: list[AddComponentRequest], components_to_remove: list[RemoveComponentRequest],
                 created_at: datetime, warranty_period_days: int):
        self.name = name
        self.description = description
        self.status = status
        self.station_id = station_id
        self.components_to_add = components_to_add
        self.components_to_remove = components_to_remove
        self.warranty_period_days = warranty_period_days
        self.created_at = created_at

        if len(components_to_add) > 0:
            if warranty_period_days <= 0:
                raise AttributeError("warranty_period_until param must be set when new component are installed")

    @event(TaskChangeComponentsComponentAssigned)
    def assign_component(self, asset_id, assigned_component_id: uuid.UUID):
        for c in self.components_to_add:
            if c.new_asset_id != asset_id:
                continue
            if c.assigned_component_id != None:
                continue
            c.assigned_component_id = assigned_component_id
            return

        raise ProgrammingError(
            "Assigned component " + str(assigned_component_id) + " cant be assign in task" + str(self.id))

    @event(TaskChangeComponentsComponentAllocated)
    def allocate_component(self, asset_id):
        for c in self.components_to_add:
            if c.new_asset_id != asset_id:
                continue
            if c.state != TaskComponentState.AWAITING:
                continue
            c.state = TaskComponentState.ALLOCATED
            return

        raise ProgrammingError(
            "Allocated component " + str(asset_id) + " cant be allocated in task" + str(self.id))

    @event(TaskChangeComponentsStatusChanged)
    def change_status(self, new_status: TaskState, old_status: TaskState):
        self.status = new_status

    def cancel_task(self):

        if self.status in [TaskState.REMOVED, TaskState.DONE]: return

        assigned_comp_to_free = []
        assets_to_free = []
        for c in self.components_to_add:
            if c.assigned_component_id is not None and c.state != TaskComponentState.INSTALLED: assigned_comp_to_free.append(
                c.assigned_component_id)
            if c.state == TaskComponentState.ALLOCATED: assets_to_free.append(c.new_asset_id)

        for ac in self.components_to_remove:
            if ac.state == TaskComponentState.AWAITING: assigned_comp_to_free.append(ac.assigned_component_id)

        self._cancel_task(assigned_component_to_revert=assigned_comp_to_free, assets_to_free=assets_to_free,
                          new_status=TaskState.REMOVED)

    @event(TaskCanceled)
    def _cancel_task(self, assigned_component_to_revert: list[str], assets_to_free: list[str], new_status: TaskState):
        self.status = TaskState.REMOVED

    def complete_items(self, items: list[TaskChangeComponentRequestId]):
        if self.status == TaskState.DONE: return
        for i in items:
            for cta in self.components_to_add:
                if uuid.UUID(cta.id) == i.id:
                    if cta.state == TaskComponentState.ALLOCATED and cta.assigned_component_id is not None:
                        self._complete_add_item(i.id, cta.new_asset_id, cta.assigned_component_id)
                        continue
            for ctr in self.components_to_remove:
                if uuid.UUID(ctr.id) == i.id:
                    if ctr.state == TaskComponentState.INSTALLED:
                        self._complete_remove_item(i.id, ctr.assigned_component_id)

    @event(TaskComponentInstalled)
    def _complete_add_item(self, added_task_item_id: uuid.UUID, asset_id, assigned_component_id):
        for cta in self.components_to_add:
            if uuid.UUID(cta.id) == added_task_item_id:
                cta.state = TaskComponentState.INSTALLED
                return

    @event(TaskComponentRemoved)
    def _complete_remove_item(self, removed_task_item_id, assigned_component_id):
        for ctr in self.components_to_remove:
            if uuid.UUID(ctr.id) == removed_task_item_id:
                ctr.state = TaskComponentState.REMOVED
                return

    @event(DetailChanged)
    def change_task_detail(self, name, description):
        self.name = name
        self.description = description
