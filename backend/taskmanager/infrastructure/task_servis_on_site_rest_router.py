import uuid

from fastapi import APIRouter, HTTPException
from starlette.responses import PlainTextResponse

from base import main
from taskmanager.application.model.task_service_on_site.schema import TaskServiceOnSiteNewSchema, \
    TaskServiceOnSiteSchema
from taskmanager.application.task_service_on_site_service import TaskServiceOnSiteService

task_servis_on_site = APIRouter(
    prefix="/task/service_on_site",
    tags=["Task-Service on site"],
    responses={404: {"description": "Not found"}},
)


@task_servis_on_site.post("/create_service_on_side_task",
                          response_model=uuid.UUID)
def create_service_on_site_task(
        new_task: TaskServiceOnSiteNewSchema):
    task_service: TaskServiceOnSiteService = main.runner.get(TaskServiceOnSiteService)
    try:
        return task_service.create_on_side_task(new_task)
    except AttributeError as e:
        raise HTTPException(status_code=400, detail=e.__str__())


@task_servis_on_site.get("/{task_id}",
                         response_model=TaskServiceOnSiteSchema)
def load(task_id: uuid.UUID):
    task_service: TaskServiceOnSiteService = main.runner.get(TaskServiceOnSiteService)
    return task_service.load_task(task_id)


@task_servis_on_site.delete("/{task_id}", response_class=PlainTextResponse)
def cancel_task(task_id: uuid.UUID):
    task_service: TaskServiceOnSiteService = main.runner.get(TaskServiceOnSiteService)
    task_service.cancel_task(task_id)
    return "OK"
