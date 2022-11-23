import datetime
import json
import uuid
from typing import Optional

from eventsourcing.domain import Aggregate, event
from eventsourcing.persistence import Transcoding

from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState


class AddComponentRequest:
    id: str
    new_asset_id: str
    assigned_component: Optional[str]
    state: TaskComponentState

    def __init__(self, id: uuid.UUID, new_asset_id: uuid.UUID, state: TaskComponentState,
                 assigned_component: Optional[uuid.UUID] = None
                 ):
        self.id = str(id)
        self.new_asset_id = str(new_asset_id)
        if assigned_component:
            self.assigned_component = str(assigned_component)
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
