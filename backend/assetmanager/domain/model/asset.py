import uuid


class Asset:
    id: uuid.UUID
    asset_category_id: uuid.UUID
    name: str
    description: str
