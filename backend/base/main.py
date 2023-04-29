import os
import time
from enum import Enum
from urllib.request import Request

from eventsourcing.persistence import Transcoding
from eventsourcing.system import System, SingleThreadedRunner, Follower
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from starlette.responses import JSONResponse

import roadsegmentmanager.infrastructure.rest_router
import storagemanager.infrastructure.rest_router
from assetmanager.application.asset_projector import AssetProjector
from assetmanager.application.asset_service import AssetService
from assetmanager.infrastructure.rest_router import asset_manager_router
from authmanager.infrastructure.auth_rest_router import auth_router
from base.api_exception import AppException
from base.appsettings.schema import SettingSchema
from base.appsettings.settings_enum import SettingsEnum
from base.appsettings.settings_repo import SettingsRepo
from base.init_import import import_assets
from base.transcoding import DateAsIso, AssetTelemetryAsJSON
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from roadsegmentmanager.application.road_segment_service import RoadSegmentService
from stationmanager.application.action_history.action_history_projector import ActionHistoryProjector
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.application.assigned_component.assigned_component_service import AssignedComponentsService
from stationmanager.application.service_contract.service_contract_projector import ServiceContractProjector
from stationmanager.application.service_contract.service_contract_service import ServiceContractService
from stationmanager.application.station_projector import StationProjector
from stationmanager.application.station_service import StationService
from stationmanager.infrastructure.action_history_rest_router import action_history_router
from stationmanager.infrastructure.assigned_component_rest_router import assigned_component_router
from stationmanager.infrastructure.service_contract_rest_router import service_contract_router
from stationmanager.infrastructure.station_rest_router import station_router
from storagemanager.application.storage_item_projector import StorageItemProjector
from storagemanager.application.storage_item_service import StorageItemService
from taskmanager.application.redmine_projector import RedmineProjector
from taskmanager.application.task_service import TaskService
from taskmanager.application.task_service_on_site_service import TaskServiceOnSiteService
from taskmanager.application.task_service_remote_service import TaskServiceRemoteService
from taskmanager.application.tasks_projector import TasksProjector
from taskmanager.domain.model.tasks.task_change_components import AddComponentRequestAsStr, RemoveComponentRequestAsStr
from taskmanager.infrastructure.issues_rest_router import issue_router
from taskmanager.infrastructure.redmine_rest_router import redmine_router
from taskmanager.infrastructure.task_rest_router import task_manager_router
from taskmanager.infrastructure.task_servis_on_site_rest_router import task_servis_on_site
from taskmanager.infrastructure.task_servis_remote_rest_router import task_servis_remote


def register_tansconder(services, t: Transcoding):
    for s in services:
        runner.get(s).mapper.transcoder.register(t)
        for x in runner.get(s).mappers.values():
            x.transcoder.register(t)


def add_transconder(t: Transcoding):
    for s in services:
        service = runner.get(s)
        service.mapper.transcoder.register(t)
        # if runner.get(s)
        if isinstance(service, Follower):
            for x in service.mappers.values():
                x.transcoder.register(t)


os.chdir(os.path.dirname(__file__) + '/../')
if os.system('alembic upgrade head') != 0:
    print("ALEMBIC FAIL")
    # temporally solution until proper loging is done (sleep -> ability to see logs in docker logs)
    while True:
        time.sleep(10)


class Services(Enum):
    TaskService = TaskService
    AssetService = AssetService
    StationProjector = StationProjector


services = [AssetService, AssetProjector, StorageItemProjector, RoadSegmentProjector, StationProjector,
            AssignedComponentProjector, ActionHistoryProjector, StorageItemService, RoadSegmentService, StationService,
            AssignedComponentsService, TasksProjector,
            TaskService, TaskServiceOnSiteService, TaskServiceRemoteService, ServiceContractService,
            ServiceContractProjector, RedmineProjector]

system = System(pipes=[[AssetService, AssetProjector],
                       [AssetService, StorageItemService],
                       [StorageItemService, StorageItemProjector],
                       [RoadSegmentService, RoadSegmentProjector],
                       [StationService, StationProjector],
                       [AssignedComponentsService, AssignedComponentProjector],
                       [StationService, ActionHistoryProjector],
                       [TaskService, ActionHistoryProjector],
                       [TaskServiceRemoteService, ActionHistoryProjector],
                       [TaskServiceOnSiteService, ActionHistoryProjector],
                       [AssignedComponentsService, ActionHistoryProjector],
                       [TaskService, TasksProjector],
                       [TaskService, AssignedComponentsService],
                       [AssignedComponentsService, TaskService],
                       [StorageItemService, TaskService],
                       [TaskService, StorageItemService],
                       [TaskServiceOnSiteService, TasksProjector],
                       [TaskServiceRemoteService, TasksProjector],
                       [TaskService, RedmineProjector],
                       [TaskServiceOnSiteService, RedmineProjector],
                       [TaskServiceRemoteService, RedmineProjector],
                       [ServiceContractService, ServiceContractProjector],
                       [StationService, TaskService],
                       [StationService, TaskServiceRemoteService],
                       [StationService, TaskServiceOnSiteService],
                       ])

runner = SingleThreadedRunner(system)
runner.start()

runner.get(TaskService).mapper.transcoder.register(AddComponentRequestAsStr())
runner.get(TaskService).mapper.transcoder.register(RemoveComponentRequestAsStr())

register_tansconder(
    [TasksProjector, AssignedComponentsService, StorageItemService, RedmineProjector, ActionHistoryProjector],
    AddComponentRequestAsStr())
register_tansconder(
    [TasksProjector, AssignedComponentsService, StorageItemService, RedmineProjector, ActionHistoryProjector],
    RemoveComponentRequestAsStr())
add_transconder(DateAsIso())
add_transconder(AssetTelemetryAsJSON())

# runner.get(TaskService).pull_and_process('StationService')
# runner.get(TasksProjector).pull_and_process("TaskService")
# runner.get(TasksProjector).pull_and_process("TaskServiceOnSiteService")
# runner.get(TasksProjector).pull_and_process("TaskServiceRemoteService")
# runner.get(AssignedComponentsService).pull_and_process("TaskService")


app = FastAPI(debug=True)
app.include_router(asset_manager_router)
app.include_router(storagemanager.infrastructure.rest_router.storage_manager)
app.include_router(roadsegmentmanager.infrastructure.rest_router.road_segment_manager)
app.include_router(station_router)
app.include_router(assigned_component_router)
app.include_router(action_history_router)
app.include_router(task_manager_router)
app.include_router(task_servis_on_site)
app.include_router(task_servis_remote)
app.include_router(service_contract_router)
app.include_router(auth_router)
app.include_router(redmine_router)
app.include_router(issue_router)

origins = [
    "http://localhost:5000",
    "http://localhost:22222",
    "http://pumec.zapto.org:5000",
    "http://pumec.zapto.org:22222",
    "http://10.2.4.3:5000",
    "http://10.2.4.3:22222",
    "http://192.168.1.3:22222",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.exception_handler(AppException)
async def unicorn_exception_handler(request: Request, exc: AppException):
    return JSONResponse(
        status_code=400,
        content={"message": exc.message},
    )


# imports
def import_settings():
    for s in SettingsEnum:
        try:
            SettingsRepo().get_settings(SettingsEnum(s))
        except AttributeError:
            SettingsRepo().set_setting(SettingsEnum(s), '')


import_settings()
import_assets()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/settings", response_model=list[SettingSchema])
async def settings():
    _list = []

    for s in SettingsRepo().get_all():
        if s.value == '':
            continue
        _list.append(SettingSchema(key=SettingsEnum(s.key)
                                   , value=s.value, enabled=True if s.value is not None or s.value != "" else False))

    for s in SettingsEnum:
        if s not in [x.key for x in _list]:
            _list.append(SettingSchema(key=SettingsEnum(s), value="", enabled=False))

    return _list
