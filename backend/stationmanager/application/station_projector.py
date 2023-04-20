import uuid
from typing import Optional

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

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

    @policy.register(Station.StationRemoved)
    def _(self, domain_event: Station.StationRemoved, process_event):
        station_repo.mark_station_as_inactive(domain_event.originator_id)

    def get_by_id(self, id: uuid.UUID) -> Optional[StationModel]:
        return station_repo.get_by_id(id)

    def get_by_road_segment(self, segment_id: uuid.UUID) -> list[StationModel]:
        return station_repo.get_by_road_segment(segment_id)

    def get_all(self, active_only: bool = False) -> list[StationModel]:
        return station_repo.get_road_segments(active_only)
