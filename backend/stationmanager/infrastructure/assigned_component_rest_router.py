import datetime
import uuid
from typing import Optional

from fastapi import APIRouter, Depends, Query
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

from base import main
from base.auth_def import custom_auth, read_permission, admin_permission
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.application.assigned_component.assigned_component_service import AssignedComponentsService
from stationmanager.application.assigned_component.model import schema
from stationmanager.domain.model.assigned_component import ComponentWarrantySource
from taskmanager.application.model.task_change_component.schema import ComponentWarranty

assigned_component_router = APIRouter(
    prefix="/assigned_components",
    tags=["Assigned Components"],
    responses={404: {"description": "Not found"}},
)


@assigned_component_router.post("/create_installed_component",
                                response_model=list[uuid.UUID])
def create_installed_component(new_components: list[schema.AssignedComponentNewSchema],
                               components_warranty_source: ComponentWarrantySource,
                               installation_date: datetime.datetime,
                               component_warranty_id: Optional[uuid.UUID] = None,
                               component_warranty_until: Optional[datetime.datetime] = None,
                               paid_service_until: Optional[datetime.datetime] = None,
                               _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    segment_service = main.runner.get(AssignedComponentsService)
    ids = []
    for c in new_components:
        ids.append(
            segment_service.create_installed_component(asset_id=c.asset_id, station_id=c.station_id,
                                                       component_warranty_until=component_warranty_until,
                                                       components_warranty_source=components_warranty_source,
                                                       component_warranty_id=component_warranty_id,
                                                       paid_service_until=paid_service_until,
                                                       serial_number=c.serial_number,
                                                       installation_date=installation_date,

                                                       service_contracts_id=c.service_contracts_id))
    return ids


@assigned_component_router.post("/override_warranty", response_class=PlainTextResponse)
def override_warranty(component_id: uuid.UUID,
                      component_warranty_source: ComponentWarrantySource,
                      component_warranty_id: Optional[uuid.UUID] = None,
                      component_warranty_until: Optional[datetime.datetime] = None,
                      paid_service_until: Optional[datetime.datetime] = None,
                      service_contracts_id: Optional[list[uuid.UUID]] = Query([]),
                      _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    segment_service = main.runner.get(AssignedComponentsService)
    segment_service.override_warranty(component_id=component_id, component_warranty_id=component_warranty_id,
                                      component_warranty_until=component_warranty_until,
                                      component_warranty_source=component_warranty_source,
                                      paid_service_until=paid_service_until, service_contracts_id=service_contracts_id)
    return "OK"


@assigned_component_router.post("/remove_installed_component",
                                response_model=list[uuid.UUID])
def remove_installed_component(components_to_remove: list[schema.AssignedComponentIdSchema],
                               uninstall_date: datetime.datetime,
                               _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    segment_service = main.runner.get(AssignedComponentsService)
    ids = []
    for c in components_to_remove:
        ids.append(segment_service.force_remove_installed_component(c.id, uninstall_date=uninstall_date))
    return ids


@assigned_component_router.get("/components",
                               response_model=list[schema.AssignedComponentSchema])
def get_all(
        station_id: Optional[uuid.UUID] = None, _user: FiefUserInfo = Depends(custom_auth(read_permission))
):
    projector: AssignedComponentProjector = main.runner.get(AssignedComponentProjector)
    col = []
    components = projector.get_by_station(station_id)

    for i in components:
        col.append(schema.AssignedComponentSchema(**i.__dict__))
    return col


@assigned_component_router.get("/replacment_warranry",
                               response_model=ComponentWarranty)
def get_replacment_warranty(
        component_id: uuid.UUID = None, _user: FiefUserInfo = Depends(custom_auth(read_permission))
):
    service: AssignedComponentsService = main.runner.get(AssignedComponentsService)
    return service.calculate_replacement_warranty(component_id)
