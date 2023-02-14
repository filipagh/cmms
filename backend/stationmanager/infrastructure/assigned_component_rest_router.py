import uuid
from typing import Optional

from fastapi import APIRouter

from base import main
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
def create_installed_component(new_components: list[schema.AssignedComponentNewSchema], warranty_period_days: int):
    segment_service = main.runner.get(AssignedComponentsService)
    ids = []
    for c in new_components:
        ids.append(segment_service.create_installed_component(c.asset_id, c.station_id, warranty_period_days))
    return ids

@assigned_component_router.post("/remove_installed_component",
                     response_model=list[uuid.UUID])
def remove_installed_component(components_to_remove: list[schema.AssignedComponentIdSchema]):
    segment_service = main.runner.get(AssignedComponentsService)
    ids = []
    for c in components_to_remove:
        ids.append(segment_service.force_remove_installed_component(c.id))
    return ids

#
# @assigned_component_router.get("/station",
#                     response_model=schema.StationSchema)
# def get_by_id(segment_id: uuid.UUID):
#     projector = main.runner.get(StationProjector)
#
#     return schema.StationSchema(**projector.get_by_id(segment_id).__dict__)
#

@assigned_component_router.get("/components",
                               response_model=list[schema.AssignedComponentSchema])
def get_all(
        station_id: Optional[uuid.UUID] = None
):
    projector = main.runner.get(AssignedComponentProjector)
    col = []
    components = projector.get_by_station(station_id)

    for i in components:
        col.append(schema.AssignedComponentSchema(**i.__dict__))
    return col
