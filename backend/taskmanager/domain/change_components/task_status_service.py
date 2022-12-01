from eventsourcing.application import Application

from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents


class TaskStatusService:
    task_service: Application

    def __init__(self, task_service: Application):
        self.task_service = task_service

    def try_change_state_to_ready(self, task: TaskChangeComponents):
        if task.status in [TaskState.REMOVED, TaskState.DONE, TaskState.READY]:
            return
        for c in task.components_to_add:
            if c.state == TaskComponentState.AWAITING or c.assigned_component_id is None:
                return
        if task.status == TaskState.OPEN:
            task.change_status(TaskState.READY, task.status)
            self.task_service.save(task)
