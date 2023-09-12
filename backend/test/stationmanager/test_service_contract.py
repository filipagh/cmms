import pytest

from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()

# async def test_create_service_contract(mocker):
#     # todo
#     # treba vytvorit realne komponenty
#     assert len(service_contract_rest_router.get_contracts()) == 0
#     station_id = uuid.uuid4()
#     component1_id = uuid.uuid4()
#     component2_id = uuid.uuid4()
#     contract_id = service_contract_rest_router.create_contract(
#         new_contract=ServiceContractNewSchema(name="test", valid_from=datetime.now(),
#                                               valid_until=datetime.now() + relativedelta(years=1),
#                                               stations_list=[
#                                                   ServiceContractStationComponentsSchema(station_id=station_id,
#                                                                                          component_id_list=[
#                                                                                              component1_id,
#                                                                                              component2_id])]))
#     contracts = service_contract_rest_router.get_contracts()
#     assert len(contracts) == 1
#     assert contracts[0].name == 'test'
#     assert contracts[0].stations_list[0].station_id == station_id
#     assert contracts[0].stations_list[0].component_id_list[0] == component1_id
#     assert contracts[0].stations_list[0].component_id_list[1] == component2_id
#     assert contracts[0].id == contract_id
