import uuid
from typing import Optional

from eventsourcing.domain import Aggregate, event



class Asset(Aggregate):
    class Created(Aggregate.Created):
        asset_category_id: uuid.UUID
        name: str
        description: str


    @event(Created)
    def __init__(self, asset_category_id: uuid.UUID, name: str, description: Optional[str]):
        self.asset_category_id: uuid.UUID = asset_category_id
        self.name: str = name
        self.description: str = description
    name: str
    description: str
    # todo archive