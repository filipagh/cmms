import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.assigned_component import AssignedComponent
from stationmanager.domain.model.service_contract import ServiceContract
from stationmanager.infrastructure.persistence import assigned_component_repo, service_contract_repo
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

    def get_by_station(self, station_id: uuid.UUID) -> list[AssignedComponentModel]:
        return service_contract_repo.get_contract_by_station_id(station_id)
