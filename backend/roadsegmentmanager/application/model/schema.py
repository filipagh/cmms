import uuid

from pydantic import BaseModel


class RoadSegmentSchemaBASE(BaseModel):
    name: str
    ssud: str



class RoadSegmentNewSchema(RoadSegmentSchemaBASE):
    pass


class RoadSegmentIdSchema(BaseModel):
    id: uuid.UUID


class RoadSegmentSchema(RoadSegmentIdSchema, RoadSegmentSchemaBASE):
    is_active: bool
