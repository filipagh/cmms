from eventsourcing.domain import Aggregate, event


class RoadSegment(Aggregate):
    class CreatedEvent(Aggregate.Created):
        name: str
        ssud: str
        is_active: bool

        class_version = 2

        @staticmethod
        def upcast_v1_v2(state):
            state["is_active"] = True

    class Removed(Aggregate.Event):
        pass

    @event(CreatedEvent)
    def __init__(self, name: str, ssud: str, is_active: bool):
        self.name = name
        self.ssud = ssud
        self.is_active = is_active

    @event(Removed)
    def _remove(self):
        self.is_active = False

    def remove(self):
        if self.is_active:
            self._remove()

    class_version = 2

    @staticmethod
    def upcast_v1_v2(state):
        state["is_active"] = True
