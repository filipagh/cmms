import pytest

import base.main
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from roadsegmentmanager.application.road_segment_service import RoadSegmentService
from stationmanager.application.model.schema import StationNewSchema
from stationmanager.application.station_service import StationService
from taskmanager.application.issue_service import IssueService
from taskmanager.application.model.issue.schema import IssueNewSchema
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()


async def test_create_new_issue_db(mocker):
    road_segment_name = "roadsegmentname"
    station_name = "stationname"

    road_segment_id = base.main.runner.get(RoadSegmentService).create_road_segment(
        segment=RoadSegmentNewSchema(name=road_segment_name, ssud="1234"))

    station_id = base.main.runner.get(StationService).create_station(
        station=StationNewSchema(name=station_name, road_segment_id=road_segment_id, description="desc",
                                 km_of_road_note=""))

    issue_id = IssueService().create_issue(
        IssueNewSchema(username="Username", subject="subject", description="description", station_id=station_id,
                       road_segment_id=road_segment_id))

    issue = IssueService().get_issue(task_id=issue_id)

    assert issue.station_id == station_id
    assert issue.road_segment_id == road_segment_id
    assert issue.subject == "subject"
    assert issue.description == "description"
    assert issue.username == "Username"
    assert issue.active == True
    assert issue.road_segment_name == road_segment_name
    assert issue.station_name == station_name
    assert issue.is_external == True


async def test_create_new_issue(mocker):
    road_segment_name = "roadsegmentname"
    station_name = "stationname"

    road_segment_id = base.main.runner.get(RoadSegmentService).create_road_segment(
        segment=RoadSegmentNewSchema(name=road_segment_name, ssud="1234"))

    station_id = base.main.runner.get(StationService).create_station(
        station=StationNewSchema(name=station_name, road_segment_id=road_segment_id, description="desc",
                                 km_of_road_note=""))

    issue_id = IssueService().create_issue(
        IssueNewSchema(username="Username", subject="subject", description="description", station_id=station_id,
                       road_segment_id=road_segment_id))

    issue = IssueService().get_issue(task_id=issue_id)

    assert issue.station_id == station_id
    assert issue.road_segment_id == road_segment_id
    assert issue.subject == "subject"
    assert issue.description == "description"
    assert issue.username == "Username"
    assert issue.active == True
    assert issue.road_segment_name == road_segment_name
    assert issue.station_name == station_name
    assert issue.is_external == True


async def test_create_get_active(mocker):
    assert len(IssueService().get_active_issues()) == 0

    road_segment_name = "roadsegmentname"
    station_name = "stationname"

    road_segment_id = base.main.runner.get(RoadSegmentService).create_road_segment(
        segment=RoadSegmentNewSchema(name=road_segment_name, ssud="1234"))

    station_id = base.main.runner.get(StationService).create_station(
        station=StationNewSchema(name=station_name, road_segment_id=road_segment_id, description="desc",
                                 km_of_road_note=""))

    issue_id = IssueService().create_issue(
        IssueNewSchema(username="Username", subject="subject", description="description", station_id=station_id,
                       road_segment_id=road_segment_id))
    active_issues = IssueService().get_active_issues()
    assert len(active_issues) == 1
    issue = active_issues[0]

    assert issue.id == issue_id
    assert issue.station_id == station_id
    assert issue.road_segment_id == road_segment_id
    assert issue.subject == "subject"
    assert issue.description == "description"
    assert issue.username == "Username"
    assert issue.active == True
    assert issue.road_segment_name == road_segment_name
    assert issue.station_name == station_name
    assert issue.is_external == True


async def test_resolve(mocker):
    road_segment_name = "roadsegmentname"
    station_name = "stationname"

    road_segment_id = base.main.runner.get(RoadSegmentService).create_road_segment(
        segment=RoadSegmentNewSchema(name=road_segment_name, ssud="1234"))

    station_id = base.main.runner.get(StationService).create_station(
        station=StationNewSchema(name=station_name, road_segment_id=road_segment_id, description="desc",
                                 km_of_road_note=""))

    issue_id = IssueService().create_issue(
        IssueNewSchema(username="Username", subject="subject", description="description", station_id=station_id,
                       road_segment_id=road_segment_id))
    IssueService().resolve_issue(task_id=issue_id)
    assert len(IssueService().get_active_issues()) == 0
