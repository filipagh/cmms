import uuid
from typing import Optional

from pydantic import BaseModel


class StationSchemaBASE(BaseModel):
    name: str
    road_segment_id: uuid.UUID
    km_of_road: Optional[float]
    km_of_road_note: str
    latitude: Optional[float]
    longitude: Optional[float]
    see_level: Optional[int]
    description: str

class StationNewSchema(StationSchemaBASE):
    pass


class StationIdSchema(BaseModel):
    id: uuid.UUID


class StationSchema(StationIdSchema, StationSchemaBASE):
    legacy_ids: str
    pass
