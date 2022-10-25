import uuid

from eventsourcing.domain import Aggregate, event


class RoadSegment(Aggregate):
    class CreatedEvent(Aggregate.Created):
        name: str
        ssud: str

    # class AssetAddedToStorage(Aggregate.Event):
    #     count_number: int

    # @event(AssetAddedToStorage)
    # def add_to_storage(self, count_number: int):
    #     self.in_storage += count_number

    @event(CreatedEvent)
    def __init__(self, name: str, ssud: str):
        self.name = name
        self.ssud = ssud
