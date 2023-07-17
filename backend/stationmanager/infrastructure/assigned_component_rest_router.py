import datetime
import uuid
from typing import Optional

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo

from base import main
from base.auth_def import custom_auth, read_permission, admin_permission
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.application.assigned_component.assigned_component_service import AssignedComponentsService
from stationmanager.application.assigned_component.model import schema

assigned_component_router = APIRouter(
    prefix="/assigned_components",
    tags=["Assigned Components"],
    responses={404: {"description": "Not found"}},
)


@assigned_component_router.post("/create_installed_component",
                                response_model=list[uuid.UUID])
def create_installed_component(new_components: list[schema.AssignedComponentNewSchema], warranty_period_days: int,
                               installation_date: datetime.datetime,
                               _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    segment_service = main.runner.get(AssignedComponentsService)
    ids = []
    for c in new_components:
        ids.append(
            segment_service.create_installed_component(asset_id=c.asset_id, station_id=c.station_id,
                                                       warranty_period_days=warranty_period_days,
                                                       serial_number=c.serial_number,
                                                       installation_date=installation_date))
    return ids


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
    projector = main.runner.get(AssignedComponentProjector)
    col = []
    components = projector.get_by_station(station_id)

    for i in components:
        col.append(schema.AssignedComponentSchema(**i.__dict__))
    return col
