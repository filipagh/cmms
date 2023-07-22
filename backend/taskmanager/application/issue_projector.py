import logging

from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

import base.main
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from stationmanager.domain.model.station import Station
from taskmanager.infrastructure.persistence import issue_repo


class IssueProjector(ProcessApplication):

    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(Station.StationRelocated)
    def _(self, domain_event: Station.StationRelocated, process_event):
        try:
            road_segment = base.main.runner.get(RoadSegmentProjector).get_by_id(domain_event.new_road_segment_id)
            if road_segment is None:
                logging.error(
                    f'Road segment does not exist {str(domain_event.new_road_segment_id)}'
                    f', station relocation failed for issue')
                return

            for issue in issue_repo.get_by_station(domain_event.originator_id):
                issue.road_segment_id = domain_event.new_road_segment_id
                issue.road_segment_name = road_segment.name
                issue_repo.save(issue)
        except Exception as e:
            logging.error("IssueService().relocate_station failed with error: {}".format(e))
