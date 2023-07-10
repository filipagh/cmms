import uuid

from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

from base import main
from base.auth_def import custom_auth, write_permission, read_permission
from roadsegmentmanager.application.model import schema
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from roadsegmentmanager.application.road_segment_service import RoadSegmentService

road_segment_manager = APIRouter(
    prefix="/road-segment-manager",
    tags=["Road Segment Manager"],
    responses={404: {"description": "Not found"}},
)


@road_segment_manager.post("/create_road_segment",
                           response_model=uuid.UUID)
def create_road_segment(new_segment: schema.RoadSegmentNewSchema,
                        _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    segment_service = main.runner.get(RoadSegmentService)
    return segment_service.create_road_segment(new_segment)


@road_segment_manager.get("/segment",
                          response_model=schema.RoadSegmentSchema)
def get_by_id(segment_id: uuid.UUID, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    segment_projector = main.runner.get(RoadSegmentProjector)

    return schema.RoadSegmentSchema(**segment_projector.get_by_id(segment_id).__dict__)


@road_segment_manager.get("/segments",
                          response_model=list[schema.RoadSegmentSchema])
def get_all(only_active: bool = False, _user: FiefUserInfo = Depends(custom_auth(read_permission))):
    segment_projector: RoadSegmentProjector = main.runner.get(RoadSegmentProjector)
    col = []
    for i in segment_projector.get_all(only_active):
        col.append(schema.RoadSegmentSchema(**i.__dict__))
    return col


@road_segment_manager.delete("/remove_segment", response_class=PlainTextResponse)
def remove_segment(segment_id: schema.RoadSegmentIdSchema,
                   _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    segment_service = main.runner.get(RoadSegmentService)
    segment_service.remove_road_segment(segment_id)
    return "OK"


@road_segment_manager.get("/segments_public",
                          response_model=list[schema.RoadSegmentSchema])
def get_all_public():
    segment_projector: RoadSegmentProjector = main.runner.get(RoadSegmentProjector)
    col = []
    for i in segment_projector.get_all(True):
        col.append(schema.RoadSegmentSchema(**i.__dict__))
    return col
