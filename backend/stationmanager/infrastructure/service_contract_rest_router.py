import uuid

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo

from base import main
from base.auth_def import custom_auth, read_permission, write_permission
from stationmanager.application.model.schema import StationIdSchema
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
def create_contract(new_contract: schema.ServiceContractNewSchema,
                    _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    service_contract_service = main.runner.get(ServiceContractService)
    return service_contract_service.create_new_contract(new_contract.name, new_contract.valid_from,
                                                        new_contract.valid_until, new_contract.station_id_list)


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
def get(station_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector = main.runner.get(ServiceContractProjector)
    col = []
    contracts = projector.get_by_station(station_id)
    for i in contracts:
        col.append(_model_to_schema(i))

    return col


@service_contract_router.get("/contract",
                             response_model=schema.ServiceContractSchema)
def get_contract(contract_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector = main.runner.get(ServiceContractProjector)
    return _model_to_schema(projector.get_by_id(contract_id))


@service_contract_router.get("/contracts",
                             response_model=list[schema.ServiceContractSchema])
def get_contracts(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector = main.runner.get(ServiceContractProjector)
    col = []
    contracts = projector.get_all()
    for i in contracts:
        col.append(_model_to_schema(i))

    return col


@service_contract_router.get("/stations_without_contract",
                             response_model=list[StationIdSchema])
def get_stations_without_contract(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    station_projector = main.runner.get(StationProjector)
    projector = main.runner.get(ServiceContractProjector)
    station_ids = []
    for s in station_projector.get_all(active_only=True):
        station_ids.append(s.id)

    col = []
    contracts = projector.get_all_active()
    for i in contracts:
        for s in i.station_id_list:
            try:
                station_ids.remove(s.station_id)
            except ValueError:
                pass

    for i in station_ids:
      col.append(StationIdSchema(id=i))
    return col
