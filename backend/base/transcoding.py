import datetime
import json

from eventsourcing.persistence import Transcoding

from assetmanager.domain.model.asset_telemetry import AssetTelemetry


class DateAsIso(Transcoding):
    type = datetime.date
    name = "date_as_iso"

    def encode(self, obj: datetime.date) -> str:
        return obj.isoformat()

    def decode(self, data: str) -> datetime.date:
        return datetime.date.fromisoformat(data)


class AssetTelemetryAsJSON(Transcoding):
    type = AssetTelemetry
    name = "AssetTelemetryAsJSON"

    def encode(self, obj: AssetTelemetry) -> str:
        return obj.json()

    def decode(self, data: str) -> AssetTelemetry:
        return AssetTelemetry.parse_obj(json.loads(data))
