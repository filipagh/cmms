# example test
from datetime import datetime

import pytest

import base.main
import roadsegmentmanager.infrastructure.rest_router as rs_api
import stationmanager.infrastructure.station_rest_router as api
from assetmanager.application import asset_category_service
from assetmanager.application.asset_service import AssetService
from assetmanager.application.model.schema import AssetCategoryNewSchema
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from stationmanager.application.assigned_component.model.schema import AssignedComponentNewSchema, \
    AssignedComponentIdSchema
from stationmanager.application.model.schema import StationNewSchema
from stationmanager.domain.model.assigned_component import AssignedComponentState
from stationmanager.infrastructure import assigned_component_rest_router
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()


async def test_set_component_and_force_remove(mocker):
    cat_id = asset_category_service.create_main_category(AssetCategoryNewSchema(name="test", description=""))

    asset_id_1 = base.main.runner.get(AssetService).add_new_asset(name="asset1", asset_category_id=cat_id,
                                                                  description="",
                                                                  telemetry=[])
    asset_id_2 = base.main.runner.get(AssetService).add_new_asset(name="asset2", asset_category_id=cat_id,
                                                                  description="",
                                                                  telemetry=[])

    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                                  latitude=10.10, longitude=11.11, see_level=100, description="desription")
    station_id = api.create_station(
        new_schema)

    installation_date = datetime.now()
    assigned_component_rest_router.create_installed_component(new_components=[
        AssignedComponentNewSchema(asset_id=asset_id_1, station_id=station_id, serial_number="serial_number1"),
        AssignedComponentNewSchema(asset_id=asset_id_2, station_id=station_id,
                                   serial_number="serial_number2")],
        warranty_period_days=10,
        installation_date=installation_date)

    components = assigned_component_rest_router.get_all(station_id=station_id)
    assert len(components) == 2
    component1 = components[0]
    assert component1.asset_id == asset_id_1
    assert component1.station_id == station_id
    assert component1.serial_number == "serial_number1"
    assert component1.warranty_period_days == 10
    assert component1.installed_at == installation_date
    assert component1.status == AssignedComponentState.INSTALLED

    component2 = components[1]
    assert component2.asset_id == asset_id_2
    assert component2.station_id == station_id
    assert component2.serial_number == "serial_number2"
    assert component2.warranty_period_days == 10
    assert component2.installed_at == installation_date
    assert component2.status == AssignedComponentState.INSTALLED

    uninstall_date = datetime.now()
    assigned_component_rest_router.remove_installed_component(
        components_to_remove=[AssignedComponentIdSchema(id=component1.id)], uninstall_date=uninstall_date)

    components = assigned_component_rest_router.get_all(station_id=station_id)
    assert len(components) == 2
    component1 = components[0]
    assert component1.asset_id == asset_id_1
    assert component1.station_id == station_id
    assert component1.serial_number == "serial_number1"
    assert component1.warranty_period_days == 10
    assert component1.installed_at == installation_date
    assert component1.status == AssignedComponentState.REMOVED
    assert component1.removed_at == uninstall_date

    component2 = components[1]
    assert component2.asset_id == asset_id_2
    assert component2.station_id == station_id
    assert component2.serial_number == "serial_number2"
    assert component2.warranty_period_days == 10
    assert component2.installed_at == installation_date
    assert component2.status == AssignedComponentState.INSTALLED
