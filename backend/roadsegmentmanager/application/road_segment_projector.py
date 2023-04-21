import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from roadsegmentmanager.domain.model.roadsegment import RoadSegment
from roadsegmentmanager.infrastructure.persistence import road_segment_repo
from roadsegmentmanager.infrastructure.persistence.road_segment_repo import RoadSegmentModel


class RoadSegmentProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(RoadSegment.CreatedEvent)
    def _(self, domain_event: RoadSegment.CreatedEvent, process_event):
        model = road_segment_repo.RoadSegmentModel(
            id=domain_event.originator_id,
            name=domain_event.name,
            ssud=domain_event.ssud)
        road_segment_repo.save(model)

    @policy.register(RoadSegment.Removed)
    def _(self, domain_event: RoadSegment.Removed, process_event):
        model = road_segment_repo.get_by_id(domain_event.originator_id)
        model.is_active = False
        road_segment_repo.save(model)

    def get_by_id(self, segment_id: uuid.UUID) -> RoadSegmentModel:
        return road_segment_repo.get_by_id(segment_id)

    def get_all(self, only_active: bool = False) -> list[RoadSegmentModel]:
        return road_segment_repo.get_road_segments(only_active)
