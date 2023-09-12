from datetime import datetime
from typing import List

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

import base.main
from stationmanager.application.service_contract.model.schema import ServiceContractStationComponentsSchema
from stationmanager.application.service_contract.service_contract_projector import ServiceContractProjector
from stationmanager.domain.model.assigned_component import AssignedComponent
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

    @policy.register(AssignedComponent.CreatedEvent)
    def _(self, domain_event: AssignedComponent.CreatedEvent, process_event):
        if len(domain_event.service_contracts_id) > 0:
            for contract_id in domain_event.service_contracts_id:
                contract: ServiceContract = self.repository.get(contract_id)
                contract.add_component(domain_event.originator_id, domain_event.station_id)
                self.save(contract)

    @policy.register(AssignedComponent.OverwriteComponentWarranty)
    def _(self, domain_event: AssignedComponent.OverwriteComponentWarranty, process_event):
        actual_contracts = base.main.runner.get(ServiceContractProjector).get_by_component(domain_event.originator_id)
        actual_contracts_ids = []
        for c in actual_contracts:
            actual_contracts_ids.append(c.id)

        for contract_id in domain_event.service_contracts_id:
            if contract_id not in actual_contracts_ids:
                contract: ServiceContract = self.repository.get(contract_id)
                contract.add_component(domain_event.originator_id, domain_event.station_id)
                self.save(contract)
                actual_contracts_ids.append(contract.id)

        for contract_to_remove in actual_contracts_ids:
            if contract_to_remove not in domain_event.service_contracts_id:
                contract: ServiceContract = self.repository.get(contract_to_remove)
                contract.remove_component(domain_event.originator_id, domain_event.station_id)
                self.save(contract)
