import uuid

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo

from base import main
from base.auth_def import custom_auth, read_permission, write_permission
from stationmanager.application.invesment_contract.investment_contract_projector import InvestmentContractProjector
from stationmanager.application.invesment_contract.investment_contract_service import InvestmentContractService
from stationmanager.application.invesment_contract.model.schema import InvestmentContractNewSchema
from stationmanager.application.service_contract.model import schema

investment_contract_router = APIRouter(
    prefix="/investment-contract",
    tags=["Investment_Contract"],
    responses={404: {"description": "Not found"}},
)


@investment_contract_router.post("/create_contract",
                                 response_model=uuid.UUID)
def create_contract(new_contract: InvestmentContractNewSchema,
                    _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    investment_contract_service: InvestmentContractService = main.runner.get(InvestmentContractService)
    return investment_contract_service.create_new_contract(new_contract.identifier, new_contract.valid_from,
                                                           new_contract.valid_until, new_contract.warranty_period_days)


@investment_contract_router.get("/contract",
                                response_model=InvestmentContractNewSchema)
def get_contract(contract_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    return main.runner.get(InvestmentContractProjector).get_by_id(contract_id)


@investment_contract_router.get("/contracts",
                                response_model=list[schema.ServiceContractSchema])
def get_contracts(only_active=True, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    return main.runner.get(InvestmentContractProjector).get_all(only_active)
