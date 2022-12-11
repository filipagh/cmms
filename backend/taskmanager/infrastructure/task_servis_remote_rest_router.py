import uuid
from typing import Optional

from fastapi import APIRouter, HTTPException
from starlette.responses import PlainTextResponse

from base import main
from taskmanager.application.model.task_service_remote.schema import TaskServiceRemoteNewSchema, TaskServiceRemoteSchema
from taskmanager.application.task_service_remote_service import TaskServiceRemoteService

task_servis_remote = APIRouter(
    prefix="/task/service_remote",
    tags=["Task-Service remote"],
    responses={404: {"description": "Not found"}},
)


@task_servis_remote.post("/create_service_remote_task",
                         response_model=uuid.UUID)
def create(
        new_task: TaskServiceRemoteNewSchema):
    task_service: TaskServiceRemoteService = main.runner.get(TaskServiceRemoteService)
    try:
        return task_service.create_remote_task(new_task)
    except AttributeError as e:
        raise HTTPException(status_code=400, detail=e.__str__())


@task_servis_remote.get("/{task_id}/complete",
                        response_class=PlainTextResponse)
def complete(task_id: uuid.UUID):
    task_service: TaskServiceRemoteService = main.runner.get(TaskServiceRemoteService)
    task_service.complete_task(task_id)
    return "OK"


@task_servis_remote.get("/{task_id}",
                        response_model=TaskServiceRemoteSchema)
def load(task_id: uuid.UUID):
    task_service: TaskServiceRemoteService = main.runner.get(TaskServiceRemoteService)
    return task_service.load_task(task_id)


@task_servis_remote.post("/{task_id}/change_details", response_class=PlainTextResponse)
def complete_task_items(task_id: uuid.UUID, new_name: Optional[str] = None, new_description: Optional[str] = None):
    task_service: TaskServiceRemoteService = main.runner.get(TaskServiceRemoteService)
    task_service.change_component_task_details(task_id, new_name, new_description)
    return "OK"


@task_servis_remote.delete("/{task_id}", response_class=PlainTextResponse)
def cancel(task_id: uuid.UUID):
    task_service: TaskServiceRemoteService = main.runner.get(TaskServiceRemoteService)
    task_service.cancel_task(task_id)
    return "OK"
