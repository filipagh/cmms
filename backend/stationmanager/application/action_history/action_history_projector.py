import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from assetmanager.application.asset_manager_loader import load_asset_by_id
from base import main
from stationmanager.application.action_history.model import schema
from stationmanager.application.station_projector import StationProjector
from stationmanager.domain.model.assigned_component import AssignedComponent
from stationmanager.infrastructure.persistence import action_history_repo


class ActionHistoryProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(AssignedComponent.CreatedEvent)
    def _(self, domain_event: AssignedComponent.CreatedEvent, process_event):
        text = f'Komponent: {load_asset_by_id(domain_event.asset_id).name} ' \
               f'bol priamo pridany do stanice: ' \
               f'{main.runner.get(StationProjector).get_by_id(domain_event.station_id).name}'
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.station_id,
            text=text,
            datetime=domain_event.timestamp
        )
        action_history_repo.save(model)

    @policy.register(AssignedComponent.AssignedComponentRemoved)
    def _(self, domain_event: AssignedComponent.AssignedComponentRemoved, process_event):
        text = f'Komponent: {load_asset_by_id(domain_event.asset_id).name} ' \
               f'bol priamo odstraneny zo stanice: ' \
               f'{main.runner.get(StationProjector).get_by_id(domain_event.station_id).name}'
        model = action_history_repo.ActionHistoryModel(
            station_id=domain_event.station_id,
            text=text,
            datetime=domain_event.removed_at

        )
        action_history_repo.save(model)

    def get_by_station(self, station_id: uuid.UUID) -> list[schema.ActionHistorySchema]:
        col = []
        for i in action_history_repo.get_by_station(station_id):
            col.append(schema.ActionHistorySchema(**i.__dict__))

        return col
