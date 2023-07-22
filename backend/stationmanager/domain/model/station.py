import datetime
import uuid
from typing import Optional

from eventsourcing.domain import Aggregate, event


class Station(Aggregate):
    class CreatedEvent(Aggregate.Created):
        name: str
        road_segment_id: uuid
        km_of_road: Optional[float]
        km_of_road_note: str
        latitude: Optional[float]
        longitude: Optional[float]
        see_level: Optional[int]
        legacy_ids: str
        description: str

    class StationRemoved(Aggregate.Event):
        removed_at: datetime.datetime = datetime.datetime.now()

    class StationRelocated(Aggregate.Event):
        new_road_segment_id: uuid

    @event(CreatedEvent)
    def __init__(self, name: str, road_segment_id: uuid, km_of_road: Optional[float], km_of_road_note: str,
                 latitude: Optional[float],
                 longitude: Optional[float], see_level: Optional[int], description: str, legacy_ids: str):
        self.is_removed = False
        self.name = name
        self.road_segment_id = road_segment_id
        self.km_of_road = km_of_road
        self.km_of_road_note = km_of_road_note
        self.latitude = latitude
        self.longitude = longitude
        self.see_level = see_level
        self.description = description
        self.legacy_ids = legacy_ids

    @event(StationRemoved)
    def _remove(self):
        self.is_removed = True

    def remove(self):
        if not self.is_removed:
            self._remove()

    def relocate_station(self, new_road_segment_id: uuid):
        if self.road_segment_id != new_road_segment_id:
            self._relocate_station(new_road_segment_id=new_road_segment_id)

    @event(StationRelocated)
    def _relocate_station(self, new_road_segment_id: uuid):
        self.road_segment_id = new_road_segment_id
