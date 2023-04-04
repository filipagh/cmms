import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents
from taskmanager.domain.model.tasks.task_on_site_service import TaskServiceOnSite
from taskmanager.domain.model.tasks.task_remote_service import TaskServiceRemote
from taskmanager.infrastructure.persistence.redmine_tasks_repo import RedmineTaskModel
from taskmanager.infrastructure.redmine_integration import is_redmine_active, create_issue


class RedmineProjector(ProcessApplication):

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    def _create_redmine_task(self, task_id: uuid.UUID):
        if not is_redmine_active():
            return
        RedmineTaskModel(id=task_id, redmine_id=create_issue("subject", "description", "1", "moja cat"))

    def _close_redmine_task(self):
        if not is_redmine_active():
            return

    def _complete_redmine_task(self):
        if not is_redmine_active():
            return

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        self._create_redmine_task(domain_event.originator_id)

    @policy.register(TaskChangeComponents.TaskCanceled)
    def _(self, domain_event: TaskChangeComponents.TaskCanceled, process_event):
        pass

    @policy.register(TaskServiceOnSite.TaskCreated)
    def _(self, domain_event: TaskServiceOnSite.TaskCreated, process_event):
        pass

    @policy.register(TaskServiceOnSite.TaskComplete)
    def _(self, domain_event: TaskServiceOnSite.TaskComplete, process_event):
        pass

    @policy.register(TaskServiceOnSite.TaskCanceled)
    def _(self, domain_event: TaskServiceOnSite.TaskCanceled, process_event):
        pass

    @policy.register(TaskServiceRemote.TaskCreated)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        pass

    @policy.register(TaskServiceRemote.TaskCanceled)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        pass

    @policy.register(TaskServiceRemote.TaskComplete)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        pass
