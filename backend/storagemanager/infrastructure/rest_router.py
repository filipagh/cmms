from fastapi import APIRouter
from starlette.responses import PlainTextResponse

from base import main
from storagemanager.application import storage_manager_loader
from storagemanager.application.model import schema

storage_manager = APIRouter(
    prefix="/storage-manager",
    tags=["Storage Manager"],
    responses={404: {"description": "Not found"}},
)

@storage_manager.get("/all-storage-data", response_model=list[schema.StorageItemSchema])
def get_all_storage_items():
    storage_items = []
    for i in storage_manager_loader.load_all_storage_items():
        storage_items.append(schema.StorageItemSchema(**i.__dict__))

    return storage_items
