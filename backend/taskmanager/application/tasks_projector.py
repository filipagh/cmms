import uuid
from typing import Optional

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from taskmanager.application.model.task import schema
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents
from taskmanager.infrastructure.persistence import tasks_repo
from taskmanager.infrastructure.persistence.tasks_repo import TaskType


class TasksProjector(ProcessApplication):
    repo = tasks_repo

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        task = self.repo.TaskModel(
            id=domain_event.originator_id,
            name=domain_event.name,
            description=domain_event.description,
            state=domain_event.status,
            task_type=TaskType.COMPONENT_CHANGE,
            station_id=domain_event.station_id,
            created_on=domain_event.created_at
        )
        tasks_repo.save(task)

    @policy.register(TaskChangeComponents.TaskChangeComponentsStatusChanged)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsStatusChanged, process_event):
        task = self.repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        tasks_repo.save(task)

    @policy.register(TaskChangeComponents.TaskCanceled)
    def _(self, domain_event: TaskChangeComponents.TaskCanceled, process_event):
        task = self.repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        tasks_repo.save(task)

    def get_by_id(self, task_id: uuid.UUID) -> schema.TaskSchema:
        return schema.TaskSchema(**self.repo.get_by_id(task_id).__dict__)

    def get_all(self, station_id: Optional[uuid.UUID]) -> list[schema.TaskSchema]:
        tasks = self.repo.get_all(station_id)
        col = []
        for t in tasks:
            col.append(schema.TaskSchema(**t.__dict__))
        return col
