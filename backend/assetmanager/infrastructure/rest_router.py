from fastapi import APIRouter, Depends
from fief_client import FiefUserInfo
from starlette.responses import PlainTextResponse

from assetmanager.application import asset_category_service, asset_manager_loader
from assetmanager.application.asset_service import AssetService
from assetmanager.application.model import schema
from assetmanager.application.model.schema import TelemetryOptions
from assetmanager.domain.model.asset_telemetry import AssetTelemetryType, AssetTelemetryValue
from base import main
from base.auth_def import write_permission, custom_auth, read_permission, admin_permission

asset_manager_router = APIRouter(
    prefix="/assetManager",
    tags=["AssetManager"],
    responses={404: {"description": "Not found"}},
)


@asset_manager_router.post("/newCategory", response_model=schema.AssetCategotyIdSchema)
def create_new_category(new_category: schema.AssetCategoryNewSchema,
                        _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    category_id = asset_category_service.create_main_category(new_category)
    return schema.AssetCategotyIdSchema(id=category_id)


@asset_manager_router.post("/newAsset", response_model=schema.AssetIdSchema)
def create_new_asset(new_asset: schema.AssetNewSchema, _user: FiefUserInfo = Depends(custom_auth(write_permission))):
    asset_service = main.runner.get(main.Services.AssetService.value)
    asset_id = asset_service.add_new_asset(new_asset.category_id, new_asset.name, new_asset.description,
                                           new_asset.telemetry)
    return schema.AssetIdSchema(id=asset_id)


@asset_manager_router.get("/assets", response_model=list[schema.AssetSchema])
def get_assets(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    assets = asset_manager_loader.load_assets()
    list = []
    for i in assets:
        dic = i.__dict__
        tele = dic.pop("telemetry")
        tele_list = []
        for t in tele:
            tele_list.append(t.__dict__)
        list.append(schema.AssetSchema(**dic, telemetry=tele_list))

    return list


@asset_manager_router.get("/asset-categories", response_model=list[schema.AssetCategorySchema])
def get_asset_categories(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    assets = asset_manager_loader.load_asset_category()
    list = []
    for i in assets:
        list.append(schema.AssetCategorySchema(**i.__dict__))

    return list


@asset_manager_router.get("/telemetry_options", response_model=schema.TelemetryOptions)
def get_telemetry_options(_user: FiefUserInfo = Depends(custom_auth(read_permission))):
    return TelemetryOptions(
        types=[e for e in AssetTelemetryType],
        values=[e for e in AssetTelemetryValue]
    )


@asset_manager_router.delete("/asset/{asset_id}", response_class=PlainTextResponse)
def archive_asset(asset_id: str, _user: FiefUserInfo = Depends(custom_auth(admin_permission))):
    asset_service = main.runner.get(AssetService)
    asset_service.archive_asset(asset_id)
    return "OK"
