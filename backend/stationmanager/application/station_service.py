import uuid

from eventsourcing.application import AggregateNotFound
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

import base.main
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.application.exceptions.AppStationException import AppStationException
from stationmanager.application.model import schema
from stationmanager.domain.model.assigned_component import AssignedComponentState
from stationmanager.domain.model.station import Station


class StationService(ProcessApplication):

    def create_station(self, station: schema.StationNewSchema) -> uuid.UUID:
        station = Station(name=station.name, road_segment_id=station.road_segment_id, km_of_road=station.km_of_road,
                          km_of_road_note=station.km_of_road_note, latitude=station.latitude,
                          longitude=station.longitude, see_level=station.see_level, description=station.description,
                          legacy_ids="")
        self.save(station)
        return station.id

    def create_station_legacy(self, station: schema.StationNewSchema, legacy_ids: str) -> uuid.UUID:
        station = Station(name=station.name, road_segment_id=station.road_segment_id, km_of_road=station.km_of_road,
                          km_of_road_note=station.km_of_road_note, latitude=station.latitude,
                          longitude=station.longitude, see_level=station.see_level, description=station.description,
                          legacy_ids=legacy_ids)
        self.save(station)
        return station.id

    def remove_station(self, station: schema.StationIdSchema):
        assigned_component_projector: AssignedComponentProjector = base.main.runner.get(AssignedComponentProjector)
        assigned_components = assigned_component_projector.get_by_station(station.id)
        for assigned_component in assigned_components:
            if (assigned_component.status in (
                    AssignedComponentState.INSTALLED, AssignedComponentState.WILL_BE_REMOVED)):
                raise AppStationException("Cannot remove station with installed components")
        try:
            station = self.repository.get(station.id)
        except AggregateNotFound:
            raise AppStationException("Station not found")
        station.remove()
        self.save(station)

    def relocate_station(self, station: schema.StationRelocateSchema):
        road_segment = base.main.runner.get(RoadSegmentProjector).get_by_id(station.new_road_segment_id)
        if road_segment is None:
            raise AppStationException("Road segment not found")
        try:
            station_agg: Station = self.repository.get(station.station_id)
        except AggregateNotFound:
            raise AppStationException("Station not found")
        station_agg.relocate_station(station.new_road_segment_id)
        self.save(station_agg)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""
