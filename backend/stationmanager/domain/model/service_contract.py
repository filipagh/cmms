import datetime
import uuid

from eventsourcing.domain import Aggregate, event


class ServiceContract(Aggregate):
    class Created(Aggregate.Created):
        name: str
        valid_from: datetime.date
        valid_until: datetime.date
        station_id_with_component_ids_list: dict[str, list[uuid]]

    class ComponentAddedToContract(Aggregate.Event):
        component_id: uuid
        station_id: uuid
        valid_until: datetime.date

    class ComponentRemovedFromContract(Aggregate.Event):
        component_id: uuid
        station_id: uuid

    @event(Created)
    def __init__(self, name: str, valid_from: datetime.date, valid_until: datetime.date,
                 station_id_with_component_ids_list: dict[str, list[uuid]]):
        self.is_revoked = False
        self.name = name
        self.valid_from = valid_from
        self.valid_until = valid_until
        self.station_id_with_component_ids_list = station_id_with_component_ids_list

    def add_component(self, component_id: uuid, station_id: uuid):
        self._add_component(component_id=component_id, station_id=station_id, valid_until=self.valid_until)

    @event(ComponentAddedToContract)
    def _add_component(self, component_id: uuid, station_id: uuid, valid_until: datetime.date):
        if str(station_id) not in self.station_id_with_component_ids_list.keys():
            self.station_id_with_component_ids_list[str(station_id)] = []
        self.station_id_with_component_ids_list[str(station_id)].append(component_id)

    @event(ComponentRemovedFromContract)
    def _remove_component(self, component_id: uuid, station_id: uuid):
        self.station_id_with_component_ids_list[str(station_id)].remove(component_id)
        if self.station_id_with_component_ids_list[str(station_id)] == []:
            del self.station_id_with_component_ids_list[str(station_id)]

    def remove_component(self, component_id: uuid, station_id: uuid):
        if component_id in self.station_id_with_component_ids_list[str(station_id)]:
            self._remove_component(component_id=component_id, station_id=station_id)
