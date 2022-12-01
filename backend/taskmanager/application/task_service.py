import datetime
import uuid
from typing import Optional

from eventsourcing.application import AggregateNotFound
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication
from eventsourcing.utils import EnvType

from base import main
from stationmanager.application.station_projector import StationProjector
from stationmanager.domain.model.assigned_component import AssignedComponent, AssignedComponentState
from storagemanager.application.storage_item_service import StorageItemService
from storagemanager.domain.model.sotrageitem import StorageItem
from taskmanager.application.model.task_change_component.schema import TaskChangeComponentsNewSchema, \
    TaskComponentAddNewSchema, TaskComponentRemoveNewSchema, TaskChangeComponentsSchema, AddComponentRequestSchema, \
    RemoveComponentRequestSchema
from taskmanager.domain.change_components.task_status_service import TaskStatusService
from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState
from taskmanager.domain.model.tasks.task_change_components import AddComponentRequest, RemoveComponentRequest, \
    TaskChangeComponents


class TaskService(ProcessApplication):
    task_status_service: TaskStatusService

    def __init__(self, env: Optional[EnvType] = None):
        self.task_status_service = TaskStatusService(self)
        super().__init__(env)

    def create_component_task(self,
                              new_task: TaskChangeComponentsNewSchema) -> uuid.UUID:
        station_repo: StationProjector = main.runner.get(StationProjector)
        station = station_repo.get_by_id(new_task.station_id)
        if station is None:
            raise AttributeError("station does not exist")

        def add_com_to_domain_model(com: TaskComponentAddNewSchema):
            return AddComponentRequest(uuid.uuid4(), com.new_asset_id, TaskComponentState.AWAITING)

        def remove_com_to_domain_model(com: TaskComponentRemoveNewSchema):
            return RemoveComponentRequest(uuid.uuid4(), TaskComponentState.INSTALLED, com.assigned_component_id)

        add = list(map(lambda x: add_com_to_domain_model(x), new_task.add))
        remove = list(map(lambda x: remove_com_to_domain_model(x), new_task.remove))

        task = TaskChangeComponents(new_task.name, new_task.description, new_task.station_id, TaskState.OPEN,
                                    add, remove, datetime.datetime.now())
        self.save(task)
        print(task.id)

        return task.id

    def load_component_task(self, task_id: uuid.UUID) -> Optional[TaskChangeComponentsSchema]:
        try:
            task: TaskChangeComponents = self.repository.get(task_id)
        except AggregateNotFound:
            return None
        return self._task_component_to_chema(task)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(AssignedComponent.CreatedEvent)
    def _(self, domain_event: AssignedComponent.CreatedEvent, process_event):
        if domain_event.status == AssignedComponentState.AWAITING:
            task: TaskChangeComponents = self.repository.get(domain_event.task_id)
            task.assign_component(domain_event.asset_id, domain_event.originator_id)
            self.save(task)
            self.task_status_service.try_change_state_to_ready(task)

    @policy.register(StorageItem.AssetAllocated)
    def _(self, domain_event: StorageItem.AssetAllocated, process_event):
        task: TaskChangeComponents = self.repository.get(domain_event.task_id)
        task.allocate_component(domain_event.asset_id)
        self.save(task)
        self.task_status_service.try_change_state_to_ready(task)

    def request_component_allocation(self, task_id):
        task: TaskChangeComponents = self.repository.get(task_id)
        storage_service = main.runner.get(StorageItemService)
        for c in task.components_to_add:
            if c.state == TaskComponentState.AWAITING:
                storage_service.try_to_allocate_component(c.new_asset_id, task_id)

    def _task_component_to_chema(self, task: TaskChangeComponents):
        def _add_model_to_schema(component: AddComponentRequest) -> AddComponentRequestSchema:
            return AddComponentRequestSchema(**component.__dict__)

        def _remove_model_to_schema(component: RemoveComponentRequest) -> RemoveComponentRequestSchema:
            return RemoveComponentRequestSchema(**component.__dict__)

        add = list(map(lambda x: _add_model_to_schema(x), task.components_to_add))
        remove = list(map(lambda x: _remove_model_to_schema(x), task.components_to_remove))
        return TaskChangeComponentsSchema(**task.__dict__, id=task.id, add=add, remove=remove, state=task.status)
