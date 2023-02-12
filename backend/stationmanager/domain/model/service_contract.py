import datetime
import uuid

from eventsourcing.domain import Aggregate, event


class ServiceContract(Aggregate):
    class Created(Aggregate.Created):
        name: str
        valid_from: datetime.date
        valid_until: datetime.date
        station_id_list: list[uuid]

    @event(Created)
    def __init__(self, name: str, valid_from: datetime.date, valid_until: datetime.date, station_id_list: list[uuid]):
        self.is_revoked = False
        self.name = name
        self.valid_from = valid_from
        self.valid_until = valid_until
        self.station_id_list = station_id_list
