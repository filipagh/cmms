from datetime import datetime

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.domain.model.investment_contract import InvestmentContract


class InvestmentContractService(ProcessApplication):

    def create_new_contract(self, identifier: str, valid_from: datetime.date, valid_until: datetime.date,
                            warranty_period_days: int):
        contract: InvestmentContract = InvestmentContract(identifier=identifier, valid_from=valid_from,
                                                          valid_until=valid_until,
                                                          warranty_period_days=warranty_period_days)
        self.save(contract)
        return contract.id

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""
