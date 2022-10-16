import uuid
from typing import Optional

from pydantic import BaseModel


class StorageItemSchemaBASE(BaseModel):
    asset_id: Optional[uuid.UUID]
    in_storage: int
    allocated: int


class StorageItemIdSchema(StorageItemSchemaBASE):
    id: uuid.UUID


class StorageItemSchema(StorageItemIdSchema):
    pass
