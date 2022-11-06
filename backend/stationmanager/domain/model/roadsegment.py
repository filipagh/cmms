import uuid

from eventsourcing.domain import Aggregate, event


class Station(Aggregate):
    class CreatedEvent(Aggregate.Created):
        name: str
        road_segment_id: uuid

    # class AssetAddedToStorage(Aggregate.Event):
    #     count_number: int

    # @event(AssetAddedToStorage)
    # def add_to_storage(self, count_number: int):
    #     self.in_storage += count_number

    @event(CreatedEvent)
    def __init__(self, name: str, road_segment_id: uuid):
        self.name = name
        self.road_segment_id = road_segment_id
