import os
import uuid

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo
from starlette.background import BackgroundTasks
from starlette.responses import FileResponse

from base import main
from base.auth_def import custom_auth, read_permission, write_permission
from stationmanager.application.model.schema import StationIdSchema
from stationmanager.application.service_contract import service_contract_xsl_exporter
from stationmanager.application.service_contract.model import schema
from stationmanager.application.service_contract.service_contract_projector import ServiceContractProjector
from stationmanager.application.service_contract.service_contract_service import ServiceContractService
from stationmanager.application.station_projector import StationProjector

service_contract_router = APIRouter(
    prefix="/service-contract",
    tags=["Service_Contract"],
    responses={404: {"description": "Not found"}},
)


@service_contract_router.post("/create_contract",
                              response_model=uuid.UUID)
def create_contract(new_contract: schema.ServiceContractNewSchema,
                    _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    service_contract_service: ServiceContractService = main.runner.get(ServiceContractService)
    return service_contract_service.create_new_contract(new_contract.name, new_contract.valid_from,
                                                        new_contract.valid_until,
                                                        new_contract.stations_list)


@service_contract_router.get("/contract_for_station",
                             response_model=list[schema.ServiceContractSchema])
def get(station_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector: ServiceContractProjector = main.runner.get(ServiceContractProjector)
    return projector.get_by_station(station_id)


@service_contract_router.get("/contracts_for_component",
                             response_model=list[schema.ServiceContractSchema])
def get(component_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector: ServiceContractProjector = main.runner.get(ServiceContractProjector)
    return projector.get_by_component(component_id)


@service_contract_router.get("/contract",
                             response_model=schema.ServiceContractSchema)
def get_contract(contract_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector = main.runner.get(ServiceContractProjector)
    return projector.get_by_id(contract_id)


@service_contract_router.get("/contracts",
                             response_model=list[schema.ServiceContractSchema])
def get_contracts(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector: ServiceContractProjector = main.runner.get(ServiceContractProjector)
    return projector.get_all()


@service_contract_router.get("/contracts_search",
                             response_model=list[schema.ServiceContractSchema])
def search(query: str, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector: ServiceContractProjector = main.runner.get(ServiceContractProjector)
    return projector.search(query)


@service_contract_router.get("/stations_without_contract",
                             response_model=list[StationIdSchema])
def get_stations_without_contract(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    station_projector: StationProjector = main.runner.get(StationProjector)
    projector: ServiceContractProjector = main.runner.get(ServiceContractProjector)
    station_ids = []
    for s in station_projector.get_all_active():
        station_ids.append(s.id)

    col = []
    contracts = projector.get_all_active()
    for i in contracts:
        for s in i.stations_list:
            try:
                station_ids.remove(s.station_id)
            except ValueError:
                pass

    for i in station_ids:
        col.append(StationIdSchema(id=i))
    return col


@service_contract_router.get("/stations_without_contract/export_xsl",
                             response_class=FileResponse)
def get_stations_without_contract_export(background_tasks: BackgroundTasks,
                                         _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    name = service_contract_xsl_exporter.export_stations_without_service_contract_xslx()
    background_tasks.add_task(delete_file, name)
    return FileResponse(name, media_type='application/octet-stream', filename=name)


def delete_file(name):
    os.remove(name)
