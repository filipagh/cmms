import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from base import main
from stationmanager.application.station_projector import StationProjector
from taskmanager.application.model.task_service_remote.schema import TaskServiceRemoteNewSchema, TaskServiceRemoteSchema
from taskmanager.domain.change_components.task_status_service import TaskStatusService
from taskmanager.domain.model.task_state import TaskState
from taskmanager.domain.model.tasks.task_remote_service import TaskServiceRemote


class TaskServiceRemoteService(ProcessApplication):
    task_status_service: TaskStatusService

    def create_remote_task(self, new_task: TaskServiceRemoteNewSchema) -> uuid.UUID:
        station_repo: StationProjector = main.runner.get(StationProjector)
        station = station_repo.get_by_id(new_task.station_id)
        if station is None:
            raise AttributeError("station does not exist")

        task = TaskServiceRemote(new_task.name, new_task.description, new_task.station_id, TaskState.READY)
        self.save(task)
        return task.id

    def cancel_task(self, task_id):
        task: TaskServiceRemote = self.repository.get(task_id)
        task.cancel_task()
        self.save(task)

    def complete_task(self, task_id):
        task: TaskServiceRemote = self.repository.get(task_id)
        task.complete_task()
        self.save(task)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    def load_task(self, task_id) -> TaskServiceRemoteSchema:
        task: TaskServiceRemote = self.repository.get(task_id)
        return TaskServiceRemoteSchema(**task.__dict__)