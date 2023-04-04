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


class RedmineAuthResponseSchema(BaseModel):
    projects: list[RedmineObjectSchema]
    trackers: list[RedmineObjectSchema]
    users: list[RedmineObjectSchema]
