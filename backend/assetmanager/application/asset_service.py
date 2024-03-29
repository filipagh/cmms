import uuid
from typing import Optional

from eventsourcing.application import Application

from assetmanager.domain.model.asset import Asset
from assetmanager.domain.model.asset_telemetry import AssetTelemetry


class AssetService(Application):
    def add_new_asset(self, asset_category_id: uuid.UUID, name: str, description: Optional[str],
                      telemetry: list[AssetTelemetry]):
        asset = Asset(asset_category_id, name, description, telemetry)
        self.save(asset)
        return asset.id

    def archive_asset(self, asset_id: uuid.UUID):
        asset = self.repository.get(asset_id)
        asset.archive()
        self.save(asset)
