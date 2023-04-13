import uuid
from datetime import datetime
from typing import Optional

from pydantic import BaseModel


class IssueSchema(BaseModel):
    id: uuid.UUID
    subject: str
    description: str
    station_id: Optional[str]
    component_id: Optional[str]
    user: str
    created_on: datetime
    active: bool
