# example test

import roadsegmentmanager.infrastructure.rest_router as rs_api
import stationmanager.infrastructure.station_rest_router as api
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from stationmanager.application.model.schema import StationNewSchema
from test.db_test_util import db_app_setup


def setup():
    db_app_setup()


async def test_mocking_function(mocker):
    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                              latitude=10.10, longitude=11.11, see_level=100, description="desription")
    station_id = api.create_station(
        new_schema)
    station_dict = new_schema.dict()
    station_dict['id'] = station_id
    assert api.get_by_id(station_id).dict() == station_dict