# example test

import pytest

from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()

# async def test_set_component_with_warranty(mocker):
#     cat_id = asset_category_service.create_main_category(AssetCategoryNewSchema(name="test", description=""))
#
#     asset_id_1 = base.main.runner.get(AssetService).add_new_asset(name="asset1", asset_category_id=cat_id,
#                                                                   description="",
#                                                                   telemetry=[])
#     asset_id_2 = base.main.runner.get(AssetService).add_new_asset(name="asset2", asset_category_id=cat_id,
#                                                                   description="",
#                                                                   telemetry=[])
#
#     segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
#     new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
#                                   latitude=10.10, longitude=11.11, see_level=100, description="desription")
#     station_id = api.create_station(
#         new_schema)
#
#     installation_date = datetime.now()
#     component_warranty_until = datetime.now() + timedelta(days=10)
#     paid_service_until = datetime.now() + timedelta(days=100)
#     assigned_component_rest_router.create_installed_component(new_components=[
#         AssignedComponentNewSchema(asset_id=asset_id_1, station_id=station_id, serial_number="serial_number1"),
#         AssignedComponentNewSchema(asset_id=asset_id_2, station_id=station_id,
#                                    serial_number="serial_number2")],
#         component_warranty_until=component_warranty_until,
#         components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
#         paid_service_until=paid_service_until,
#
#         installation_date=installation_date)
#
#     components = assigned_component_rest_router.get_all(station_id=station_id)
#     assert len(components) == 2
#     component1 = components[0]
#     assert component1.asset_id == asset_id_1
#     assert component1.station_id == station_id
#     assert component1.serial_number == "serial_number1"
#     assert component1.installed_at == installation_date
#     assert component1.status == AssignedComponentState.INSTALLED
#     assert component1.component_warranty_until == component_warranty_until
#     assert component1.components_warranty_source == ComponentWarrantySource.COMPANY_WARRANTY
#     assert component1.prepaid_service_until == paid_service_until
#
#     component2 = components[1]
#     assert component2.asset_id == asset_id_2
#     assert component2.station_id == station_id
#     assert component2.serial_number == "serial_number2"
#     assert component2.installed_at == installation_date
#     assert component2.status == AssignedComponentState.INSTALLED
#     assert component2.component_warranty_until == component_warranty_until
#     assert component2.components_warranty_source == ComponentWarrantySource.COMPANY_WARRANTY
#     assert component2.prepaid_service_until == paid_service_until


# async def test_set_component_and_force_remove(mocker):
#     cat_id = asset_category_service.create_main_category(AssetCategoryNewSchema(name="test", description=""))
#
#     asset_id_1 = base.main.runner.get(AssetService).add_new_asset(name="asset1", asset_category_id=cat_id,
#                                                                   description="",
#                                                                   telemetry=[])
#     asset_id_2 = base.main.runner.get(AssetService).add_new_asset(name="asset2", asset_category_id=cat_id,
#                                                                   description="",
#                                                                   telemetry=[])
#
#     segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
#     new_schema = StationNewSchema(name="name", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
#                                   latitude=10.10, longitude=11.11, see_level=100, description="desription")
#     station_id = api.create_station(
#         new_schema)
#
#     installation_date = datetime.now()
#     assigned_component_rest_router.create_installed_component(new_components=[
#         AssignedComponentNewSchema(asset_id=asset_id_1, station_id=station_id, serial_number="serial_number1"),
#         AssignedComponentNewSchema(asset_id=asset_id_2, station_id=station_id,
#                                    serial_number="serial_number2")],
#         component_warranty_until=None,
#         components_warranty_source=ComponentWarrantySource.NAN,
#         paid_service_until=None,
#
#         installation_date=installation_date)
#
#     components = assigned_component_rest_router.get_all(station_id=station_id)
#     assert len(components) == 2
#     component1 = components[0]
#     assert component1.asset_id == asset_id_1
#     assert component1.station_id == station_id
#     assert component1.serial_number == "serial_number1"
#     assert component1.installed_at == installation_date
#     assert component1.status == AssignedComponentState.INSTALLED
#     assert component1.component_warranty_until is None
#     assert component1.component_warranty_source == ComponentWarrantySource.NAN
#     assert component1.prepaid_service_until is None
#
#     component2 = components[1]
#     assert component2.asset_id == asset_id_2
#     assert component2.station_id == station_id
#     assert component2.serial_number == "serial_number2"
#     assert component2.installed_at == installation_date
#     assert component2.status == AssignedComponentState.INSTALLED
#     assert component2.component_warranty_until is None
#     assert component2.component_warranty_source == ComponentWarrantySource.NAN
#     assert component2.prepaid_service_until is None
#
#     uninstall_date = datetime.now()
#     assigned_component_rest_router.remove_installed_component(
#         components_to_remove=[AssignedComponentIdSchema(id=component1.id)], uninstall_date=uninstall_date)
#
#     components = assigned_component_rest_router.get_all(station_id=station_id)
#     assert len(components) == 2
#     component1 = components[0]
#     assert component1.asset_id == asset_id_1
#     assert component1.station_id == station_id
#     assert component1.serial_number == "serial_number1"
#     assert component1.installed_at == installation_date
#     assert component1.status == AssignedComponentState.REMOVED
#     assert component1.removed_at == uninstall_date
#     assert component1.component_warranty_until is None
#     assert component1.component_warranty_source == ComponentWarrantySource.NAN
#     assert component1.prepaid_service_until is None
#
#     component2 = components[1]
#     assert component2.asset_id == asset_id_2
#     assert component2.station_id == station_id
#     assert component2.serial_number == "serial_number2"
#     assert component2.installed_at == installation_date
#     assert component2.status == AssignedComponentState.INSTALLED
#     assert component2.component_warranty_until is None
#     assert component2.component_warranty_source == ComponentWarrantySource.NAN
#     assert component2.prepaid_service_until is None
