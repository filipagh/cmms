import uuid
from typing import Optional

from taskmanager.application.model.issue.schema import IssueSchema
from taskmanager.infrastructure.persistence import issue_repo
from taskmanager.infrastructure.persistence.issue_repo import IssueModel


class IssueService:

    def create_issue(self, subject: str, description: str, station_id: Optional[str], component_id: Optional[str],
                     user: str) -> uuid.UUID:
        return issue_repo.save(
            IssueModel(subject=subject, description=description, station_id=station_id, component_id=component_id,
                       user=user))

    def get_active_issues(self):
        col = []
        for i in issue_repo.get_all_active():
            col.append(IssueSchema(**i.__dict__))
        return col
    def resolve_issue(self, task_id):
        issue_repo.resolve_issue(task_id)

    def get_issue(self, task_id):
        issue = issue_repo.get_by_id(task_id)
        return IssueSchema(**issue.__dict__)
