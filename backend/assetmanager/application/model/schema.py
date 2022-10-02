import uuid
from typing import Optional

from pydantic import BaseModel


class AssetCategorySchemaBASE(BaseModel):
    parent_id: Optional[uuid.UUID]
    name: str
    description: str


class AssetCategorySchema(AssetCategorySchemaBASE):
    id: uuid.UUID


class AssetCategoryNewSchema(AssetCategorySchemaBASE):
    pass
