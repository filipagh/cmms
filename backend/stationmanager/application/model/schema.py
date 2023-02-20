import uuid

from pydantic import BaseModel


class StationSchemaBASE(BaseModel):
    name: str
    road_segment_id: uuid.UUID
    km_of_road: float
    km_of_road_note: str
    latitude: float
    longitude: float
    see_level: int
    description: str

class StationNewSchema(StationSchemaBASE):
    pass


class StationIdSchema(BaseModel):
    id: uuid.UUID


class StationSchema(StationIdSchema, StationSchemaBASE):
    pass
