import uuid

from pydantic import BaseModel

from stationmanager.domain.model.assigned_component import AssignedComponentState


class AssignedComponentSchemaBASE(BaseModel):
    asset_id: uuid.UUID
    station_id: uuid.UUID


class AssignedComponentNewSchema(AssignedComponentSchemaBASE):
    pass


class AssignedComponentIdSchema(AssignedComponentSchemaBASE):
    id: uuid.UUID


class AssignedComponentSchema(AssignedComponentIdSchema):
    status: AssignedComponentState
