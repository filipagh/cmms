import uuid
from typing import Optional

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from base import main
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from stationmanager.application.station_projector import StationProjector
from taskmanager.application.model.task import schema
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents
from taskmanager.domain.model.tasks.task_on_site_service import TaskServiceOnSite
from taskmanager.domain.model.tasks.task_remote_service import TaskServiceRemote
from taskmanager.infrastructure.persistence import tasks_repo
from taskmanager.infrastructure.persistence.tasks_repo import TaskType


class TasksProjector(ProcessApplication):
    def _get_station_name_and_RS_name(self, station_id: uuid):
        station_loader: StationProjector = main.runner.get(StationProjector)
        road_segment_loader: RoadSegmentProjector = main.runner.get(RoadSegmentProjector)
        station = station_loader.get_by_id(station_id)
        if station is None:
            return ["", ""]
        segment = road_segment_loader.get_by_id(station.road_segment_id)
        return [station.name, segment.name]

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(TaskChangeComponents.TaskChangeComponentsCreated)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsCreated, process_event):
        names = self._get_station_name_and_RS_name(domain_event.station_id)
        task = tasks_repo.TaskModel(
            id=domain_event.originator_id,
            name=domain_event.name,
            description=domain_event.description,
            state=domain_event.status,
            task_type=TaskType.COMPONENT_CHANGE,
            station_id=domain_event.station_id,
            created_on=domain_event.created_at,
            station_name=names[0],
            road_segment_name=names[1]
        )
        tasks_repo.save(task)

    @policy.register(TaskChangeComponents.TaskChangeComponentsStatusChanged)
    def _(self, domain_event: TaskChangeComponents.TaskChangeComponentsStatusChanged, process_event):
        task = tasks_repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        tasks_repo.save(task)

    @policy.register(TaskChangeComponents.DetailChanged)
    def _(self, domain_event: TaskChangeComponents.DetailChanged, process_event):
        task = tasks_repo.get_by_id(domain_event.originator_id)
        task.name = domain_event.name
        task.description = domain_event.description
        tasks_repo.save(task)

    @policy.register(TaskChangeComponents.TaskCanceled)
    def _(self, domain_event: TaskChangeComponents.TaskCanceled, process_event):
        task = tasks_repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        tasks_repo.save(task)

    @policy.register(TaskServiceOnSite.TaskCreated)
    def _(self, domain_event: TaskServiceOnSite.TaskCreated, process_event):
        names = self._get_station_name_and_RS_name(domain_event.station_id)
        task = tasks_repo.TaskModel(
            id=domain_event.originator_id,
            name=domain_event.name,
            description=domain_event.description,
            state=domain_event.status,
            task_type=TaskType.ON_SITE_SERVICE,
            station_id=domain_event.station_id,
            created_on=domain_event.timestamp,
            station_name=names[0],
            road_segment_name=names[1]

        )
        tasks_repo.save(task)

    @policy.register(TaskServiceOnSite.TaskComplete)
    def _(self, domain_event: TaskServiceOnSite.TaskComplete, process_event):
        task = tasks_repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        task.finished_at = domain_event.finished_at
        tasks_repo.save(task)

    @policy.register(TaskServiceOnSite.TaskCanceled)
    def _(self, domain_event: TaskServiceOnSite.TaskCanceled, process_event):
        task = tasks_repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        task.finished_at = domain_event.finished_at
        tasks_repo.save(task)

    @policy.register(TaskServiceRemote.TaskCreated)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        names = self._get_station_name_and_RS_name(domain_event.station_id)
        task = tasks_repo.TaskModel(
            id=domain_event.originator_id,
            name=domain_event.name,
            description=domain_event.description,
            state=domain_event.status,
            task_type=TaskType.REMOTE_SERVICE,
            station_id=domain_event.station_id,
            created_on=domain_event.timestamp,
            station_name=names[0],
            road_segment_name=names[1]
        )
        tasks_repo.save(task)

    @policy.register(TaskServiceRemote.TaskCanceled)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        task = tasks_repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        task.finished_at = domain_event.finished_at
        tasks_repo.save(task)

    @policy.register(TaskServiceRemote.TaskComplete)
    def _(self, domain_event: TaskServiceRemote.TaskCreated, process_event):
        task = tasks_repo.get_by_id(domain_event.originator_id)
        task.state = domain_event.new_status
        task.finished_at = domain_event.finished_at
        tasks_repo.save(task)

    def get_by_id(self, task_id: uuid.UUID) -> schema.TaskSchema:
        return schema.TaskSchema(**tasks_repo.get_by_id(task_id).__dict__)

    def get_all(self, station_id: Optional[uuid.UUID]) -> list[schema.TaskSchema]:
        tasks = tasks_repo.get_all(station_id)
        col = []
        for t in tasks:
            col.append(schema.TaskSchema(**t.__dict__))
        return col
