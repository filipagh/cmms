import uuid

from fastapi import APIRouter

from base import main

from stationmanager.application.model import schema
from stationmanager.application.station_projector import StationProjector
from stationmanager.application.station_service import StationService

station_router = APIRouter(
    prefix="/station",
    tags=["Station Manager"],
    responses={404: {"description": "Not found"}},
)


@station_router.post("/create_station",
                     response_model=uuid.UUID)
def create_station(new_station: schema.StationNewSchema):
    segment_service = main.runner.get(StationService)
    return segment_service.create_road_segment(new_station)


@station_router.get("/station",
                    response_model=schema.StationSchema)
def get_by_id(segment_id: uuid.UUID):
    projector = main.runner.get(StationProjector)

    return schema.StationSchema(**projector.get_by_id(segment_id).__dict__)


@station_router.get("/segments",
                    response_model=list[schema.StationSchema])
def get_all():
    projector = main.runner.get(StationProjector)
    col = []
    for i in projector.get_all():
        col.append(schema.StationSchema(**i.__dict__))
    return col
