import uuid
from typing import Optional

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo

from base import main
from base.auth_def import custom_auth, read_permission, write_permission
from stationmanager.application.model import schema
from stationmanager.application.station_projector import StationProjector
from stationmanager.application.station_service import StationService

station_router = APIRouter(
    prefix="/station",
    tags=["Station"],
    responses={404: {"description": "Not found"}},
)


@station_router.post("/create_station",
                     response_model=uuid.UUID)
def create_station(new_station: schema.StationNewSchema, _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    segment_service = main.runner.get(StationService)
    return segment_service.create_station(new_station)


@station_router.delete("/remove_station")
def remove_station(station_id: schema.StationIdSchema, _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    segment_service = main.runner.get(StationService)
    segment_service.remove_station(station_id)


@station_router.get("/station",
                    response_model=schema.StationSchema)
def get_by_id(segment_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector = main.runner.get(StationProjector)

    return schema.StationSchema(**projector.get_by_id(segment_id).__dict__)


@station_router.get("/stations",
                    response_model=list[schema.StationSchema])
def get_all(
        road_segment_id: Optional[uuid.UUID] = None, _user: FiefUserInfo = Depends(custom_auth(read_permission))
):
    projector = main.runner.get(StationProjector)
    col = []
    if road_segment_id:
        stations = projector.get_by_road_segment(road_segment_id)
    else:
        stations = projector.get_all()
    for i in stations:
        col.append(schema.StationSchema(**i.__dict__))
    return col
