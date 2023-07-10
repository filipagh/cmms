import uuid

import base.main
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from stationmanager.application.station_projector import StationProjector
from taskmanager.application.exceptions import AppIssueException
from taskmanager.application.model.issue.schema import IssueSchema, IssueNewSchema
from taskmanager.infrastructure.persistence import issue_repo
from taskmanager.infrastructure.persistence.issue_repo import IssueModel


class IssueService:

    def create_issue(self, new_issue: IssueNewSchema) -> uuid.UUID:
        road_segment = base.main.runner.get(RoadSegmentProjector).get_by_id(new_issue.road_segment_id)
        station = base.main.runner.get(StationProjector).get_by_id(new_issue.station_id)
        if road_segment is None or station is None:
            raise AppIssueException("Road segment or station does not exist")

        return issue_repo.save(

            IssueModel(subject=new_issue.subject, description=new_issue.description, user=new_issue.username,
                       station_id=new_issue.station_id,
                       station_name=station.name, road_segment_id=new_issue.road_segment_id,
                       road_segment_name=road_segment.name, active=True, is_external=True))

    def get_active_issues(self):
        col = []
        for i in issue_repo.get_all_active():
            col.append(IssueSchema(**i.__dict__, username=i.user))
        return col

    def resolve_issue(self, task_id):
        issue_repo.resolve_issue(task_id)

    def get_issue(self, task_id) -> IssueSchema:
        issue = issue_repo.get_by_id(task_id)
        return IssueSchema(**issue.__dict__, username=issue.user)

    def resolve_all_ai_issues(self):
        for issue in issue_repo.get_all_active():
            if issue.station_id != None:
                issue_repo.resolve_issue(issue.id)
