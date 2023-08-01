import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.application.service_contract.model.schema import ServiceContractSchema
from stationmanager.domain.model.service_contract import ServiceContract
from stationmanager.infrastructure.persistence import service_contract_repo
from stationmanager.infrastructure.persistence.assigned_component_repo import AssignedComponentModel
from stationmanager.infrastructure.persistence.service_contract_repo import StationServiceContractModel, \
    ServiceContractModel


class ServiceContractProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(ServiceContract.Created)
    def _(self, domain_event: ServiceContract.Created, process_event):
        station_col = []
        for i in domain_event.station_id_list:
            station_col.append(StationServiceContractModel(
                station_id=i,
                contract_id=domain_event.originator_id,
            ))

        service_contract_repo.save_new(
            ServiceContractModel(id=domain_event.originator_id,
                                 created_at=domain_event.create_timestamp().date(),
                                 name=domain_event.name,
                                 valid_until=domain_event.valid_until,
                                 valid_from=domain_event.valid_from,
                                 station_id_list=station_col
                                 ))

    def get_by_id(self, contract_id: uuid.UUID) -> AssignedComponentModel:
        return service_contract_repo.get_contract_by_id(contract_id)

    def get_by_station(self, station_id: uuid.UUID) -> list[ServiceContractModel]:
        return service_contract_repo.get_contract_by_station_id(station_id)

    def get_all(self) -> list[ServiceContractModel]:
        return service_contract_repo.get_all_contracts()

    def get_all_active(self) -> list[ServiceContractModel]:
        return service_contract_repo.get_all_contracts(only_active=True)

    def search(self, query):
        col = []
        contracts = service_contract_repo.search(query)
        for i in contracts:
            col.append(_model_to_schema(i))
        return col


def _model_to_schema(model: ServiceContractModel):
    dic = model.__dict__
    stations = dic.pop("station_id_list")
    station_id_list = []
    s: StationServiceContractModel
    for s in stations:
        station_id_list.append(s.station_id)
    return ServiceContractSchema(**dic, station_id_list=station_id_list)
