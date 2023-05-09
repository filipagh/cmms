import uuid
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException
from fief_client import FiefUserInfo
from starlette.background import BackgroundTasks
from starlette.responses import PlainTextResponse, FileResponse

from base import main
from base.auth_def import custom_auth, read_permission, write_permission
from stationmanager.application import station_xsl_exporter
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


@station_router.delete("/remove_station", response_class=PlainTextResponse)
def remove_station(station_id: schema.StationIdSchema, _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    segment_service = main.runner.get(StationService)
    try:
        segment_service.remove_station(station_id)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    return "OK"


@station_router.get("/station",
                    response_model=schema.StationSchema)
def get_by_id(station_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    projector = main.runner.get(StationProjector)

    return schema.StationSchema(**projector.get_by_id(station_id).__dict__)
@station_router.get("/station/export_xsl", response_class=FileResponse)
def export(segment_id: uuid.UUID, background_tasks: BackgroundTasks, _user: FiefUserInfo = Depends(custom_auth(read_permission))):

    name = station_xsl_exporter.export_xslx(segment_id)
    background_tasks.add_task(remove_file, name)
    return FileResponse(name, media_type='application/octet-stream', filename=name)

def remove_file(name: str):
    import os
    os.remove(name)

@station_router.get("/stations",
                    response_model=list[schema.StationSchema])
def get_all(
        road_segment_id: Optional[uuid.UUID] = None, only_active: bool = False,
        _user: FiefUserInfo = Depends(custom_auth(read_permission))
):
    projector = main.runner.get(StationProjector)
    col = []
    stations = projector.get_all(active_only=only_active, segment_id=road_segment_id)
    for i in stations:
        col.append(schema.StationSchema(**i.__dict__))
    return col
