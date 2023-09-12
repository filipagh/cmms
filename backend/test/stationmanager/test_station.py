# example test
from datetime import datetime

import pytest

import assetmanager.infrastructure.rest_router as a_api
import roadsegmentmanager.infrastructure.rest_router as rs_api
import stationmanager.infrastructure.assigned_component_rest_router as as_api
import stationmanager.infrastructure.station_rest_router as api
from assetmanager.application.model.schema import AssetCategoryNewSchema, AssetNewSchema
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from stationmanager.application.assigned_component.model.schema import AssignedComponentNewSchema
from stationmanager.application.model.schema import StationNewSchema, StationIdSchema
from stationmanager.domain.model.assigned_component import ComponentWarrantySource
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()


async def test_mocking_function(mocker):
    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                                  latitude=10.10, longitude=11.11, see_level=100, description="desription")
    station_id = api.create_station(
        new_schema)
    expected_schema_dict = new_schema.dict()
    expected_schema_dict["legacy_ids"] = ''
    station_dict = expected_schema_dict
    station_dict['id'] = station_id
    station_dict['is_active'] = True
    assert api.get_by_id(station_id).dict() == station_dict


def test_create_station(mocker):
    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                                  latitude=10.10, longitude=11.11, see_level=100, description="desription")
    station_id = api.create_station(
        new_schema)
    expected_schema_dict = new_schema.dict()
    expected_schema_dict["legacy_ids"] = ''
    station_dict = expected_schema_dict
    station_dict['id'] = station_id
    station_dict['is_active'] = True
    assert api.get_by_id(station_id).dict() == station_dict
    assert api.get_all(1, 5, road_segment_id=segment_id)[0].dict() == station_dict


def test_delete_station_without_components(mocker):
    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                                  latitude=10.10, longitude=11.11, see_level=100, description="desription")
    station_id = api.create_station(
        new_schema)
    assert api.get_by_id(station_id).is_active == True
    api.remove_station(StationIdSchema(id=station_id))
    assert api.get_by_id(station_id).is_active == False


def test_try_delete_station_with_components(mocker):
    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                                  latitude=10.10, longitude=11.11, see_level=100, description="desription")
    station_id = api.create_station(
        new_schema)
    assert api.get_by_id(station_id).is_active == True
    cat = a_api.create_new_category(new_category=AssetCategoryNewSchema(name="category", description="")).id
    asset = a_api.create_new_asset(new_asset=AssetNewSchema(name="asset", category_id=cat, telemetry=[])).id
    as_api.create_installed_component(new_components=[
        AssignedComponentNewSchema(asset_id=asset, station_id=station_id, serial_number="asset",
                                   service_contracts_id=[])],
        components_warranty_source=ComponentWarrantySource.NAN, component_warranty_until=None, paid_service_until=None,
        installation_date=datetime.now())
    try:
        api.remove_station(StationIdSchema(id=station_id))
    except Exception:
        pass
    assert api.get_by_id(station_id).is_active == True
