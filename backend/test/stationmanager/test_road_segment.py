# example test
import pytest

import roadsegmentmanager.infrastructure.rest_router as rs_api
import stationmanager.infrastructure.station_rest_router as api
from base.api_exception import AppException
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema, RoadSegmentIdSchema
from stationmanager.application.model.schema import StationNewSchema
from test.db_test_util import db_app_setup, db_app_clean


def setup():
    db_app_setup()


def teardown():
    db_app_clean()


def test_create_road_segment(mocker):
    rs_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="test", ssud="1"))
    assert rs_id is not None
    rs = rs_api.get_by_id(segment_id=rs_id)
    assert rs.name == "test"
    assert rs.ssud == "1"


def test_delete_road_segment(mocker):
    rs_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="test", ssud="1"))
    rs_api.remove_segment(segment_id=RoadSegmentIdSchema(id=rs_id))
    rs = rs_api.get_by_id(segment_id=rs_id)
    assert rs.is_active == False
    assert rs.name == "test"
    assert rs.ssud == "1"


def test_try_delete_road_segment_with_station(mocker):
    rs_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="test", ssud="1"))
    api.create_station(
        StationNewSchema(name="test", road_segment_id=rs_id, description="test", km_of_road_note=""))

    pytest.raises(AppException, rs_api.remove_segment, RoadSegmentIdSchema(id=rs_id))

    rs = rs_api.get_by_id(segment_id=rs_id)
    assert rs.is_active == True
    assert rs.name == "test"
    assert rs.ssud == "1"
