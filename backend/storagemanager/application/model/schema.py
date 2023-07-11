import uuid

from pydantic import BaseModel


class StorageItemSchemaBASE(BaseModel):
    asset_id: uuid.UUID
    in_storage: int
    allocated: int


class StorageItemIdSchema(StorageItemSchemaBASE):
    id: uuid.UUID


class StorageItemSchema(StorageItemIdSchema):
    pass


class AssetItemToAdd(BaseModel):
    storage_item_id: uuid.UUID
    count_to_add: int


class StorageItemOverrideSchema(BaseModel):
    reason: str
    id: uuid.UUID
    new_count: int
