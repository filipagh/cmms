import datetime
import uuid

from eventsourcing.domain import Aggregate, event

from taskmanager.domain.model.task_state import TaskState


class TaskServiceOnSite(Aggregate):
    class TaskCreated(Aggregate.Created):
        name: str
        description: str
        status: TaskState
        station_id: uuid.UUID

    class TaskCanceled(Aggregate.Event):
        new_status: TaskState
        finished_at: datetime.datetime

    class TaskComplete(Aggregate.Event):
        new_status: TaskState
        finished_at: datetime.datetime

    @event(TaskCreated)
    def __init__(self, name: str, description: str, station_id: uuid.UUID, status: TaskState):
        self.name = name
        self.description = description
        self.status = status
        self.station_id = station_id
        self.finished_at = None

    def cancel_task(self):
        if self.status in [TaskState.REMOVED, TaskState.DONE]: return

        self._cancel_task(new_status=TaskState.REMOVED, finished_at=datetime.datetime.now())

    @event(TaskCanceled)
    def _cancel_task(self, new_status: TaskState, finished_at: datetime.datetime):
        self.status = new_status
        self.finished_at = finished_at

    def complete_task(self):
        if self.status != TaskState.READY: return
        self._complete_task(new_status=TaskState.DONE, finished_at=datetime.datetime.now())

    @event(TaskComplete)
    def _complete_task(self, new_status: TaskState, finished_at: datetime.datetime):
        self.status = new_status
        self.finished_at = finished_at
