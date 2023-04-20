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

    # class AssetAddedToStorage(Aggregate.Event):
    #     count_number: int

    # @event(AssetAddedToStorage)
    # def add_to_storage(self, count_number: int):
    #     self.in_storage += count_number

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
