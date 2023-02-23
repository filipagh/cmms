# example test

from assetmanager.infrastructure.rest_router import get_telemetry_options
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from roadsegmentmanager.infrastructure.rest_router import create_road_segment, get_all
from test.db_test_util import db_app_setup, db_app_clean


def setup():
    db_app_setup()

def teardown():
    db_app_clean()


async def test_mocking_function(mocker):
    get_telemetry_options()

    id_segment = create_road_segment(RoadSegmentNewSchema(name="name", ssud="ssud"))
    assert get_all()[0].id == id_segment


