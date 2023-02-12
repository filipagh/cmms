import uuid
from datetime import datetime

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.assigned_component import AssignedComponent, AssignedComponentState
from stationmanager.domain.model.service_contract import ServiceContract
from stationmanager.domain.waranty_calculator_service import warranty_until_date_calc
from taskmanager.domain.model.tasks.task_change_components import TaskChangeComponents


class ServiceContractService(ProcessApplication):

    def create_new_contract(self, name: str, valid_from: datetime.date, valid_until: datetime.date,
                            station_id_list: list[uuid]):
        contract: ServiceContract = ServiceContract(name=name, valid_from=valid_from, valid_until=valid_until,
                                                    station_id_list=station_id_list)
        self.save(contract)
        return contract.id

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""
