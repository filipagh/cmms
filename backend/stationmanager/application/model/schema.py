import uuid

from pydantic import BaseModel


class StationSchemaBASE(BaseModel):
    name: str
    road_segment_id: uuid.UUID


class StationNewSchema(StationSchemaBASE):
    pass


class StationIdSchema(BaseModel):
    id: uuid.UUID


class StationSchema(StationIdSchema, StationSchemaBASE):
    pass
