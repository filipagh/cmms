import uuid

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from base import main
from stationmanager.application.station_projector import StationProjector
from taskmanager.application.model.task import schema


class RoadSegmentService(ProcessApplication):

    # def add_to_storage(self, assets_list: list[schema.AssetItemToAdd]):
    #     unresolved = []
    #     for i in assets_list:
    #         try:
    #             if i.count_to_add < 1:
    #                 continue
    #             storage_item: StorageItem = self.repository.get(i.storage_item_id)
    #             storage_item.add_to_storage(i.count_to_add)
    #             self.save(storage_item)
    #         except eventsourcing.application.AggregateNotFound:
    #             unresolved.append(i)
    #     return unresolved

    def create_task(self, new_task: schema.TaskNewSchema) -> uuid.UUID:
        station_repo: StationProjector = main.runner.get(main.Services.StationProjector)
        station = station_repo.get_by_id(new_task.station_id)
        # todo
        # segment = RoadSegment(name=segment.name, ssud=segment.ssud)
        # self.save(segment)
        # return segment.id

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    # @policy.register(Asset.Created)
    # def _(self, domain_event: Asset.Created, process_event):
    #     storage_item = StorageItem(domain_event.originator_id)
    #     process_event.collect_events(storage_item)
