import uuid
from typing import Optional

from pydantic import BaseModel


class StorageItemSchemaBASE(BaseModel):
    parent_id: Optional[uuid.UUID]
    name: str
    description: str


class StorageItemIdSchema(StorageItemSchemaBASE):
    id: uuid.UUID


class StorageItemSchema(StorageItemSchemaBASE, StorageItemIdSchema):
    pass
