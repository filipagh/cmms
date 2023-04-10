import uuid

from fastapi import APIRouter, Depends, HTTPException
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

import base.main
from base.auth_def import read_permission, custom_auth, admin_permission
from taskmanager.application.model.redmine_integration.schema import RedmineAuthResponseSchema, RedmineAuthSchema, \
    RedmineSetupRequestSchema, RedmineIssueDataSchema
from taskmanager.application.redmine_projector import RedmineProjector
from taskmanager.infrastructure.redmine_integration import redmine_auth, redmine_setup, redmine_disable

redmine_router = APIRouter(
    prefix="/redmine",
    tags=["Redmine"],
    responses={404: {"description": "Not found"}},
)


@redmine_router.get("/{task_id}/load",
                    response_model=RedmineIssueDataSchema)
def load(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    return base.main.runner.get(RedmineProjector).load_issue(task_id)


@redmine_router.post("/auth", response_model=RedmineAuthResponseSchema)
def auth(auth: RedmineAuthSchema, _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    try:
        return redmine_auth(auth)
    except Exception as e:
        raise HTTPException(status_code=400, detail=e.__str__())


@redmine_router.post("/setup", response_class=PlainTextResponse)
def auth(setup: RedmineSetupRequestSchema, _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    try:
        return redmine_setup(setup)
    except Exception as e:
        raise HTTPException(status_code=400, detail=e.__str__())


@redmine_router.delete("/setup", response_class=PlainTextResponse)
def remove_integration(_user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    return redmine_disable()
