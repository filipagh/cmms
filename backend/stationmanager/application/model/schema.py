import uuid

from pydantic import BaseModel


class RoadSegmentSchemaBASE(BaseModel):
    name: str
    ssud: str


class RoadSegmentNewSchema(RoadSegmentSchemaBASE):
    pass


class RoadSegmentIdSchema(RoadSegmentSchemaBASE):
    id: uuid.UUID


class RoadSegmentSchema(RoadSegmentIdSchema):
    pass
