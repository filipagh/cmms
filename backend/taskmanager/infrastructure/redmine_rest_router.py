import uuid

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

from base.auth_def import read_permission, custom_auth, admin_permission
from taskmanager.application.model.redmine_integration.schema import RedmineAuthResponseSchema, RedmineAuthSchema, \
    RedmineSetupRequestSchema
from taskmanager.infrastructure.redmine_integration import redmine_auth, redmine_setup

redmine_router = APIRouter(
    prefix="/redmine",
    tags=["Redmine"],
    responses={404: {"description": "Not found"}},
)


@redmine_router.get("/{task_id}/load",
                    response_class=PlainTextResponse)
def load(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    return "OK"


@redmine_router.post("/auth", response_model=RedmineAuthResponseSchema)
def auth(auth: RedmineAuthSchema, _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    return redmine_auth(auth)


@redmine_router.post("/setup", response_class=PlainTextResponse)
def auth(setup: RedmineSetupRequestSchema, _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    return redmine_setup(setup)
