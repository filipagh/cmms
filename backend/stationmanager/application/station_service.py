import uuid

from eventsourcing.application import AggregateNotFound
from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.application.model import schema
from stationmanager.domain.model.station import Station


class StationService(ProcessApplication):

    def create_station(self, station: schema.StationNewSchema) -> uuid.UUID:
        station = Station(name=station.name, road_segment_id=station.road_segment_id, km_of_road=station.km_of_road,
                          km_of_road_note=station.km_of_road_note, latitude=station.latitude,
                          longitude=station.longitude, see_level=station.see_level, description=station.description)
        self.save(station)
        return station.id

    def remove_station(self, station: schema.StationIdSchema):
        try:
            station = self.repository.get(station.id)
        except AggregateNotFound:
            return
        if station.is_removed:
            return
        station.remove()
        self.save(station)

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""
