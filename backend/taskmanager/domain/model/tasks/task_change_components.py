import datetime
import json
import uuid
from typing import Optional

from eventsourcing.domain import Aggregate, event, ProgrammingError
from eventsourcing.persistence import Transcoding

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

    @event(TaskChangeComponentsCreated)
    def __init__(self, name: str, description: str, station_id: uuid.UUID, status: TaskState,
                 components_to_add: list[AddComponentRequest], components_to_remove: list[RemoveComponentRequest],
                 created_at: datetime.datetime):
        self.name = name
        self.description = description
        self.status = status
        self.station_id = station_id
        self.components_to_add = components_to_add
        self.components_to_remove = components_to_remove
        self.created_at = created_at

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
