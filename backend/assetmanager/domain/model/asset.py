import uuid
from typing import Optional

from eventsourcing.domain import Aggregate, event

from assetmanager.domain.event.asset import Created


class Asset(Aggregate):
    @event(Created)
    def __init__(self, asset_category_id: uuid.UUID, name: str, description: Optional[str]):
        self.asset_category_id: uuid.UUID = asset_category_id
        self.name: str = name
        self.description: str = description

    # todo archive