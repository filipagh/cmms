from fastapi import APIRouter

from assetmanager.application import asset_category_service, asset_manager_loader
from assetmanager.application.model import schema
from assetmanager.application.model.schema import TelemetryOptions
from assetmanager.domain.model.asset_telemetry import AssetTelemetryType, AssetTelemetryValue
from base import main

asset_manager = APIRouter(
    prefix="/assetManager",
    tags=["AssetManager"],
    responses={404: {"description": "Not found"}},
)


@asset_manager.post("/newCategory", response_model=schema.AssetCategotyIdSchema)
def create_new_category(new_category: schema.AssetCategoryNewSchema):
    category_id = asset_category_service.create_main_category(new_category)
    return schema.AssetCategotyIdSchema(id=category_id)


@asset_manager.post("/newAsset", response_model=schema.AssetIdSchema)
def create_new_asset(new_asset: schema.AssetNewSchema):
    asset_service = main.runner.get(main.Services.AssetService.value)
    asset_id = asset_service.add_new_asset(new_asset.category_id, new_asset.name, new_asset.description,
                                           new_asset.telemetry)
    return schema.AssetIdSchema(id=asset_id)


@asset_manager.get("/assets", response_model=list[schema.AssetSchema])
def get_assets():
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


@asset_manager.get("/asset-categories", response_model=list[schema.AssetCategorySchema])
def get_asset_categories():
    assets = asset_manager_loader.load_asset_category()
    list = []
    for i in assets:
        list.append(schema.AssetCategorySchema(**i.__dict__))

    return list


@asset_manager.get("/telemetry_options", response_model=schema.TelemetryOptions)
def get_telemetry_options():
    return TelemetryOptions(
        types=[e for e in AssetTelemetryType],
        values=[e for e in AssetTelemetryValue]
    )
