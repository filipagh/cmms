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

class AssetCategotyIdSchema(BaseModel):
    id: uuid.UUID


class AssetIdSchema(BaseModel):
    id: uuid.UUID


class AssetBaseSchema(BaseModel):
    category_id: uuid.UUID
    name: str
    description: Optional[str]


class AssetNewSchema(AssetBaseSchema):
    pass


class AssetSchema(AssetBaseSchema):
    id: uuid.UUID
    pass
