import uuid

from assetmanager.application.model import schema
from assetmanager.infrastructure.persistance import asset_category_repo
from assetmanager.infrastructure.persistance import asset_repo
from assetmanager.infrastructure.persistance.asset_category_repo import AssetCategoryModel
from assetmanager.infrastructure.persistance.asset_repo import AssetModel


def load_asset_structure():
    pass


def load_assets() -> list[AssetModel]:
    return asset_repo.get_assets()


def load_asset_by_id(asset_id: uuid.UUID) -> schema.AssetSchema:
    asset = asset_repo.get_asset_by_id(asset_id).__dict__
    tele = asset.pop("telemetry")
    telemetry = []
    for t in tele:
        telemetry.append(schema.AssetTelemetry(**t.__dict__))
    return schema.AssetSchema(**asset, telemetry=telemetry)


def load_asset_category() -> list[AssetCategoryModel]:
    return asset_category_repo.get_asset_category()


def search(query: str) -> list[schema.AssetSchema]:
    assets = asset_repo.search(query)
    list = []
    for i in assets:
        dic = i.__dict__
        tele = dic.pop("telemetry")
        tele_list = []
        for t in tele:
            tele_list.append(t.__dict__)
        list.append(schema.AssetSchema(**dic, telemetry=tele_list))

    return list
