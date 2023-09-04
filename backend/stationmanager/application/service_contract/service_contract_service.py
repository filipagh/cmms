from datetime import datetime
from datetime import datetime
from typing import List

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.application.service_contract.model.schema import ServiceContractStationComponentsSchema
from stationmanager.domain.model.service_contract import ServiceContract


class ServiceContractService(ProcessApplication):

    def create_new_contract(self, name: str, valid_from: datetime.date, valid_until: datetime.date,
                            station_id_with_component_ids_list: List[ServiceContractStationComponentsSchema]):
        components = {}
        for station in station_id_with_component_ids_list:
            components_list = []
            for component_id in station.component_id_list:
                components_list.append(component_id)
            components[str(station.station_id)] = components_list

        contract: ServiceContract = ServiceContract(
            name=name, valid_from=valid_from, valid_until=valid_until,
            station_id_with_component_ids_list=components)
        self.save(contract)
        return contract.id

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""
