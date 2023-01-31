import datetime
import uuid
from typing import Optional

from pydantic import BaseModel

from stationmanager.domain.model.assigned_component import AssignedComponentState


class AssignedComponentSchemaBASE(BaseModel):
    asset_id: uuid.UUID
    station_id: uuid.UUID


class AssignedComponentNewSchema(AssignedComponentSchemaBASE):
    pass


class AssignedComponentIdSchema(BaseModel):
    id: uuid.UUID


class AssignedComponentSchema(AssignedComponentIdSchema, AssignedComponentSchemaBASE):
    status: AssignedComponentState
    task_id: Optional[uuid.UUID]
    installed_at: datetime.datetime
    removed_at: Optional[datetime.datetime]
    warranty_period_days: int
    warranty_period_until: Optional[datetime.date]
