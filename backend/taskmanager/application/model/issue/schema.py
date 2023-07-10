import uuid
from datetime import datetime

from pydantic import BaseModel


class IssueNewSchema(BaseModel):
    username: str
    subject: str
    description: str
    station_id: uuid.UUID
    road_segment_id: uuid.UUID


class IssueSchema(IssueNewSchema):
    id: uuid.UUID
    is_external: bool
    created_on: datetime
    active: bool
    station_name: str
    road_segment_name: str
