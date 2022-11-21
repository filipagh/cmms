import uuid

from fastapi import APIRouter, HTTPException

import taskmanager.application.model.task_change_component.schema
from base import main
from taskmanager.application.model.task.schema import TaskSchema
from taskmanager.application.model.task_change_component import schema as schema_change_comp
from taskmanager.application.task_service import TaskService
from taskmanager.application.tasks_projector import TasksProjector

task_manager_router = APIRouter(
    prefix="/task-manager",
    tags=["Task Manager"],
    responses={404: {"description": "Not found"}},
)


@task_manager_router.post("/create_change_component_task",
                          response_model=uuid.UUID)
def create_component_task(
        new_task: taskmanager.application.model.task_change_component.schema.TaskChangeComponentsNewSchema):
    task_service: TaskService = main.runner.get(main.Services.TaskService.value)
    try:
        return task_service.create_component_task(new_task)
    except AttributeError as e:
        raise HTTPException(status_code=400, detail=e.__str__())



@task_manager_router.get("/get_component_task/{task_id}",
                         response_model=schema_change_comp.TaskChangeComponentsSchema)
def load(task_id: uuid.UUID):
    task_service: TaskService = main.runner.get(main.Services.TaskService.value)
    return task_service.load_component_task(task_id)\

@task_manager_router.get("/get_tasks",
                         response_model=list[TaskSchema])
def load(station_id: uuid.UUID = None):
    tasks_projector: TasksProjector = main.runner.get(TasksProjector)
    return tasks_projector.get_all(station_id)
