import os
import time
from enum import Enum
from typing import Optional

from eventsourcing.persistence import Transcoding
from eventsourcing.system import System, SingleThreadedRunner, Follower
from fastapi import FastAPI, Depends, Request, Response, status, HTTPException, Query, Security
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.security import OAuth2AuthorizationCodeBearer, APIKeyCookie, APIKeyHeader
from fief_client import FiefAsync, FiefAccessTokenInfo, FiefUserInfo
from fief_client.integrations.fastapi import FiefAuth
from starlette.responses import PlainTextResponse

import roadsegmentmanager.infrastructure.rest_router
import storagemanager.infrastructure.rest_router
from assetmanager.application.asset_projector import AssetProjector
from assetmanager.application.asset_service import AssetService
from assetmanager.infrastructure.rest_router import asset_manager_router
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
from taskmanager.application.task_service import TaskService
from taskmanager.application.task_service_on_site_service import TaskServiceOnSiteService
from taskmanager.application.task_service_remote_service import TaskServiceRemoteService
from taskmanager.application.tasks_projector import TasksProjector
from taskmanager.domain.model.tasks.task_change_components import AddComponentRequestAsStr, RemoveComponentRequestAsStr
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
            TaskService, TaskServiceOnSiteService, TaskServiceRemoteService, ServiceContractService, ServiceContractProjector]

system = System(pipes=[[AssetService, AssetProjector],
                       [AssetService, StorageItemService],
                       [StorageItemService, StorageItemProjector],
                       [RoadSegmentService, RoadSegmentProjector],
                       [StationService, StationProjector],
                       [AssignedComponentsService, AssignedComponentProjector],
                       [AssignedComponentsService, ActionHistoryProjector],
                       [TaskService, TasksProjector],
                       [TaskService, AssignedComponentsService],
                       [AssignedComponentsService, TaskService],
                       [StorageItemService, TaskService],
                       [TaskService, StorageItemService],
                       [TaskServiceOnSiteService, TasksProjector],
                       [TaskServiceRemoteService, TasksProjector],
                       [ServiceContractService, ServiceContractProjector]
                       ])

runner = SingleThreadedRunner(system)
runner.start()

runner.get(TaskService).mapper.transcoder.register(AddComponentRequestAsStr())
runner.get(TaskService).mapper.transcoder.register(RemoveComponentRequestAsStr())

register_tansconder([TasksProjector, AssignedComponentsService, StorageItemService], AddComponentRequestAsStr())
register_tansconder([TasksProjector, AssignedComponentsService, StorageItemService], RemoveComponentRequestAsStr())
add_transconder(DateAsIso())
add_transconder(AssetTelemetryAsJSON())


# runner.get(TasksProjector).pull_and_process("TaskService")
# runner.get(TasksProjector).pull_and_process("TaskServiceOnSiteService")
# runner.get(TasksProjector).pull_and_process("TaskServiceRemoteService")


class CustomFiefAuth(FiefAuth):
    client: FiefAsync

    async def get_unauthorized_response(self, request: Request, response: Response):
        redirect_uri = request.url_for("auth_callback")
        auth_url = await self.client.auth_url(redirect_uri, scope=["openid"])
        raise HTTPException(
            status_code=status.HTTP_307_TEMPORARY_REDIRECT,
            headers={"Location": auth_url},
        )


fief = FiefAsync(
    os.environ['FIEF_CLIENT_HOST'],
    os.environ['FIEF_CLIENT_ID'],
    os.environ['FIEF_CLIENT_SECRET'],
    encryption_key=os.environ['FIEF_ENCRYPTION_KEY'],
)

scheme = OAuth2AuthorizationCodeBearer(
    os.environ['FIEF_CLIENT_HOST'] + "/authorize",
    os.environ['FIEF_CLIENT_HOST'] + "/api/token",
    scopes={"openid": "openid", "offline_access": "offline_access"},
    auto_error=False,
)
auth = FiefAuth(fief, scheme)

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

origins = [
    "http://localhost:5000",
    "http://localhost:22222",
    "http://pumec.zapto.org:5000",
    "http://pumec.zapto.org:22222",
    "http://192.168.1.3:22222",
]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# imports
import_assets()

SESSION_COOKIE_NAME = "user_session"
scheme = APIKeyCookie(name=SESSION_COOKIE_NAME, auto_error=False)
auth2 = CustomFiefAuth(fief, scheme)


api_key_header = APIKeyHeader(name="api_key", auto_error=False)

def get_api_key(api_key_headerr: str = Security(api_key_header)):
    if api_key_headerr == os.environ['READ_API_KEY']:
        return api_key_headerr


async def custom_auth(api_key=Depends(get_api_key),
                      fief_user: Optional[FiefAccessTokenInfo] = Depends(auth2.current_user(optional=True)),
                      fief_user2: Optional[FiefAccessTokenInfo] = Depends(auth.authenticated(optional=True))):

    if api_key is not None: return api_key
    if fief_user is not None: return fief_user
    if fief_user2 is not None: return fief_user2
    raise HTTPException(401,"missing auth")



@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/login")
async def login(
        user: FiefUserInfo = Depends(auth2.current_user()),
):
    return HTMLResponse(
        f"<h1>You are authenticated. Your user email is {user['email']}</h1> <script> window.close() </script>"

    )

@app.get("/auth_test")
async def auth_test(
        user: FiefUserInfo = Depends(custom_auth),
):
    return HTMLResponse(
        f"<h1>You are authenticated. with -> {user}</h1>"
    )



@app.get("/logged_out")
async def logged_out(
):
    return HTMLResponse("<h1>You are logged out</h1><script> window.close()</script>")

@app.get("/logout")
async def logout(request: Request
                 ):
    url = await auth.client.logout_url(request.url_for("logged_out"))

    response = RedirectResponse(url)
    response.delete_cookie(
        SESSION_COOKIE_NAME,
    )
    return response


@app.get("/auth-callback", name="auth_callback")
async def auth_callback(request: Request, response: Response, code: str = Query(...)):
    redirect_uri = request.url_for("auth_callback")
    tokens, _ = await fief.auth_callback(code, redirect_uri)
    response = RedirectResponse("/login")
    response.set_cookie(
        SESSION_COOKIE_NAME,
        tokens["access_token"],
        max_age=tokens["expires_in"],
        httponly=False,
        secure=False,
        domain="localhost"

    )
    return response
