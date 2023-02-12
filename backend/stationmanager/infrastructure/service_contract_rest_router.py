import uuid
from typing import Optional

from fastapi import APIRouter

from base import main
from stationmanager.application.service_contract.model import schema
from stationmanager.application.service_contract.model.schema import ServiceContractSchema
from stationmanager.application.service_contract.service_contract_projector import ServiceContractProjector
from stationmanager.application.service_contract.service_contract_service import ServiceContractService
from stationmanager.application.station_projector import StationProjector
from stationmanager.infrastructure.persistence.service_contract_repo import ServiceContractModel, \
    StationServiceContractModel

service_contract_router = APIRouter(
    prefix="/service-contract",
    tags=["Service_Contract"],
    responses={404: {"description": "Not found"}},
)


@service_contract_router.post("/create_contract",
                              response_model=uuid.UUID)
def create_contract(new_contract: schema.ServiceContractNewSchema):
    service_contract_service = main.runner.get(ServiceContractService)
    return service_contract_service.create_new_contract(new_contract.name,new_contract.valid_from,new_contract.valid_until,new_contract.station_id_list)


def _model_to_schema(model: ServiceContractModel):
    dic = model.__dict__
    stations = dic.pop("station_id_list")
    station_id_list = []
    s: StationServiceContractModel
    for s in stations:
        station_id_list.append(s.station_id)
    return ServiceContractSchema(**dic, station_id_list=station_id_list)


@service_contract_router.get("/contract_for_station",
                             response_model=list[schema.ServiceContractSchema])
def get(station_id: uuid.UUID):
    projector = main.runner.get(ServiceContractProjector)
    col = []
    contracts = projector.get_by_station(station_id)
    for i in contracts:
        col.append(_model_to_schema(i))

    return col


@service_contract_router.get("/contract",
                             response_model=schema.ServiceContractSchema)
def get_contract(contract_id: uuid.UUID):
    projector = main.runner.get(ServiceContractProjector)
    return _model_to_schema(projector.get_by_id(contract_id))

@service_contract_router.get("/contracts",
                             response_model=list[schema.ServiceContractSchema])
def get_contracts():
    projector = main.runner.get(ServiceContractProjector)
    col = []
    contracts = projector.get_all()
    for i in contracts:
        col.append(_model_to_schema(i))

    return col
