import uuid

from fastapi import APIRouter

from base import main
from stationmanager.application.action_history.action_history_projector import ActionHistoryProjector
from stationmanager.application.action_history.model import schema

action_history_router = APIRouter(
    prefix="/action_history",
    tags=["Action History"],
    responses={404: {"description": "Not found"}},
)


@action_history_router.get("/by_station",
                           response_model=list[schema.ActionHistorySchema])
def get_by_station(
        station_id: uuid.UUID
):
    projector = main.runner.get(ActionHistoryProjector)
    return projector.get_by_station(station_id)
