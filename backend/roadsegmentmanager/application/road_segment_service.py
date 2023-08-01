import uuid

from eventsourcing.application import AggregateNotFound
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

import base.main
from roadsegmentmanager.application.exceptions.app_road_segment_exception import AppRoadSegmentException
from roadsegmentmanager.application.model import schema
from roadsegmentmanager.domain.model.roadsegment import RoadSegment
from stationmanager.application.station_projector import StationProjector


class RoadSegmentService(ProcessApplication):

    def create_road_segment(self, segment: schema.RoadSegmentNewSchema) -> uuid.UUID:
        segment = RoadSegment(name=segment.name, ssud=segment.ssud, is_active=True)
        self.save(segment)
        return segment.id

    def remove_road_segment(self, segment: schema.RoadSegmentIdSchema):
        try:
            segment: RoadSegment = self.repository.get(segment.id)
        except AggregateNotFound:
            raise AppRoadSegmentException("Road segment not found")
        station_projector: StationProjector = base.main.runner.get(StationProjector)
        stations = station_projector.get_by_road_segment(road_segment_id=segment.id, active_only=True)
        if len(stations) > 0:
            raise AppRoadSegmentException("Cannot remove road segment with stations")

        segment.remove()
        self.save(segment)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""
