from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

from base import main
from base.auth_def import custom_auth, write_permission, read_permission, admin_permission
from storagemanager.application import storage_manager_loader
from storagemanager.application.model import schema
from storagemanager.application.storage_item_service import StorageItemService

storage_manager = APIRouter(
    prefix="/storage-manager",
    tags=["Storage Manager"],
    responses={404: {"description": "Not found"}},
)


@storage_manager.get("/all-storage-data", response_model=list[schema.StorageItemSchema])
def get_all_storage_items(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    storage_items = []
    for i in storage_manager_loader.load_all_storage_items():
        storage_items.append(schema.StorageItemSchema(**i.__dict__))

    return storage_items


@storage_manager.post("/store-new-assets",
                      response_description="return list of inputs asset which were not process, empty list -> all processed OK",
                      response_model=list[schema.AssetItemToAdd])
def store_new_assets(assets_to_add: list[schema.AssetItemToAdd],
                     _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    storage_service = main.runner.get(StorageItemService)
    return storage_service.add_to_storage(assets_to_add)


@storage_manager.post("/store-item_override",
                      response_class=PlainTextResponse)
def store_item_override(override_item: schema.StorageItemOverrideSchema,
                        _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    storage_service = main.runner.get(StorageItemService)
    storage_service.override_storage_item_count(override_item=override_item)
    return "OK"
