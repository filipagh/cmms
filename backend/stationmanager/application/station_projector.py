import uuid
from typing import Optional

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.application.model.schema import StationSchema
from stationmanager.domain.model.station import Station
from stationmanager.infrastructure.persistence import station_repo
from stationmanager.infrastructure.persistence.station_repo import StationModel


class StationProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(Station.CreatedEvent)
    def _(self, domain_event: Station.CreatedEvent, process_event):
        model = station_repo.StationModel(
            id=domain_event.originator_id,
            name=domain_event.name,
            road_segment_id=domain_event.road_segment_id,
            km_of_road=domain_event.km_of_road,
            km_of_road_note=domain_event.km_of_road_note,
            latitude=domain_event.latitude,
            longitude=domain_event.longitude,
            see_level=domain_event.see_level,
            description=domain_event.description,
            legacy_ids=domain_event.legacy_ids
        )
        station_repo.save(model)

    @policy.register(Station.StationRelocated)
    def _(self, domain_event: Station.StationRelocated, process_event):
        station = station_repo.get_by_id(domain_event.originator_id)
        station.road_segment_id = domain_event.new_road_segment_id
        station_repo.save(station)

    @policy.register(Station.StationRemoved)
    def _(self, domain_event: Station.StationRemoved, process_event):
        station_repo.mark_station_as_inactive(domain_event.originator_id)

    def get_by_id(self, station_id: uuid.UUID) -> Optional[StationModel]:
        return station_repo.get_by_id(station_id)

    def get_by_road_segment(self, road_segment_id: uuid.UUID, active_only: bool = False, ) -> list[StationModel]:
        return station_repo.get_by_road_segment(road_segment_id, active_only=active_only)

    def get_all(self, page, page_size, active_only: bool = False, segment_id: uuid.UUID = None) -> \
            list[StationModel]:
        return station_repo.get_stations(active_only, segment_id, page, page_size)

    def get_all_active(self) -> list[StationModel]:
        return station_repo.get_stations(active_only=True)

    def search(self, query: str, page, page_size, active_only: bool = False) -> list[StationSchema]:
        col = []
        search = station_repo.search(query, active_only=active_only, page=page, page_size=page_size)
        for i in search:
            col.append(StationSchema(**i.__dict__))
        return col
