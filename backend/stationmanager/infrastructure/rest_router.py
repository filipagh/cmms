import uuid

from fastapi import APIRouter

from base import main
from stationmanager.application.model import schema
from stationmanager.application.road_segment_service import RoadSegmentService
from storagemanager.application import storage_manager_loader
from storagemanager.application.storage_item_service import StorageItemService

station_manager = APIRouter(
    prefix="/station-manager",
    tags=["Station Manager"],
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

@station_manager.post("/create_road_segment",
                      response_model=uuid.UUID)
def create_road_segment(new_segment: schema.RoadSegmentNewSchema):
    segment_service = main.runner.get(RoadSegmentService)
    return segment_service.create_road_segment(new_segment)
