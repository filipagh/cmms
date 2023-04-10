from datetime import datetime

from pydantic import BaseModel


class RedmineAuthSchema(BaseModel):
    redmine_url: str
    redmine_api_key: str


class RedmineSetupRequestSchema(RedmineAuthSchema):
    redmine_project_id: str
    redmine_tracker_id: str
    redmine_supervisor_id: str


class RedmineObjectSchema(BaseModel):
    id: int
    name: str


class RedmineAuthResponseSchema(RedmineAuthSchema):
    projects: list[RedmineObjectSchema]
    trackers: list[RedmineObjectSchema]
    users: list[RedmineObjectSchema]


class RedmineCommentDataSchema(BaseModel):
    comment: str
    author: str
    created_on: datetime


class RedmineIssueDataSchema(BaseModel):
    task_id: int
    description: str
    assigned_to: str
    link_to_redmine: str
    comments: list[RedmineCommentDataSchema]
