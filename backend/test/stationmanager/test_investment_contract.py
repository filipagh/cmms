from datetime import datetime

import pytest
from dateutil.relativedelta import relativedelta

import stationmanager.infrastructure.investment_contract_rest_router as investment_contract_router
from stationmanager.application.invesment_contract.model.schema import InvestmentContractNewSchema
from test.db_test_util import db_app_setup, db_app_clean


@pytest.fixture(scope="function", autouse=True)
def setup():
    db_app_setup()


def teardown():
    db_app_clean()


async def test_create_investment_contract(mocker):
    assert len(investment_contract_router.get_contracts(False)) == 0

    base_warranty = 365 * 4
    contract_id = investment_contract_router.create_contract(
        new_contract=InvestmentContractNewSchema(identifier="test", valid_from=datetime.now(),
                                                 valid_until=datetime.now() + relativedelta(years=1),
                                                 warranty_period_days=base_warranty))
    contracts = investment_contract_router.get_contracts(False)
    assert len(contracts) == 1
    assert contracts[0].identifier == 'test'
    assert contracts[0].id == contract_id
    assert contracts[0].warranty_period_days == base_warranty


async def test_get_active_contracts(mocker):
    base_warranty = 365 * 4
    investment_contract_router.create_contract(
        new_contract=InvestmentContractNewSchema(identifier="past", valid_from=datetime.now() + relativedelta(years=-2),
                                                 valid_until=datetime.now() + relativedelta(years=-1),
                                                 warranty_period_days=base_warranty))
    active_contract_id = investment_contract_router.create_contract(
        new_contract=InvestmentContractNewSchema(identifier="now", valid_from=datetime.now(),
                                                 valid_until=datetime.now() + relativedelta(years=1),
                                                 warranty_period_days=base_warranty))
    investment_contract_router.create_contract(
        new_contract=InvestmentContractNewSchema(identifier="future",
                                                 valid_from=datetime.now() + relativedelta(years=1),
                                                 valid_until=datetime.now() + relativedelta(years=2),
                                                 warranty_period_days=base_warranty))
    assert len(investment_contract_router.get_contracts(False)) == 3
    contracts = investment_contract_router.get_contracts(True)
    assert len(contracts) == 1
    assert contracts[0].identifier == 'now'
    assert contracts[0].id == active_contract_id
    assert contracts[0].warranty_period_days == base_warranty
