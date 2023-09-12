# example test

import pytest
from sqlalchemy.testing import assert_raises

import roadsegmentmanager.infrastructure.rest_router as rs_api
import stationmanager.infrastructure.assigned_component_rest_router as ac_router
import taskmanager.infrastructure.task_rest_router as task_router
from assetmanager.application.model.schema import AssetCategoryNewSchema, AssetNewSchema
from assetmanager.infrastructure.rest_router import create_new_asset, create_new_category
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from stationmanager.application.model.schema import StationNewSchema
from stationmanager.domain.model.assigned_component import AssignedComponentState, ComponentWarrantySource
from stationmanager.infrastructure.station_rest_router import create_station
from storagemanager.application.model.schema import AssetItemToAdd
from storagemanager.application.storage_manager_loader import load_all_storage_items
from storagemanager.infrastructure.rest_router import store_new_assets
from taskmanager.application.model.task_change_component.schema import TaskChangeComponentsNewSchema, \
    TaskComponentAddNewSchema, TaskChangeComponentRequestCompleted, ComponentWarranty
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
                                               add=[TaskComponentAddNewSchema(new_asset_id=asset_id,
                                                                              warranty=ComponentWarranty(
                                                                                  component_warranty_days=100,
                                                                                  component_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
                                                                                  component_prepaid_service_days=0))],
                                               remove=[]))
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

    componnents = ac_router.get_all(station_id=station_id)
    assert len(componnents) == 1
    for c in componnents:
        if c.asset_id == asset_id:
            assert c.serial_number == None
            assert c.status == AssignedComponentState.AWAITING
            break

    task_router.cancel_task(task_id=task_id)

    componnents = ac_router.get_all(station_id=station_id)
    assert len(componnents) == 0

    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 1
    assert store_item.allocated == 0

    try:
        task_router.complete_task_items(task_id=task_id, task_items=[
            TaskChangeComponentRequestCompleted(id=task.add[0].id)])
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

    componnents = ac_router.get_all(station_id=station_id)
    assert len(componnents) == 1
    for c in componnents:
        if c.asset_id == asset_id:
            assert c.serial_number == None
            assert c.status == AssignedComponentState.AWAITING
            break

    serial_number = "serial_number"
    task_router.complete_task_items(task_id=task_id, task_items=[
        TaskChangeComponentRequestCompleted(id=task.add[0].id, serial_number=serial_number)])

    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 0
    assert store_item.allocated == 0

    componnents = ac_router.get_all(station_id=station_id)
    assert len(componnents) == 1
    for c in componnents:
        if c.asset_id == asset_id:
            assert c.status == AssignedComponentState.INSTALLED
            assert c.serial_number == serial_number
            break

    try:
        task_router.complete_task_items(task_id=task_id, task_items=[
            TaskChangeComponentRequestCompleted(id=task.add[0].id)])
    except Exception:
        pass
    try:
        assert_raises(Exception, task_router.cancel_task(task_id=task_id))
    except Exception:
        pass

    store_item = load_all_storage_items()[0]
    assert store_item.in_storage == 0
    assert store_item.allocated == 0

    componnents = ac_router.get_all(station_id=station_id)
    assert len(componnents) == 1
    for c in componnents:
        if c.asset_id == asset_id:
            assert c.status == AssignedComponentState.INSTALLED
            assert c.serial_number == serial_number
            break
