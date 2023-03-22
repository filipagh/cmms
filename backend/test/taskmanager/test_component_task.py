# example test
import uuid

import pytest
from sqlalchemy.testing import assert_raises

import roadsegmentmanager.infrastructure.rest_router as rs_api
import stationmanager.infrastructure.station_rest_router as api
from assetmanager.application.model.schema import AssetCategoryNewSchema, AssetNewSchema
from assetmanager.infrastructure.rest_router import create_new_asset, create_new_category
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from stationmanager.application.model.schema import StationNewSchema
import taskmanager.infrastructure.task_rest_router as task_router
from stationmanager.infrastructure.station_rest_router import create_station
from storagemanager.application.model.schema import AssetItemToAdd
from storagemanager.application.storage_manager_loader import load_all_storage_items
from storagemanager.infrastructure.rest_router import store_new_assets
from taskmanager.application.model.task_change_component.schema import TaskChangeComponentsNewSchema, \
    TaskComponentAddNewSchema, TaskChangeComponentRequestId
from taskmanager.domain.model.task_component_state import TaskComponentState
from taskmanager.domain.model.task_state import TaskState
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()


async def create_add_new_component_task():
    cat_id = create_new_category(AssetCategoryNewSchema(name="category", description="description")).id
    asset_id = create_new_asset(
        AssetNewSchema(name="asset", category_id=cat_id, description="description", telemetry=[])).id

    segment_id = rs_api.create_road_segment(RoadSegmentNewSchema(name="road_segment", ssud="ssud"))
    station_id = create_station(
        StationNewSchema(name="station", road_segment_id=segment_id, km_of_road=10.5, km_of_road_note="note",
                         description="desription"))
    task_id = task_router.create_component_task(
        new_task=TaskChangeComponentsNewSchema(station_id=station_id, name="name", description="description",
                                               warranty_period_days=100,
                                               add=[TaskComponentAddNewSchema(new_asset_id=asset_id)], remove=[]))
    task = task_router.load(task_id)
    assert task.state == TaskState.OPEN
    assert len(task.add) == 1
    assert task.add[0].new_asset_id == asset_id
    assert task.add[0].state == TaskComponentState.AWAITING

    store_new_assets(assets_to_add=[AssetItemToAdd(storage_item_id=load_all_storage_items()[0].id, count_to_add=1)])
    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 1
    assert store_item.allocated == 0

    return (cat_id, asset_id, segment_id, station_id, task_id, task)


async def test_cancel_task(mocker):
    cat_id, asset_id, segment_id, station_id, task_id, task = await create_add_new_component_task()

    task_router.allocate_components(task_id=task_id)
    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 0
    assert store_item.allocated == 1

    task_router.cancel_task(task_id=task_id)

    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 1
    assert store_item.allocated == 0

    try:
        task_router.complete_task_items(task_id=task_id, task_items=[
            TaskChangeComponentRequestId(id=task.add[0].id)])
    except Exception:
        pass
    try:
        assert_raises(Exception, task_router.cancel_task(task_id=task_id))
    except Exception:
        pass

    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 1
    assert store_item.allocated == 0


async def test_complete_task(mocker):
    cat_id, asset_id, segment_id, station_id, task_id, task = await create_add_new_component_task()

    task_router.allocate_components(task_id=task_id)
    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 0
    assert store_item.allocated == 1

    task_router.complete_task_items(task_id=task_id, task_items=[
        TaskChangeComponentRequestId(id=task.add[0].id)])

    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 0
    assert store_item.allocated == 0

    try:
        task_router.complete_task_items(task_id=task_id, task_items=[
            TaskChangeComponentRequestId(id=task.add[0].id)])
    except Exception:
        pass
    try:
        assert_raises(Exception, task_router.cancel_task(task_id=task_id))
    except Exception:
        pass

    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 0
    assert store_item.allocated == 0

    # expected_schema_dict = new_schema.dict()
    # expected_schema_dict["legacy_ids"] = ''
    # station_dict = expected_schema_dict
    # station_dict['id'] = station_id
    # assert api.get_by_id(station_id).dict() == station_dict
