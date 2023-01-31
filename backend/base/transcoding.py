import datetime

from eventsourcing.persistence import Transcoding


class DateAsIso(Transcoding):
    type = datetime.date
    name = "date_as_iso"

    def encode(self, obj: datetime.date) -> str:
        return obj.isoformat()

    def decode(self, data: str) -> datetime.date:
        return datetime.date.fromisoformat(data)
