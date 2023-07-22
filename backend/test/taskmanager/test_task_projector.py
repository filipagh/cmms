# example test

import pytest

import roadsegmentmanager.infrastructure.rest_router as rs_api
import taskmanager.infrastructure.task_rest_router as task_router
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from stationmanager.application.model.schema import StationNewSchema, StationRelocateSchema
from stationmanager.infrastructure.station_rest_router import create_station, relocate_station
from taskmanager.application.model.task_service_remote.schema import TaskServiceRemoteNewSchema
from taskmanager.infrastructure import task_rest_router
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()


async def test_load_projection_after_relocation_station():
    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    new_segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment_new", ssud="ssud"))
    station_id = create_station(
        StationNewSchema(name="station", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                         description="desription"))
    task_id = task_router.create_service_remote_task(
        new_task=TaskServiceRemoteNewSchema(station_id=station_id, name="name", description="description"))
    task = task_rest_router.load_by_id(task_id=task_id)
    assert task.road_segment_name == "road_segment"

    relocate_station(StationRelocateSchema(station_id=station_id, new_road_segment_id=new_segment_id))

    task = task_rest_router.load_by_id(task_id=task_id)
    assert task.road_segment_name == "road_segment_new"
