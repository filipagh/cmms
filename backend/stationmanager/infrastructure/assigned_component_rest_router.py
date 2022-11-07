import uuid
from typing import Optional

from fastapi import APIRouter

from base import main
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.application.assigned_component.model import schema

from stationmanager.application.station_projector import StationProjector
from stationmanager.application.station_service import StationService
from stationmanager.infrastructure.station_rest_router import station_router

assigned_component_router = APIRouter(
    prefix="/assigned_components",
    tags=["Assigned Components"],
    responses={404: {"description": "Not found"}},
)


# @assigned_component_router.post("/create_station",
#                      response_model=uuid.UUID)
# def create_station(new_station: schema.StationNewSchema):
#     segment_service = main.runner.get(StationService)
#     return segment_service.create_station(new_station)

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
        station_id: uuid.UUID = None
):
    projector = main.runner.get(AssignedComponentProjector)
    col = []
    components = projector.get_by_station(station_id)

    for i in components:
        col.append(schema.AssignedComponentSchema(**i.__dict__))
    return col
