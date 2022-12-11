import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from base import main
from stationmanager.application.station_projector import StationProjector
from taskmanager.application.model.task_service_on_site.schema import TaskServiceOnSiteNewSchema, \
    TaskServiceOnSiteSchema
from taskmanager.domain.change_components.task_status_service import TaskStatusService
from taskmanager.domain.model.task_state import TaskState
from taskmanager.domain.model.tasks.task_on_site_service import TaskServiceOnSite


class TaskServiceOnSiteService(ProcessApplication):
    task_status_service: TaskStatusService

    def create_on_side_task(self, new_task: TaskServiceOnSiteNewSchema) -> uuid.UUID:
        station_repo: StationProjector = main.runner.get(StationProjector)
        station = station_repo.get_by_id(new_task.station_id)
        if station is None:
            raise AttributeError("station does not exist")

        task = TaskServiceOnSite(new_task.name, new_task.description, new_task.station_id, TaskState.READY)
        self.save(task)
        return task.id

    def cancel_task(self, task_id):
        task: TaskServiceOnSite = self.repository.get(task_id)
        task.cancel_task()
        self.save(task)

    def complete_task(self, task_id):
        task: TaskServiceOnSite = self.repository.get(task_id)
        task.complete_task()
        self.save(task)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    def change_component_task_details(self, task_id, name, description):
        task: TaskServiceOnSite = self.repository.get(task_id)
        if name is None and description is None:
            return
        if name is None:
            name = task.name
        if description is None:
            description = task.description
        task.change_task_detail(name, description)
        self.save(task)

    def load_task(self, task_id) -> TaskServiceOnSiteSchema:
        task: TaskServiceOnSite = self.repository.get(task_id)
        return TaskServiceOnSiteSchema(**task.__dict__, id=task.id, state=task.status, created_at=task.created_on)
