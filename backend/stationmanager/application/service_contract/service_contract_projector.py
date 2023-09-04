import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.application.service_contract.model.schema import ServiceContractSchema, \
    ServiceContractStationComponentsSchema
from stationmanager.domain.model.service_contract import ServiceContract
from stationmanager.infrastructure.persistence import service_contract_repo
from stationmanager.infrastructure.persistence.service_contract_repo import StationServiceContractModel, \
    ServiceContractModel, ComponentServiceContractModel


class ServiceContractProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(ServiceContract.Created)
    def _(self, domain_event: ServiceContract.Created, process_event):
        station_col = []
        for station in domain_event.station_id_with_component_ids_list.keys():
            component_list = []
            for component in domain_event.station_id_with_component_ids_list[station]:
                component_list.append(ComponentServiceContractModel(station_id=station, component_id=component))
            station_col.append(StationServiceContractModel(
                station_id=station,
                contract_id=domain_event.originator_id,
                components_id_list=component_list
            ))

        service_contract_repo.save_new(
            ServiceContractModel(id=domain_event.originator_id,
                                 created_at=domain_event.create_timestamp().date(),
                                 name=domain_event.name,
                                 valid_until=domain_event.valid_until,
                                 valid_from=domain_event.valid_from,
                                 station_id_list=station_col
                                 ))

    def get_by_id(self, contract_id: uuid.UUID) -> ServiceContractSchema:
        return _model_to_schema(service_contract_repo.get_contract_by_id(contract_id))

    def get_by_station(self, station_id: uuid.UUID) -> list[ServiceContractSchema]:
        col = []
        for i in service_contract_repo.get_contract_by_station_id(station_id):
            col.append(_model_to_schema(i))
        return col

    def get_all(self) -> list[ServiceContractSchema]:
        col = []
        for i in service_contract_repo.get_all_contracts():
            col.append(_model_to_schema(i))
        return col

    def get_all_active(self) -> list[ServiceContractSchema]:
        col = []
        for i in service_contract_repo.get_all_contracts(only_active=True):
            col.append(_model_to_schema(i))
        return col

    def search(self, query) -> list[ServiceContractSchema]:
        col = []
        contracts = service_contract_repo.search(query)
        for i in contracts:
            col.append(_model_to_schema(i))
        return col


def _model_to_schema(model: ServiceContractModel) -> ServiceContractSchema:
    dic = model.__dict__
    stations = dic.pop("station_id_list")
    station_id_list = []
    s: StationServiceContractModel
    for s in stations:
        components = []
        for c in s.components_id_list:
            components.append(c.component_id)
        station_id_list.append(ServiceContractStationComponentsSchema(
            station_id=s.station_id,
            component_id_list=components))
    return ServiceContractSchema(**dic, stations_list=station_id_list)
