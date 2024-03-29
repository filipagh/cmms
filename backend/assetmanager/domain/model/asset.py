import uuid
from typing import Optional

from eventsourcing.domain import Aggregate, event

from assetmanager.domain.model.asset_telemetry import AssetTelemetry


class Asset(Aggregate):
    class Created(Aggregate.Created):
        asset_category_id: uuid.UUID
        name: str
        description: str
        telemetry: list[AssetTelemetry]

    class Archived(Aggregate.Event):
        pass

    @event(Created)
    def __init__(self, asset_category_id: uuid.UUID, name: str, description: Optional[str],
                 telemetry: list[AssetTelemetry]):
        self.asset_category_id: uuid.UUID = asset_category_id
        self.name: str = name
        self.description: str = description
        self.telemetry = telemetry
        self.is_archived = False

    def archive(self):
        if self.is_archived:
            return
        self._archive()

    @event(Archived)
    def _archive(self):
        self.is_archived = True
