# example test
import pytest

import base.main
from assetmanager.application import asset_category_service
from assetmanager.application.asset_service import AssetService
from assetmanager.application.model.schema import AssetCategoryNewSchema
from storagemanager.application.model.schema import AssetItemToAdd, StorageItemOverrideSchema
from storagemanager.application.storage_item_service import StorageItemService
from storagemanager.infrastructure import rest_router
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


@pytest.fixture(scope="function", autouse=True)
def teardown():
    db_app_clean()


def test_create_storage_item(mocker):
    cat_id = asset_category_service.create_main_category(AssetCategoryNewSchema(name="test", description=""))

    asset_id = base.main.runner.get(AssetService).add_new_asset(name="test", asset_category_id=cat_id, description="",
                                                                telemetry=[])

    rest_router.get_all_storage_items()
    assert len(rest_router.get_all_storage_items()) == 1
    item = rest_router.get_all_storage_items()[0]
    assert item.asset_id == asset_id
    assert item.allocated == 0
    assert item.in_storage == 0


def test_override_count(mocker):
    cat_id = asset_category_service.create_main_category(AssetCategoryNewSchema(name="test", description=""))

    base.main.runner.get(AssetService).add_new_asset(name="test", asset_category_id=cat_id, description="",
                                                     telemetry=[])

    rest_router.get_all_storage_items()
    assert len(rest_router.get_all_storage_items()) == 1
    item = rest_router.get_all_storage_items()[0]

    service = base.main.runner.get(StorageItemService)

    service.add_to_storage(assets_list=[AssetItemToAdd(storage_item_id=item.id, count_to_add=10)])
    assert rest_router.get_all_storage_items()[0].in_storage == 10

    service.override_storage_item_count(
        override_item=StorageItemOverrideSchema(reason="some reson", id=item.id, new_count=5))
    assert rest_router.get_all_storage_items()[0].in_storage == 5
