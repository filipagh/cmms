import uuid
from typing import Optional

from eventsourcing.application import Application

from assetmanager.domain.model.asset import Asset


class AssetService(Application):
    def add_new_asset(self, asset_category_id: uuid.UUID, name: str, description: Optional[str]):
        asset = Asset(asset_category_id, name, description)
        self.save(asset)
        return asset.id
