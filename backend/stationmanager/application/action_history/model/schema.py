import datetime as datetime
import uuid

from pydantic import BaseModel


class ActionHistorySchemaBASE(BaseModel):
    station_id: uuid.UUID
    text: str
    datetime: datetime.datetime


class ActionHistoryIdSchema(BaseModel):
    id: uuid.UUID


class ActionHistorySchema(ActionHistoryIdSchema, ActionHistorySchemaBASE):
    pass
