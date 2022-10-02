
import uuid
from datetime import datetime

from eventsourcing.domain import Aggregate


class Created(Aggregate.Created):
    asset_category_id: uuid.UUID
    name: str
    description: str


class Archived(Aggregate.Event):
    time: datetime
