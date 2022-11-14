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

def load_asset_by_id(asset_id:uuid.UUID) -> schema.AssetSchema:
    return schema.AssetSchema(**asset_repo.get_asset_by_id(asset_id).__dict__)


def load_asset_category() -> list[AssetCategoryModel]:
    return asset_category_repo.get_asset_category()
