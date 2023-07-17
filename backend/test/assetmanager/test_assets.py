import pytest

from assetmanager.application import asset_category_service
from assetmanager.application.model.schema import AssetCategoryNewSchema, AssetNewSchema
from assetmanager.domain.model.asset_telemetry import AssetTelemetry, AssetTelemetryType, AssetTelemetryValue
from assetmanager.infrastructure import rest_router as asset_manager_router
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()


async def test_create_and_archive_assets(mocker):
    cat_id = asset_category_service.create_main_category(AssetCategoryNewSchema(name="test", description=""))

    asset_id1 = asset_manager_router.create_new_asset(
        new_asset=AssetNewSchema(category_id=cat_id, name="asset1", description="description1", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)])).id
    asset_id2 = asset_manager_router.create_new_asset(
        new_asset=AssetNewSchema(category_id=cat_id, name="asset2", description="description2", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.AIR_PRESSURE, value=AssetTelemetryValue.HECTO_PASCAL)])).id

    assets = asset_manager_router.get_assets()
    assert len(assets) == 2

    asset1 = assets[0]
    assert asset1.id == asset_id1
    assert asset1.category_id == cat_id
    assert asset1.name == "asset1"
    assert asset1.description == "description1"
    assert len(asset1.telemetry) == 1
    assert asset1.telemetry[0].type == AssetTelemetryType.AIR_TEMPERATURE
    assert asset1.telemetry[0].value == AssetTelemetryValue.CELSIUS
    assert asset1.is_archived == False

    asset2 = assets[1]
    assert asset2.id == asset_id2
    assert asset2.category_id == cat_id
    assert asset2.name == "asset2"
    assert asset2.description == "description2"
    assert len(asset2.telemetry) == 1
    assert asset2.telemetry[0].type == AssetTelemetryType.AIR_PRESSURE
    assert asset2.telemetry[0].value == AssetTelemetryValue.HECTO_PASCAL
    assert asset2.is_archived == False

    asset_manager_router.archive_asset(asset_id=asset_id1)
    assets = asset_manager_router.get_assets()
    assert len(assets) == 2

    asset1 = assets[0]
    assert asset1.id == asset_id1
    assert asset1.category_id == cat_id
    assert asset1.name == "asset1"
    assert asset1.description == "description1"
    assert len(asset1.telemetry) == 1
    assert asset1.telemetry[0].type == AssetTelemetryType.AIR_TEMPERATURE
    assert asset1.telemetry[0].value == AssetTelemetryValue.CELSIUS
    assert asset1.is_archived == True

    asset2 = assets[1]
    assert asset2.id == asset_id2
    assert asset2.category_id == cat_id
    assert asset2.name == "asset2"
    assert asset2.description == "description2"
    assert len(asset2.telemetry) == 1
    assert asset2.telemetry[0].type == AssetTelemetryType.AIR_PRESSURE
    assert asset2.telemetry[0].value == AssetTelemetryValue.HECTO_PASCAL
    assert asset2.is_archived == False

    asset_manager_router.archive_asset(asset_id=asset_id1)
    assets = asset_manager_router.get_assets()
    assert len(assets) == 2

    asset1 = assets[0]
    assert asset1.id == asset_id1
    assert asset1.category_id == cat_id
    assert asset1.name == "asset1"
    assert asset1.description == "description1"
    assert len(asset1.telemetry) == 1
    assert asset1.telemetry[0].type == AssetTelemetryType.AIR_TEMPERATURE
    assert asset1.telemetry[0].value == AssetTelemetryValue.CELSIUS
    assert asset1.is_archived == True
