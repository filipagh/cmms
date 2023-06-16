import logging
import uuid
from typing import Optional

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

import base.main
from assetmanager.application import asset_manager_loader
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.application.station_projector import StationProjector
from taskmanager.application.model.redmine_integration.schema import RedmineIssueDataSchema
from taskmanager.domain.model.task_state import TaskState
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents
from taskmanager.domain.model.tasks.task_on_site_service import TaskServiceOnSite
from taskmanager.domain.model.tasks.task_remote_service import TaskServiceRemote
from taskmanager.infrastructure.persistence import redmine_tasks_repo
from taskmanager.infrastructure.persistence.redmine_tasks_repo import RedmineTaskModel
from taskmanager.infrastructure.redmine_integration import is_redmine_active, create_issue, close_issue, complete_issue, \
    get_issue, add_note_to_issue


class RedmineProjector(ProcessApplication):

    def load_issue(self, task_id: uuid.UUID) -> Optional[RedmineIssueDataSchema]:
        if not is_redmine_active():
            return None
        redmine_task = redmine_tasks_repo.get_by_id(task_id=task_id)
        if redmine_task is None:
            return None
        return get_issue(redmine_task.redmine_id)

    def _add_change_components_note(self, redmine_id, event: TaskChangeComponents.TaskChangeComponentsCreated):
        if not is_redmine_active():
            return

        assigned_component_projector = base.main.runner.get(AssignedComponentProjector)

        note = "Zmeniť komponenty:\n"
        if event.components_to_add:
            note += "Pridať:\n"
            add_list = []
            for comp in event.components_to_add:
                asset = asset_manager_loader.load_asset_by_id(uuid.UUID(comp.new_asset_id))
                add_list.append(asset.name)
            note += ",".join(add_list) + "\n"
        if event.components_to_remove:
            note += "Odstrániť:\n"
            add_list = []
            for comp in event.components_to_remove:
                component = assigned_component_projector.get_by_id(comp.assigned_component_id)
                asset = asset_manager_loader.load_asset_by_id(component.asset_id)
                add_list.append(asset.name + " (sériové číslo: " + component.serial_number + ")")
            note += ",".join(add_list) + "\n"

        add_note_to_issue(redmine_id, note)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    def _create_redmine_task(self, task_id: uuid.UUID, subject: str, description: str, category: str):
        if not is_redmine_active():
            return
        return redmine_tasks_repo.save(
            RedmineTaskModel(id=task_id, redmine_id=create_issue(task_id, subject, description, "1", category)))

    def _close_redmine_task(self, task_id: uuid.UUID):
        if not is_redmine_active():
            return
        issue = redmine_tasks_repo.get_by_id(task_id=task_id)
        if issue is None:
            return
        close_issue(issue.redmine_id)

    def _complete_redmine_task(self, task_id: uuid.UUID):
        if not is_redmine_active():
            return
        issue = redmine_tasks_repo.get_by_id(task_id=task_id)
        if issue is None:
            return
        complete_issue(issue.redmine_id)

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        try:
            issue = self.load_issue(domain_event.originator_id)
            if issue is None:
                redmine_id = self._create_redmine_task(domain_event.originator_id, domain_event.name,
                                                       domain_event.description,
                                                       self._get_road_segment_name(domain_event.station_id))
            else:
                redmine_id = issue.task_id
            self._add_change_components_note(redmine_id, domain_event)
        except Exception as e:
            logging.error("Error while creating redmine task: " + str(e))

    @policy.register(TaskChangeComponents.TaskCanceled)
    def _(self, domain_event: TaskChangeComponents.TaskCanceled, process_event):
        try:
            self._close_redmine_task(domain_event.originator_id)
        except Exception as e:
            logging.error("Error while closing redmine task: " + str(e))

    @policy.register(TaskChangeComponents.TaskChangeComponentsStatusChanged)
    def _(self, domain_event: TaskChangeComponents.TaskCanceled, process_event):
        try:
            if domain_event.new_status == TaskState.DONE:
                self._complete_redmine_task(domain_event.originator_id)
        except Exception as e:
            logging.error("Error while closing redmine task: " + str(e))

    @policy.register(TaskServiceOnSite.TaskCreated)
    def _(self, domain_event: TaskServiceOnSite.TaskCreated, process_event):
        try:
            issue = self.load_issue(domain_event.originator_id)
            if issue is None:
                self._create_redmine_task(domain_event.originator_id, domain_event.name,
                                          domain_event.description,
                                          self._get_road_segment_name(domain_event.station_id))
        except Exception as e:
            logging.error("Error while creating redmine task: " + str(e))

    @policy.register(TaskServiceOnSite.TaskComplete)
    def _(self, domain_event: TaskServiceOnSite.TaskComplete, process_event):
        try:
            self._complete_redmine_task(domain_event.originator_id)
        except Exception as e:
            logging.error("Error while closing redmine task: " + str(e))

    @policy.register(TaskServiceOnSite.TaskCanceled)
    def _(self, domain_event: TaskServiceOnSite.TaskCanceled, process_event):
        try:
            self._close_redmine_task(domain_event.originator_id)
        except Exception as e:
            logging.error("Error while closing redmine task: " + str(e))

    @policy.register(TaskServiceRemote.TaskCreated)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        try:
            issue = self.load_issue(domain_event.originator_id)
            if issue is None:
                self._create_redmine_task(domain_event.originator_id, domain_event.name,
                                          domain_event.description,
                                          self._get_road_segment_name(domain_event.station_id))
        except Exception as e:
            logging.error("Error while creating redmine task: " + str(e))

    @policy.register(TaskServiceRemote.TaskCanceled)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        try:
            self._close_redmine_task(domain_event.originator_id)
        except Exception as e:
            logging.error("Error while closing redmine task: " + str(e))

    @policy.register(TaskServiceRemote.TaskComplete)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        try:
            self._complete_redmine_task(domain_event.originator_id)
        except Exception as e:
            logging.error("Error while closing redmine task: " + str(e))

    def _get_road_segment_name(self, station_id: uuid.UUID):

        road_segment_id = base.main.runner.get(StationProjector).get_by_id(station_id).road_segment_id
        return base.main.runner.get(RoadSegmentProjector).get_by_id(road_segment_id).name
