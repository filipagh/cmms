import uuid

from assetmanager.application.model.schema import AssetCategoryNewSchema
from assetmanager.infrastructure.persistance import asset_category_repo


def create_main_category(new_category: AssetCategoryNewSchema) -> uuid.UUID:
    return asset_category_repo.save_new(new_category)


def create_sub_category():
    pass
