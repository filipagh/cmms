import uuid

from fastapi import APIRouter

from base import main
from roadsegmentmanager.application.model import schema
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from roadsegmentmanager.application.road_segment_service import RoadSegmentService
from storagemanager.application import storage_manager_loader
from storagemanager.application.storage_item_service import StorageItemService

road_segment_manager = APIRouter(
    prefix="/road-segment-manager",
    tags=["Road Segment Manager"],
    responses={404: {"description": "Not found"}},
)


#
# @storage_manager.get("/all-storage-data", response_model=list[schema.StorageItemSchema])
# def get_all_storage_items():
#     storage_items = []
#     for i in storage_manager_loader.load_all_storage_items():
#         storage_items.append(schema.StorageItemSchema(**i.__dict__))
#
#     return storage_items
#

@road_segment_manager.post("/create_road_segment",
                           response_model=uuid.UUID)
def create_road_segment(new_segment: schema.RoadSegmentNewSchema):
    segment_service = main.runner.get(RoadSegmentService)
    return segment_service.create_road_segment(new_segment)


@road_segment_manager.get("/segment",
                          response_model=schema.RoadSegmentSchema)
def get_by_id(segment_id: uuid.UUID):
    segment_projector = main.runner.get(RoadSegmentProjector)

    return schema.RoadSegmentSchema(**segment_projector.get_by_id(segment_id).__dict__)


@road_segment_manager.get("/segments",
                          response_model=list[schema.RoadSegmentSchema])
def get_all():
    segment_projector = main.runner.get(RoadSegmentProjector)
    col = []
    for i in segment_projector.get_all():
        col.append(schema.RoadSegmentSchema(**i.__dict__))
    return col
