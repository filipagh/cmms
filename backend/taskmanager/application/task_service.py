import datetime
import uuid
from typing import Optional

from eventsourcing.application import AggregateNotFound
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from base import main
from stationmanager.application.station_projector import StationProjector
from taskmanager.application.model.task_change_component.schema import TaskChangeComponentsNewSchema, \
    TaskComponentAddNewSchema, TaskComponentRemoveNewSchema, TaskChangeComponentsSchema, AddComponentRequestSchema, \
    RemoveComponentRequestSchema
from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState
from taskmanager.domain.model.tasks.task_change_components import AddComponentRequest, RemoveComponentRequest, \
    TaskChangeComponents


class TaskService(ProcessApplication):

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
        add = list(map(lambda x: self._add_model_to_schema(x), task.components_to_add))
        remove = list(map(lambda x: self._remove_model_to_schema(x), task.components_to_remove))
        model = TaskChangeComponentsSchema(**task.__dict__, id=task.id, add=add, remove=remove)

        return model

    def _add_model_to_schema(self, component: AddComponentRequest) -> AddComponentRequestSchema:
        return AddComponentRequestSchema(**component.__dict__)

    def _remove_model_to_schema(self, component: RemoveComponentRequest) -> RemoveComponentRequestSchema:
        return RemoveComponentRequestSchema(**component.__dict__)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""
