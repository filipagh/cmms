import datetime

from stationmanager.application.service_contract.model.schema import ServiceContractSchema
from stationmanager.application.service_contract.service_contract_projector import ServiceContractProjector
from stationmanager.domain.model.assigned_component import AssignedComponent, AssignedComponentWarranty, \
    AssignedComponentState, ComponentWarrantySource


def warranty_until_date_calc(date_from: datetime, warranty_days: int):
    return date_from + datetime.timedelta(days=warranty_days)


def process_warranty_on_component_installation(component: AssignedComponent,
                                               installed_at: datetime) -> AssignedComponentWarranty:
    if component.status != AssignedComponentState.AWAITING:
        raise Exception("Component is not awaiting installation")

    if component.warranty.component_warranty_until is None and component.warranty.component_warranty_days > 0 and component.warranty.component_warranty_source != ComponentWarrantySource.NAN:
        component.warranty.component_warranty_until = warranty_until_date_calc(installed_at,
                                                                               component.warranty.component_warranty_days)

    if component.warranty.component_prepaid_service_until is None and component.warranty.component_prepaid_service_days > 0 and component.warranty.component_warranty_source != ComponentWarrantySource.NAN:
        component.warranty.component_prepaid_service_until = warranty_until_date_calc(installed_at,
                                                                                      component.warranty.component_prepaid_service_days)

    calculate_technical_warranty(component, installed_at)

    return component.warranty


def calculate_technical_warranty(component, installed_at):
    contract = _get_longest_active_service_contract(component.id, installed_at)
    if component.warranty.component_warranty_source == ComponentWarrantySource.INVESTMENT_CONTRACT:
        if contract is None:
            component.warranty.component_technical_warranty_until = component.warranty.component_warranty_until
            component.warranty.component_technical_warranty_id = None
            return component.warranty
        else:
            if component.warranty.component_warranty_until.date() > contract.valid_until:
                component.warranty.component_technical_warranty_until = component.warranty.component_warranty_until
                component.warranty.component_technical_warranty_id = None
                return component.warranty
            else:
                component.warranty.component_technical_warranty_until = datetime.datetime(contract.valid_until.year,
                                                                                          contract.valid_until.month,
                                                                                          contract.valid_until.day)
                component.warranty.component_technical_warranty_id = contract.id
                return component.warranty
    if contract is None:
        component.warranty.component_technical_warranty_until = None
        component.warranty.component_technical_warranty_id = None
    else:
        component.warranty.component_technical_warranty_until = datetime.datetime(contract.valid_until.year,
                                                                                  contract.valid_until.month,
                                                                                  contract.valid_until.day)
        component.warranty.component_technical_warranty_id = contract.id


def _get_longest_active_service_contract(component_id, installed_at,
                                         exclude_service_contract_ids=()) -> ServiceContractSchema:
    from base import main
    contracts = main.runner.get(ServiceContractProjector).get_by_component(component_id)
    if len(contracts) == 0:
        return None
    longest_service_warranty = None
    for contract in contracts:
        if contract.id in exclude_service_contract_ids:
            continue
        if contract.valid_from <= installed_at.date() <= contract.valid_until:
            if longest_service_warranty == None:
                longest_service_warranty = contract
            elif contract.service_warranty_until > longest_service_warranty.valid_until:
                longest_service_warranty = contract
    return longest_service_warranty


def adjust_technical_warranty_if_based_from_investment_contract(warranty: AssignedComponentWarranty):
    if warranty.component_warranty_source == ComponentWarrantySource.INVESTMENT_CONTRACT and warranty.component_technical_warranty_id is None:
        warranty.component_technical_warranty_until = warranty.component_warranty_until
    return warranty


def calculate_component_technical_warranty(component: AssignedComponent):
    contract = _get_longest_active_service_contract(component.id, datetime.datetime.now(),
                                                    exclude_service_contract_ids=[component.service_contracts_id])

    if contract is not None:
        component.warranty.component_technical_warranty_until = datetime.datetime(contract.valid_until.year,
                                                                                  contract.valid_until.month,
                                                                                  contract.valid_until.day)
        component.warranty.component_technical_warranty_id = contract.id
    else:
        if component.warranty.component_warranty_source == ComponentWarrantySource.INVESTMENT_CONTRACT and component.warranty.component_technical_warranty_until > datetime.datetime.now():
            component.warranty.component_technical_warranty_until = component.warranty.component_warranty_until
            component.warranty.component_technical_warranty_id = None
        else:
            component.warranty.component_technical_warranty_until = None
            component.warranty.component_technical_warranty_id = None

    return component.warranty


def calculate_component_warranty_for_replacement(component: AssignedComponent):
    if component.warranty.component_warranty_source == ComponentWarrantySource.INVESTMENT_CONTRACT:
        if component.warranty.component_warranty_until.date() > datetime.datetime.now().date():
            new_warranty = AssignedComponentWarranty(
                component_warranty_days=0,
                component_warranty_until=component.warranty.component_warranty_until,
                component_warranty_source=component.warranty.component_warranty_source,
                component_warranty_id=component.warranty.component_warranty_id,
                component_prepaid_service_days=0,
                component_prepaid_service_until=component.warranty.component_prepaid_service_until,
                component_technical_warranty_id=component.warranty.component_technical_warranty_id,
                component_technical_warranty_until=component.warranty.component_technical_warranty_until
            )
        else:
            new_warranty = AssignedComponentWarranty(
                component_warranty_until=None,
                component_prepaid_service_until=None,
                component_prepaid_service_days=0,
                component_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
                component_warranty_days=365 * 2,
                component_technical_warranty_id=component.warranty.component_technical_warranty_id,
                component_technical_warranty_until=component.warranty.component_technical_warranty_until
            )


    elif component.warranty.component_warranty_source == ComponentWarrantySource.COMPANY_WARRANTY:
        if component.warranty.component_warranty_until.date() > datetime.datetime.now().date():
            new_warranty = AssignedComponentWarranty(
                component_warranty_days=0,
                component_warranty_until=component.warranty.component_warranty_until,
                component_warranty_source=component.warranty.component_warranty_source,
                component_warranty_id=component.warranty.component_warranty_id,
                component_prepaid_service_days=0,
                component_prepaid_service_until=component.warranty.component_prepaid_service_until,
                component_technical_warranty_id=component.warranty.component_technical_warranty_id,
                component_technical_warranty_until=component.warranty.component_technical_warranty_until
            )
        else:
            new_warranty = AssignedComponentWarranty(
                component_warranty_until=None,
                component_prepaid_service_until=None,
                component_prepaid_service_days=0,
                component_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
                component_warranty_days=365 * 2,
                component_technical_warranty_id=component.warranty.component_technical_warranty_id,
                component_technical_warranty_until=component.warranty.component_technical_warranty_until
            )
    else:  # ComponentWarrantySource.NAN
        new_warranty = AssignedComponentWarranty(
            component_warranty_until=None,
            component_prepaid_service_until=None,
            component_prepaid_service_days=0,
            component_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
            component_warranty_days=365 * 2,
            component_technical_warranty_id=component.warranty.component_technical_warranty_id,
            component_technical_warranty_until=component.warranty.component_technical_warranty_until
        )

    return new_warranty
