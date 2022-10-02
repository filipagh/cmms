import uuid
from typing import Optional


class AssetCategory:
    id: uuid.UUID
    parent_id: Optional[uuid.UUID]
    name: str
    description: str
