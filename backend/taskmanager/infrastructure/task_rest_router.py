import uuid
from typing import Optional

from fastapi import APIRouter, HTTPException, Depends
from fastapi.params import Query
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

import taskmanager.application.model.task_change_component.schema
from base import main
from base.auth_def import custom_auth, read_permission, write_permission
from taskmanager.application.model.task.schema import TaskSchema
from taskmanager.application.model.task_change_component import schema as schema_change_comp
from taskmanager.application.model.task_change_component.schema import TaskChangeComponentRequestCompleted
from taskmanager.application.model.task_service_remote.schema import TaskServiceRemoteNewSchema
from taskmanager.application.task_service import TaskService
from taskmanager.application.task_service_remote_service import TaskServiceRemoteService
from taskmanager.application.tasks_projector import TasksProjector
from taskmanager.domain.model.task_state import TaskState
from taskmanager.infrastructure.persistence.tasks_repo import TaskType

task_manager_router = APIRouter(
    prefix="/task-manager",
    tags=["Task Manager"],
    responses={404: {"description": "Not found"}},
)


@task_manager_router.post("/create_change_component_task",
                          response_model=uuid.UUID)
def create_component_task(
        new_task: taskmanager.application.model.task_change_component.schema.TaskChangeComponentsNewSchema,
        _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    task_service: TaskService = main.runner.get(main.Services.TaskService.value)
    try:
        return task_service.create_component_task(new_task)
    except AttributeError as e:
        raise HTTPException(status_code=400, detail=e.__str__())


@task_manager_router.post("/create_service_remote_task",
                          response_model=uuid.UUID)
def create_service_remote_task(
        new_task: TaskServiceRemoteNewSchema, _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    task_service: TaskServiceRemoteService = main.runner.get(TaskServiceRemoteService)
    try:
        return task_service.create_remote_task(new_task)
    except AttributeError as e:
        raise HTTPException(status_code=400, detail=e.__str__())


@task_manager_router.get("/get_component_task/{task_id}",
                         response_model=schema_change_comp.TaskChangeComponentsSchema)
def load(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    task_service: TaskService = main.runner.get(main.Services.TaskService.value)
    return task_service.load_component_task(task_id)


@task_manager_router.get("/get_tasks",
                         response_model=list[TaskSchema])
def load_all(station_id: uuid.UUID = None, filter_state: list[TaskState] = Query(None),
             _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    tasks_projector: TasksProjector = main.runner.get(TasksProjector)
    return tasks_projector.get_all(station_id, filter_state)


@task_manager_router.get("/get_task",
                         response_model=TaskSchema)
def load_by_id(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    tasks_projector: TasksProjector = main.runner.get(TasksProjector)
    return tasks_projector.get_by_id(task_id)


@task_manager_router.get("/{task_id}/allocate_components", response_class=PlainTextResponse)
def allocate_components(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    task_service: TaskService = main.runner.get(TaskService)
    task_service.request_component_allocation(task_id)
    return "OK"


@task_manager_router.post("/{task_id}/compete_task_itmes", response_class=PlainTextResponse)
def complete_task_items(task_id: uuid.UUID, task_items: list[TaskChangeComponentRequestCompleted],
                        _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    task_service: TaskService = main.runner.get(TaskService)
    task_service.complete_task_items(task_id, task_items)
    return "OK"


@task_manager_router.post("/{task_id}/change_details", response_class=PlainTextResponse)
def change_details(task_id: uuid.UUID, new_name: Optional[str] = None, new_description: Optional[str] = None,
                   _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    task_service: TaskService = main.runner.get(TaskService)
    task_service.change_component_task_details(task_id, new_name, new_description)
    return "OK"


@task_manager_router.delete("/{task_id}", response_class=PlainTextResponse)
def cancel_task(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    task_proj = main.runner.get(TasksProjector)
    task_type = task_proj.get_by_id(task_id).task_type
    match task_type:
        case TaskType.COMPONENT_CHANGE:
            task_service: TaskService = main.runner.get(TaskService)
            task_service.cancel_task(task_id)
            return "OK"
        case _:
            raise HTTPException(500, f"Unimplemented task cancel type: {str(task_type.name)}")
