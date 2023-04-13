import uuid
from typing import Optional

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

from base.auth_def import read_permission, custom_auth
from taskmanager.application.issue_service import IssueService
from taskmanager.application.model.issue.schema import IssueSchema

issue_router = APIRouter(
    prefix="/issues",
    tags=["Issues"],
    responses={404: {"description": "Not found"}},
)


@issue_router.post("/",
                   response_class=PlainTextResponse)
def create(
        subject: str, description: str, user: str, station_id: Optional[str] = None,
        component_id: Optional[str] = None):
    _id = IssueService().create_issue(subject=subject, description=description, user=user, station_id=station_id,
                                      component_id=component_id)
    return str(_id)


@issue_router.get("/active", response_model=list[IssueSchema])
def get_active_issues(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    return IssueService().get_active_issues()


@issue_router.get("/{task_id}", response_model=IssueSchema)
def get_issue(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    return IssueService().get_issue(task_id)


@issue_router.post("/resolve/{task_id}",
                   response_class=PlainTextResponse)
def resolve_issue(task_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    IssueService().resolve_issue(task_id)
    return "OK"
