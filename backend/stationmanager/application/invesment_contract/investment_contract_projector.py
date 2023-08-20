import uuid
from typing import Optional

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from stationmanager.application.invesment_contract.model.schema import InvestmentContractSchema
from stationmanager.domain.model.investment_contract import InvestmentContract
from stationmanager.infrastructure.persistence import investment_contract_repo
from stationmanager.infrastructure.persistence.investment_contract_repo import InvestmentContractModel


class InvestmentContractProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(InvestmentContract.Created)
    def _(self, domain_event: InvestmentContract.Created, process_event):
        investment_contract_repo.save_new(
            InvestmentContractModel(id=domain_event.originator_id,
                                    created_at=domain_event.create_timestamp().date(),
                                    identifier=domain_event.identifier,
                                    valid_until=domain_event.valid_until,
                                    valid_from=domain_event.valid_from,
                                    warranty_period_days=domain_event.warranty_period_days))

    def get_by_id(self, contract_id: uuid.UUID) -> Optional[InvestmentContractSchema]:
        contract = investment_contract_repo.get_contract_by_id(contract_id)
        if contract is None:
            return None
        return self._model_to_schema(contract)

    def get_all(self, only_active=True) -> list[InvestmentContractSchema]:
        contracts = investment_contract_repo.get_all_contracts(only_active=only_active)
        return list(map(lambda x: self._model_to_schema(x), contracts))

    def _model_to_schema(self, model: InvestmentContractModel) -> InvestmentContractSchema:
        dic = model.__dict__
        return InvestmentContractSchema(**dic)
