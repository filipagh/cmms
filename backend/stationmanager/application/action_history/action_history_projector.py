import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from assetmanager.application.asset_manager_loader import load_asset_by_id
from base import main
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from stationmanager.application.action_history.model import schema
from stationmanager.application.station_projector import StationProjector
from stationmanager.domain.model.assigned_component import AssignedComponent, AssignedComponentState
from stationmanager.domain.model.station import Station
from stationmanager.infrastructure.persistence import action_history_repo
from taskmanager.application.tasks_projector import TasksProjector
from taskmanager.domain.model.task_state import TaskState
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents
from taskmanager.domain.model.tasks.task_on_site_service import TaskServiceOnSite
from taskmanager.domain.model.tasks.task_remote_service import TaskServiceRemote


class ActionHistoryProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    def get_component_change_message(self, asset_id, station_id, serial_number, installed: bool):
        text = f'Komponent: {load_asset_by_id(asset_id).name} (seriové číslo: {serial_number}) ' \
               f'bol {"nainstalovaný do" if installed else "odinstalovaný z"} stanice: ' \
               f'{main.runner.get(StationProjector).get_by_id(station_id).name}'
        return text

    @policy.register(AssignedComponent.CreatedEvent)
    def _(self, domain_event: AssignedComponent.CreatedEvent, process_event):
        if domain_event.status == AssignedComponentState.INSTALLED:
            text = self.get_component_change_message(domain_event.asset_id, domain_event.station_id,
                                                     domain_event.serial_number, True)
            model = action_history_repo.ActionHistoryModel(
                station_id=domain_event.station_id,
                text=text,
                datetime=domain_event.timestamp,
                is_internal=False
            )
            action_history_repo.save(model)

    @policy.register(AssignedComponent.AssignedComponentInstalled)
    def _(self, domain_event: AssignedComponent.AssignedComponentInstalled, process_event):
        text = self.get_component_change_message(domain_event.asset_id, domain_event.station_id,
                                                 domain_event.serial_number, True)
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.station_id,
            text=text,
            datetime=domain_event.installed_at,
            is_internal=False
        )
        action_history_repo.save(model)

    @policy.register(AssignedComponent.AssignedComponentRemoved)
    def _(self, domain_event: AssignedComponent.AssignedComponentRemoved, process_event):
        text = self.get_component_change_message(domain_event.asset_id, domain_event.station_id,
                                                 domain_event.serial_number, False)
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.station_id,
            text=text,
            datetime=domain_event.removed_at,
            is_internal=False
        )
        action_history_repo.save(model)

    # /////////////////////////////// TASKS ///////////////////////////////////////
    @policy.register(TaskServiceOnSite.TaskCreated)
    def _(self, domain_event: TaskServiceOnSite.TaskCreated, process_event):
        text = f"Bola zadana uloha $${domain_event.originator_id}$$ na servis stanice: {main.runner.get(StationProjector).get_by_id(domain_event.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    @policy.register(TaskServiceOnSite.TaskComplete)
    def _(self, domain_event: TaskServiceOnSite.TaskComplete, process_event):
        task = main.runner.get(TasksProjector).get_by_id(task_id=domain_event.originator_id)
        text = f"Bola dokoncena uloha $${domain_event.originator_id}$$ na servis stanice: {main.runner.get(StationProjector).get_by_id(task.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=task.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    @policy.register(TaskServiceOnSite.TaskCanceled)
    def _(self, domain_event: TaskServiceOnSite.TaskCanceled, process_event):
        task = main.runner.get(TasksProjector).get_by_id(task_id=domain_event.originator_id)
        text = f"Bola zrusena uloha $${domain_event.originator_id}$$ na servis stanice: {main.runner.get(StationProjector).get_by_id(task.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=task.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    #     /////////////////////////////////////////////////////////

    @policy.register(TaskServiceRemote.TaskCreated)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        text = f"Bola zadana uloha $${domain_event.originator_id}$$ na vzdialeny servis stanice: {main.runner.get(StationProjector).get_by_id(domain_event.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    @policy.register(TaskServiceRemote.TaskComplete)
    def _(self, domain_event: TaskServiceRemote.TaskComplete, process_event):
        task = main.runner.get(TasksProjector).get_by_id(task_id=domain_event.originator_id)
        text = f"Bola dokoncena uloha $${domain_event.originator_id}$$ na vzdialeny servis stanice: {main.runner.get(StationProjector).get_by_id(task.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=task.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    @policy.register(TaskServiceRemote.TaskCanceled)
    def _(self, domain_event: TaskServiceRemote.TaskCanceled, process_event):
        task = main.runner.get(TasksProjector).get_by_id(task_id=domain_event.originator_id)
        text = f"Bola zrusena uloha $${domain_event.originator_id}$$ na vzdialeny servis stanice: {main.runner.get(StationProjector).get_by_id(task.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=task.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    # /////////////////////////////////////////////////////////

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        text = f"Bola zadana uloha $${domain_event.originator_id}$$ na zmenu komponentov stanice: {main.runner.get(StationProjector).get_by_id(domain_event.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    @policy.register(TaskChangeComponents.TaskChangeComponentsStatusChanged)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsStatusChanged, process_event):
        if domain_event.new_status == TaskState.DONE:
            task = main.runner.get(TasksProjector).get_by_id(task_id=domain_event.originator_id)
            text = f"Bola dokoncena uloha $${domain_event.originator_id}$$ na zmenu komponentov stanice: {main.runner.get(StationProjector).get_by_id(task.station_id).name}"
            model = action_history_repo.ActionHistoryModel(
                station_id=task.station_id,
                text=text,
                datetime=domain_event.timestamp,
                is_internal=True
            )
            action_history_repo.save(model)

    @policy.register(TaskChangeComponents.TaskCanceled)
    def _(self, domain_event: TaskChangeComponents.TaskCanceled, process_event):
        task = main.runner.get(TasksProjector).get_by_id(task_id=domain_event.originator_id)
        text = f"Bola zrusena uloha $${domain_event.originator_id}$$ na zmenu komponentov stanice: {main.runner.get(StationProjector).get_by_id(task.station_id).name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=task.station_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=True
        )
        action_history_repo.save(model)

    @policy.register(Station.CreatedEvent)
    def _(self, domain_event: Station.CreatedEvent, process_event):
        text = f"Stanica {domain_event.name} bola vytvorena"
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.originator_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=False
        )
        action_history_repo.save(model)

    @policy.register(Station.StationRemoved)
    def _(self, domain_event: Station.StationRemoved, process_event):
        station = main.runner.get(StationProjector).get_by_id(domain_event.originator_id)
        text = f"Stanica {station.name} bola zmazana"
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.originator_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=False
        )
        action_history_repo.save(model)

    @policy.register(Station.StationRelocated)
    def _(self, domain_event: Station.StationRelocated, process_event):
        station = main.runner.get(StationProjector).get_by_id(domain_event.originator_id)
        road_segment_name = main.runner.get(RoadSegmentProjector).get_by_id(domain_event.new_road_segment_id).name
        text = f"Stanica {station.name} bola priradená na cestný úsek {road_segment_name}"
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.originator_id,
            text=text,
            datetime=domain_event.timestamp,
            is_internal=False
        )
        action_history_repo.save(model)

    def get_by_station(self, station_id: uuid.UUID, include_internal=False, page=None, page_size=None) -> list[
        schema.ActionHistorySchema]:
        col = []
        for i in action_history_repo.get_by_station(station_id, include_internal, page, page_size):
            col.append(schema.ActionHistorySchema(**i.__dict__))

        return col
