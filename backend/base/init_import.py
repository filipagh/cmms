from datetime import datetime
from time import sleep

from assetmanager.application.model.schema import AssetCategoryNewSchema, AssetNewSchema, AssetIdSchema
from assetmanager.domain.model.asset_telemetry import AssetTelemetry, AssetTelemetryType, AssetTelemetryValue
from assetmanager.infrastructure import rest_router
from base import main
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from roadsegmentmanager.infrastructure import rest_router as rs_router
from stationmanager.application.assigned_component.model.schema import AssignedComponentNewSchema
from stationmanager.application.invesment_contract.investment_contract_service import InvestmentContractService
from stationmanager.application.model.schema import StationNewSchema
from stationmanager.application.station_service import StationService
from stationmanager.domain.model.assigned_component import ComponentWarrantySource
from stationmanager.infrastructure import assigned_component_rest_router

default_category = "zakladne komponenty"
import_rs_1 = "Považská Bystrica"
import_rs_2 = "D4 (auto importovane)"


class _InstallAsset:
    def __init__(self, asset_id: AssetIdSchema, serial_number: str = "neznáme"):
        self.asset_id = asset_id
        self.serial_number = serial_number


def _get_selected_assets_to_install(asset_ids: list[_InstallAsset], station_id):
    col = []

    for a in asset_ids:
        col.append(
            AssignedComponentNewSchema(asset_id=a.asset_id.id, station_id=station_id, serial_number=a.serial_number,
                                       service_contracts_id=[]))
    return col


def import_assets():
    print("zacinam import assetov")
    for i in rest_router.get_asset_categories():
        if i.name == default_category:
            print("import skip")
            return
    sleep(10)
    cat_id = rest_router.create_new_category(
        AssetCategoryNewSchema(name=default_category, description="zakladne komponenty auto-import")).id
    HMP155 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="HMP155 Teplomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    WXT536 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WXT536 Multisenzor", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.AIR_PRESSURE, value=AssetTelemetryValue.HECTO_PASCAL),
        AssetTelemetry(type=AssetTelemetryType.AIR_HUMIDITY, value=AssetTelemetryValue.PERCENTAGE)]))

    WXT520 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WXT520 Multisenzor", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.AIR_PRESSURE, value=AssetTelemetryValue.HECTO_PASCAL),
        AssetTelemetry(type=AssetTelemetryType.AIR_HUMIDITY, value=AssetTelemetryValue.PERCENTAGE)]))

    DTS12G = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DTS12G Zemny teplomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    WMT700 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WMT700 Vetromer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
    ]))
    PWD12 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="PWD12 Senzor počasia", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.VISIBILITY, value=AssetTelemetryValue.METERS),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),

    ]))
    DST111 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DST 111 Senzor teploty vozovky", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))
    DST111__smer_BA_ = DST111
    DST111__smer_ZA_ = DST111
    DSC211 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DSC 211 Senzor stavu vozovky", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
            AssetTelemetry(type=AssetTelemetryType.GRIP, value=AssetTelemetryValue.PERCENTAGE),
            AssetTelemetry(type=AssetTelemetryType.ICE_HEIGHT, value=AssetTelemetryValue.MILIMETERS),
            AssetTelemetry(type=AssetTelemetryType.WATER_HEIGHT, value=AssetTelemetryValue.MILIMETERS),
            AssetTelemetry(type=AssetTelemetryType.SNOW_HEIGHT, value=AssetTelemetryValue.MILIMETERS),
            AssetTelemetry(type=AssetTelemetryType.ROAD_WARNING_STATUS, value=AssetTelemetryValue.STRING),
            AssetTelemetry(type=AssetTelemetryType.ROAD_RAIN_STATUS, value=AssetTelemetryValue.STRING),
            AssetTelemetry(type=AssetTelemetryType.ROAD_SURFACE_STATUS, value=AssetTelemetryValue.STRING)
        ]))
    DSC211_smer_BA_ = DSC211
    DSCVIS = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DSCVIS", telemetry=[]))
    DSC111 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DSC 111 Senzor stavu vozovky", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
            AssetTelemetry(type=AssetTelemetryType.GRIP, value=AssetTelemetryValue.PERCENTAGE),
            AssetTelemetry(type=AssetTelemetryType.ICE_HEIGHT, value=AssetTelemetryValue.MILIMETERS),
            AssetTelemetry(type=AssetTelemetryType.WATER_HEIGHT, value=AssetTelemetryValue.MILIMETERS),
            AssetTelemetry(type=AssetTelemetryType.SNOW_HEIGHT, value=AssetTelemetryValue.MILIMETERS),
            AssetTelemetry(type=AssetTelemetryType.ROAD_WARNING_STATUS, value=AssetTelemetryValue.STRING),
            AssetTelemetry(type=AssetTelemetryType.ROAD_RAIN_STATUS, value=AssetTelemetryValue.STRING),
            AssetTelemetry(type=AssetTelemetryType.ROAD_SURFACE_STATUS, value=AssetTelemetryValue.STRING)
        ]))

    DRD11 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DRD11 Zrážkomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND)]))
    DR11SYS = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DR11SYS", telemetry=[]))

    AKU12V__2_2Ah = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="AKU12V, 2,2Ah", telemetry=[]))
    AKU12v__2_2Ah = AKU12V__2_2Ah
    AKU_12V_2_2Ah = AKU12V__2_2Ah
    AKU12V__26Ah = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="AKU12V, 26Ah", telemetry=[]))
    AKU12V__75Ah = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="AKU12V, 75Ah", telemetry=[]))
    AKU6V__200Ah = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="AKU6V, 200Ah", telemetry=[]))
    AKU2_2 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="AKU2.2", telemetry=[]))
    DMU703 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DMU703 Centralna jednotka", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.DEW_POINT_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))
    PMU701 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="PMU701 Power management jednotka", telemetry=[]))
    PMU703 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="PMU703", telemetry=[]))
    RWS200 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="RWS200 Modul stanice", telemetry=[]))
    DXS422 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DXS422 Modul stanice", telemetry=[]))
    DRI701 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRI701", telemetry=[]))
    DRI_521 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRI_521", telemetry=[]))
    DTR13 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DTR13", telemetry=[]))

    DRS511BB5 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511BB5", telemetry=[]))
    DRS511BB2 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511BB2", telemetry=[]))
    DRS511BB10 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511BB10", telemetry=[]))
    DRS511BB5 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511BB5", telemetry=[]))
    DRS511BB = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511BB", telemetry=[]))
    DRS511AB10 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511AB10", telemetry=[]))
    DRS511AB2 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511AB2", telemetry=[]))
    DRS511AB5 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511AB5", telemetry=[]))
    DTS12G3 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DTS12G3", telemetry=[]))
    DTS12G = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DTS12G", telemetry=[]))
    PTB110 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="PTB110", telemetry=[]))
    PTB100 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="PTB100", telemetry=[]))
    DTR503A = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DTR503A", telemetry=[]))
    HMP155E = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="HMP155E", telemetry=[]))
    HMP155 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="HMP155", telemetry=[]))
    HMP45D = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="HMP45D", telemetry=[]))
    WA15 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="WA15", telemetry=[]))

    AKU26 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="AKU26", telemetry=[]))
    AKU133 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="AKU133", telemetry=[]))
    CMP6 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="CMP6", telemetry=[]))
    DRA411 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRA411", telemetry=[]))
    DRA41 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRA41", telemetry=[]))
    NPort_5110 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5110", telemetry=[]))
    Nport_5130 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5130", telemetry=[]))
    Nport_5230 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5230", telemetry=[]))
    Nport_5232I_T = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5232I-T", telemetry=[]))
    Moxa_Nport_5150A = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5150A", telemetry=[]))
    Moxa_Nport_5150 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5150", telemetry=[]))
    Moxa_Nport_6150 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 6150", telemetry=[]))
    Moxa_Nport_5232I = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5232I", telemetry=[]))
    Nport_5430I = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5430I", telemetry=[]))
    MOXA_IA_240 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa IA-240", telemetry=[]))
    TCC_120 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="TCC-120", telemetry=[]))

    DRD11 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRD11", telemetry=[]))
    Kamera_IB8367A = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB8367A", telemetry=[]))
    Kamera_IB8360 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB8360", telemetry=[]))
    Kamera_IB9387_EHT_A = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB9387-EHT-A", telemetry=[]))
    IB9387_HT_A_Kamera = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB9387-HT-A", telemetry=[]))
    IB8367_Kamera = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB8367", telemetry=[]))
    TRB_140_Router = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="TRB-140 Router", telemetry=[]))
    TRB140_Router = TRB_140_Router
    TRB_245_Router = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="TRB-245 Router", telemetry=[]))
    WR21_Router = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="WR21 Router", telemetry=[]))
    H685_Router = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="H685 Router", telemetry=[]))
    RUT241_Router = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="RUT241 Router", telemetry=[]))
    ER4110_Router = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="ER4110 Router", telemetry=[]))

    IB9368_HT_Kamera = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB9368-HT", telemetry=[]))
    Kamera_IB8367 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB8367", telemetry=[]))

    Kamera_IP8361 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IP8361", telemetry=[]))
    Kamera_MS9321_EHV = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera MS9321-EHV", telemetry=[]))

    Kamera = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera", telemetry=[]))
    GPRS = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="GPRS", telemetry=[]))
    GPRS_H685 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="GPRS H685", telemetry=[]))
    GPRS_WR21 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="GPRS WR21", telemetry=[]))
    GPRS_IR302 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="GPRS IR302", telemetry=[]))
    SOLAR = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="SOLAR", telemetry=[]))
    Návestidlo_4x = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Návestidlo", telemetry=[]))
    Návestidlo_2x = Návestidlo_4x

    DM_32_ROSA = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DM 32 ROSA", telemetry=[]))



    station_service = main.runner.get(StationService)
    print("zacinam import stanic")
    if len(rs_router.get_all()) > 0:
            print("import skip")
            return

    investment_service = main.runner.get(InvestmentContractService)
    inv_id = investment_service.create_new_contract("ZM/2019/0482", datetime(2019, 12, 18), datetime(2023, 12, 27),
                                                    365 * 4)

    rs10 = rs_router.create_road_segment(RoadSegmentNewSchema(name="Behárovce", ssud="SSÚD 10"))
    s0 = station_service.create_station(
        StationNewSchema(name="Levoča", road_segment_id=rs10, km_of_road=352,
                         km_of_road_note="",
                         latitude=49.00838, longitude=20.59656, see_level=None, description=""))
    s1 = station_service.create_station(
        StationNewSchema(name="Šibenik - Západný portál", road_segment_id=rs10, km_of_road=353,
                         km_of_road_note="",
                         latitude=49.01005, longitude=20.6095, see_level=None, description=""))
    s2 = station_service.create_station(
        StationNewSchema(name="Šibenik - Východný portál", road_segment_id=rs10, km_of_road=354,
                         km_of_road_note="",
                         latitude=49.00855, longitude=20.62287, see_level=None, description=""))
    s3 = station_service.create_station(
        StationNewSchema(name="Spišský Hrhov", road_segment_id=rs10, km_of_road=355,
                         km_of_road_note="",
                         latitude=49.00649, longitude=20.63338, see_level=None, description=""))
    s4 = station_service.create_station(
        StationNewSchema(name="Doľany", road_segment_id=rs10, km_of_road=356,
                         km_of_road_note="",
                         latitude=49.00731, longitude=20.65201, see_level=None, description=""))
    s5 = station_service.create_station(
        StationNewSchema(name="Klčov", road_segment_id=rs10, km_of_road=357,
                         km_of_road_note="",
                         latitude=49.009192, longitude=20.662395, see_level=None, description=""))
    s6 = station_service.create_station(
        StationNewSchema(name="Nemešany", road_segment_id=rs10, km_of_road=358,
                         km_of_road_note="",
                         latitude=49.008047, longitude=20.676059, see_level=None, description=""))
    s7 = station_service.create_station(
        StationNewSchema(name="Jablonov", road_segment_id=rs10, km_of_road=361,
                         km_of_road_note="",
                         latitude=49.007783, longitude=20.7124, see_level=None, description=""))
    s8 = station_service.create_station(
        StationNewSchema(name="Studenec", road_segment_id=rs10, km_of_road=365,
                         km_of_road_note="",
                         latitude=49.00745, longitude=20.766767, see_level=None, description=""))
    s9 = station_service.create_station(
        StationNewSchema(name="Bijacovce", road_segment_id=rs10, km_of_road=367,
                         km_of_road_note="",
                         latitude=49.00712, longitude=20.79333, see_level=None, description=""))
    s10 = station_service.create_station(
        StationNewSchema(name="Behárovce", road_segment_id=rs10, km_of_road=369,
                         km_of_road_note="",
                         latitude=49.009543, longitude=20.823799, see_level=None, description=""))
    s11 = station_service.create_station(
        StationNewSchema(name="Korytné", road_segment_id=rs10, km_of_road=370,
                         km_of_road_note="",
                         latitude=49.009291, longitude=20.835331, see_level=None, description=""))
    s12 = station_service.create_station(
        StationNewSchema(name="Branisko - Západný portál", road_segment_id=rs10, km_of_road=370,
                         km_of_road_note="",
                         latitude=49.01023, longitude=20.842305, see_level=None, description=""))
    s13 = station_service.create_station(
        StationNewSchema(name="Branisko - Východný portál", road_segment_id=rs10, km_of_road=375,
                         km_of_road_note="",
                         latitude=48.996394, longitude=20.906429, see_level=None, description=""))
    s14 = station_service.create_station(
        StationNewSchema(name="Široké", road_segment_id=rs10, km_of_road=376,
                         km_of_road_note="",
                         latitude=48.996112, longitude=20.912027, see_level=None, description=""))
    s15 = station_service.create_station(
        StationNewSchema(name="Široké zárez", road_segment_id=rs10, km_of_road=377,
                         km_of_road_note="",
                         latitude=48.996234, longitude=20.9177, see_level=None, description=""))
    s16 = station_service.create_station(
        StationNewSchema(name="Široké zjazd", road_segment_id=rs10, km_of_road=378,
                         km_of_road_note="",
                         latitude=49.00925, longitude=20.93921, see_level=None, description=""))
    s17 = station_service.create_station(
        StationNewSchema(name="Fričovce 1", road_segment_id=rs10, km_of_road=380,
                         km_of_road_note="",
                         latitude=49.015006, longitude=20.952924, see_level=None, description=""))
    s18 = station_service.create_station(
        StationNewSchema(name="Fričovce 2", road_segment_id=rs10, km_of_road=381,
                         km_of_road_note="",
                         latitude=49.018281, longitude=20.968313, see_level=None, description=""))
    s19 = station_service.create_station(
        StationNewSchema(name="Hendrichovce 1", road_segment_id=rs10, km_of_road=383,
                         km_of_road_note="",
                         latitude=49.02405, longitude=20.99034, see_level=None, description=""))
    s20 = station_service.create_station(
        StationNewSchema(name="Hendrichovce 2", road_segment_id=rs10, km_of_road=383,
                         km_of_road_note="",
                         latitude=49.02634, longitude=20.9961, see_level=None, description=""))
    s21 = station_service.create_station(
        StationNewSchema(name="Hendrichovce 3", road_segment_id=rs10, km_of_road=384,
                         km_of_road_note="",
                         latitude=49.02626, longitude=21.00951, see_level=None, description=""))
    s22 = station_service.create_station(
        StationNewSchema(name="Bertotovce 1", road_segment_id=rs10, km_of_road=385,
                         km_of_road_note="",
                         latitude=49.02622, longitude=21.02226, see_level=None, description=""))
    s23 = station_service.create_station(
        StationNewSchema(name="Bertotovce 2", road_segment_id=rs10, km_of_road=386,
                         km_of_road_note="",
                         latitude=49.02012, longitude=21.03514, see_level=None, description=""))
    s24 = station_service.create_station(
        StationNewSchema(name="Bertotovce 3", road_segment_id=rs10, km_of_road=387,
                         km_of_road_note="",
                         latitude=49.01622, longitude=21.0393, see_level=None, description=""))
    s25 = station_service.create_station(
        StationNewSchema(name="Chmiňany", road_segment_id=rs10, km_of_road=389,
                         km_of_road_note="",
                         latitude=49.00072, longitude=21.10239, see_level=None, description=""))
    s26 = station_service.create_station(
        StationNewSchema(name="Chminianska Nová Ves", road_segment_id=rs10, km_of_road=392,
                         km_of_road_note="",
                         latitude=48.577541, longitude=18.8362, see_level=None, description=""))
    rs3 = rs_router.create_road_segment(RoadSegmentNewSchema(name="Zvolen", ssud="SSÚR 3"))
    s27 = station_service.create_station(
        StationNewSchema(name="R3 Horná Štubňa", road_segment_id=rs3, km_of_road=89,
                         km_of_road_note="",
                         latitude=48.808989, longitude=18.874001, see_level=None, description=""))
    s28 = station_service.create_station(
        StationNewSchema(name="Budča – odpočívadlo", road_segment_id=rs3, km_of_road=231,
                         km_of_road_note="",
                         latitude=48.56113, longitude=19.08381, see_level=None, description=""))
    s29 = station_service.create_station(
        StationNewSchema(name="Slatina", road_segment_id=rs3, km_of_road=110,
                         km_of_road_note="",
                         latitude=48.572726, longitude=19.253883, see_level=None, description=""))
    s30 = station_service.create_station(
        StationNewSchema(name="Vígľaš", road_segment_id=rs3, km_of_road=116,
                         km_of_road_note="",
                         latitude=48.551775, longitude=19.323642, see_level=None, description=""))
    s31 = station_service.create_station(
        StationNewSchema(name="Stožok", road_segment_id=rs3, km_of_road=119,
                         km_of_road_note="",
                         latitude=48.541915, longitude=19.35882, see_level=None, description=""))
    s32 = station_service.create_station(
        StationNewSchema(name="Detva", road_segment_id=rs3, km_of_road=123,
                         km_of_road_note="",
                         latitude=48.53605, longitude=19.40798, see_level=None, description=""))
    s33 = station_service.create_station(
        StationNewSchema(name="Ožďany", road_segment_id=rs3, km_of_road=303,
                         km_of_road_note="",
                         latitude=48.376437, longitude=19.92036, see_level=None, description=""))
    s34 = station_service.create_station(
        StationNewSchema(name="Figa", road_segment_id=rs3, km_of_road=337,
                         km_of_road_note="",
                         latitude=48.399049, longitude=20.243032, see_level=None, description=""))
    s35 = station_service.create_station(
        StationNewSchema(name="Tornaľa", road_segment_id=rs3, km_of_road=344,
                         km_of_road_note="",
                         latitude=48.404478, longitude=20.331425, see_level=None, description=""))
    s36 = station_service.create_station(
        StationNewSchema(name="Šášovské podhradie", road_segment_id=rs3, km_of_road=128,
                         km_of_road_note="",
                         latitude=48.5869, longitude=18.913, see_level=None, description=""))
    s37 = station_service.create_station(
        StationNewSchema(name="Jalná", road_segment_id=rs3, km_of_road=132,
                         km_of_road_note="",
                         latitude=48.584656, longitude=18.955489, see_level=None, description=""))
    s38 = station_service.create_station(
        StationNewSchema(name="Hronská Breznica", road_segment_id=rs3, km_of_road=136,
                         km_of_road_note="",
                         latitude=48.56964, longitude=18.9915, see_level=None, description=""))
    s39 = station_service.create_station(
        StationNewSchema(name="Budča", road_segment_id=rs3, km_of_road=144,
                         km_of_road_note="",
                         latitude=48.58536, longitude=19.09016, see_level=None, description=""))
    s40 = station_service.create_station(
        StationNewSchema(name="Kováčová", road_segment_id=rs3, km_of_road=147,
                         km_of_road_note="",
                         latitude=48.60603, longitude=19.12078, see_level=None, description=""))
    s41 = station_service.create_station(
        StationNewSchema(name="Badín", road_segment_id=rs3, km_of_road=155,
                         km_of_road_note="",
                         latitude=48.67184, longitude=19.13285, see_level=None, description=""))
    s42 = station_service.create_station(
        StationNewSchema(name="Kremnička", road_segment_id=rs3, km_of_road=158,
                         km_of_road_note="",
                         latitude=48.69818, longitude=19.13252, see_level=None, description=""))
    s43 = station_service.create_station(
        StationNewSchema(name="Školská", road_segment_id=rs3, km_of_road=163,
                         km_of_road_note="",
                         latitude=48.73987, longitude=19.13454, see_level=None, description=""))
    rs5 = rs_router.create_road_segment(RoadSegmentNewSchema(name="Považská Bystrica", ssud="SSÚD 5"))
    s44 = station_service.create_station(
        StationNewSchema(name="Kočkovský kanál", road_segment_id=rs5, km_of_road=151,
                         km_of_road_note="",
                         latitude=49.03606, longitude=18.27317, see_level=None, description=""))
    s45 = station_service.create_station(
        StationNewSchema(name="Ladce", road_segment_id=rs5, km_of_road=152,
                         km_of_road_note="",
                         latitude=49.046028, longitude=18.286611, see_level=None, description=""))
    s46 = station_service.create_station(
        StationNewSchema(name="Púchov", road_segment_id=rs5, km_of_road=9999,
                         km_of_road_note="",
                         latitude=49.085464, longitude=18.319114, see_level=None, description="privádzač PU"))
    s47 = station_service.create_station(
        StationNewSchema(name="Púchov Most", road_segment_id=rs5, km_of_road=9999,
                         km_of_road_note="",
                         latitude=49.114033, longitude=18.316509, see_level=None, description="privádzač PU"))
    s48 = station_service.create_station(
        StationNewSchema(name="Beluša", road_segment_id=rs5, km_of_road=157,
                         km_of_road_note="",
                         latitude=49.063831, longitude=18.344197, see_level=None, description=""))
    s49 = station_service.create_station(
        StationNewSchema(name="Sverepec", road_segment_id=rs5, km_of_road=161,
                         km_of_road_note="",
                         latitude=49.069078, longitude=18.39219, see_level=None, description=""))
    s50 = station_service.create_station(
        StationNewSchema(name="Sverepec Most", road_segment_id=rs5, km_of_road=162,
                         km_of_road_note="",
                         latitude=49.07199, longitude=18.40343, see_level=None, description=""))
    s51 = station_service.create_station(
        StationNewSchema(name="Sverepec múr ", road_segment_id=rs5, km_of_road=163,
                         km_of_road_note="",
                         latitude=49.07726, longitude=18.41599, see_level=None, description=""))
    s52 = station_service.create_station(
        StationNewSchema(name="PB Estakáda", road_segment_id=rs5, km_of_road=169,
                         km_of_road_note="",
                         latitude=49.12305, longitude=18.44497, see_level=None, description=""))
    rs4 = rs_router.create_road_segment(RoadSegmentNewSchema(name="Trenčín", ssud="SSÚD 4"))
    s53 = station_service.create_station(
        StationNewSchema(name="Piešťany", road_segment_id=rs4, km_of_road=83,
                         km_of_road_note="",
                         latitude=48.591785, longitude=17.790475, see_level=None, description=""))
    s54 = station_service.create_station(
        StationNewSchema(name="Horná Streda 2", road_segment_id=rs4, km_of_road=92,
                         km_of_road_note="",
                         latitude=48.64995, longitude=17.849716, see_level=None, description=""))
    s55 = station_service.create_station(
        StationNewSchema(name="Horná Streda 1", road_segment_id=rs4, km_of_road=92,
                         km_of_road_note="",
                         latitude=48.653182, longitude=17.859014, see_level=None, description=""))
    s56 = station_service.create_station(
        StationNewSchema(name="Letisko 3", road_segment_id=rs4, km_of_road=95,
                         km_of_road_note="",
                         latitude=48.675394, longitude=17.873095, see_level=None, description=""))
    s57 = station_service.create_station(
        StationNewSchema(name="Letisko 2", road_segment_id=rs4, km_of_road=97,
                         km_of_road_note="",
                         latitude=48.688516, longitude=17.872596, see_level=None, description=""))
    s58 = station_service.create_station(
        StationNewSchema(name="Letisko 1", road_segment_id=rs4, km_of_road=99,
                         km_of_road_note="",
                         latitude=48.705098, longitude=17.872036, see_level=None, description=""))
    s59 = station_service.create_station(
        StationNewSchema(name="Nové Mesto", road_segment_id=rs4, km_of_road=103,
                         km_of_road_note="",
                         latitude=48.743951, longitude=17.860165, see_level=None, description=""))
    s60 = station_service.create_station(
        StationNewSchema(name="Zelená Voda", road_segment_id=rs4, km_of_road=107,
                         km_of_road_note="",
                         latitude=48.773538, longitude=17.876853, see_level=None, description=""))
    s61 = station_service.create_station(
        StationNewSchema(name="Ivanovce 3", road_segment_id=rs4, km_of_road=111,
                         km_of_road_note="",
                         latitude=48.806637, longitude=17.905412, see_level=None, description=""))
    s62 = station_service.create_station(
        StationNewSchema(name="Ivanovce 2", road_segment_id=rs4, km_of_road=112,
                         km_of_road_note="",
                         latitude=48.813316, longitude=17.906617, see_level=None, description=""))
    s63 = station_service.create_station(
        StationNewSchema(name="Ivanovce 1", road_segment_id=rs4, km_of_road=116,
                         km_of_road_note="",
                         latitude=48.84164, longitude=17.940961, see_level=None, description=""))
    s64 = station_service.create_station(
        StationNewSchema(name="Drietomica", road_segment_id=rs4, km_of_road=121,
                         km_of_road_note="",
                         latitude=48.876498, longitude=17.976321, see_level=None, description=""))
    s65 = station_service.create_station(
        StationNewSchema(name="Kostolná", road_segment_id=rs4, km_of_road=121,
                         km_of_road_note="",
                         latitude=48.881008, longitude=17.980306, see_level=None, description=""))
    s66 = station_service.create_station(
        StationNewSchema(name="Záblatie", road_segment_id=rs4, km_of_road=123,
                         km_of_road_note="",
                         latitude=48.892266, longitude=17.981936, see_level=None, description=""))
    s67 = station_service.create_station(
        StationNewSchema(name="Skala", road_segment_id=rs4, km_of_road=130,
                         km_of_road_note="",
                         latitude=48.917956, longitude=18.066064, see_level=None, description=""))
    s68 = station_service.create_station(
        StationNewSchema(name="Sučanka", road_segment_id=rs4, km_of_road=131,
                         km_of_road_note="",
                         latitude=48.923524, longitude=18.077185, see_level=None, description=""))
    s69 = station_service.create_station(
        StationNewSchema(name="Váh", road_segment_id=rs4, km_of_road=132,
                         km_of_road_note="",
                         latitude=48.929959, longitude=18.085092, see_level=None, description=""))
    s70 = station_service.create_station(
        StationNewSchema(name="Dubnica", road_segment_id=rs4, km_of_road=137,
                         km_of_road_note="",
                         latitude=48.960651, longitude=18.132598, see_level=None, description=""))
    s71 = station_service.create_station(
        StationNewSchema(name="Ilava", road_segment_id=rs4, km_of_road=144,
                         km_of_road_note="",
                         latitude=48.997258, longitude=18.215811, see_level=None, description=""))
    s72 = station_service.create_station(
        StationNewSchema(name="Prejta", road_segment_id=rs4, km_of_road=141,
                         km_of_road_note="",
                         latitude=48.978384, longitude=18.177226, see_level=None, description=""))
    s73 = station_service.create_station(
        StationNewSchema(name="Trenčín", road_segment_id=rs4, km_of_road=9999,
                         km_of_road_note="",
                         latitude=48.894, longitude=18.003495, see_level=None, description="privádzač TN"))
    s74 = station_service.create_station(
        StationNewSchema(name="Drietoma", road_segment_id=rs4, km_of_road=111,
                         km_of_road_note="",
                         latitude=48.87759, longitude=17.96092, see_level=None, description=""))
    s75 = station_service.create_station(
        StationNewSchema(name="Branné", road_segment_id=rs4, km_of_road=105,
                         km_of_road_note="",
                         latitude=48.935608, longitude=17.940489, see_level=None, description=""))
    s76 = station_service.create_station(
        StationNewSchema(name="Majer", road_segment_id=rs4, km_of_road=103,
                         km_of_road_note="",
                         latitude=48.945615, longitude=17.922155, see_level=None, description=""))
    s77 = station_service.create_station(
        StationNewSchema(name="R2 Ozorovce", road_segment_id=rs4, km_of_road=26,
                         km_of_road_note="",
                         latitude=48.74396, longitude=18.22085, see_level=None, description=""))
    s78 = station_service.create_station(
        StationNewSchema(name="R2 Chlievany", road_segment_id=rs4, km_of_road=31,
                         km_of_road_note="",
                         latitude=48.70416, longitude=18.23879, see_level=None, description=""))
    s79 = station_service.create_station(
        StationNewSchema(name="R2 Pravotice", road_segment_id=rs4, km_of_road=34,
                         km_of_road_note="",
                         latitude=48.69651, longitude=18.27927, see_level=None, description=""))
    rs2 = rs_router.create_road_segment(RoadSegmentNewSchema(name="Nová Baňa", ssud="SSÚR 2"))
    s80 = station_service.create_station(
        StationNewSchema(name="Tekovské Nemce", road_segment_id=rs2, km_of_road=84,
                         km_of_road_note="",
                         latitude=48.36666, longitude=18.54759, see_level=None, description=""))
    s81 = station_service.create_station(
        StationNewSchema(name=" Hronský Beňadik", road_segment_id=rs2, km_of_road=87,
                         km_of_road_note="",
                         latitude=48.36211, longitude=18.57632, see_level=None, description=""))
    s82 = station_service.create_station(
        StationNewSchema(name=" Nová Baňa", road_segment_id=rs2, km_of_road=94,
                         km_of_road_note="",
                         latitude=48.40645, longitude=18.63519, see_level=None, description=""))
    s83 = station_service.create_station(
        StationNewSchema(name=" Voznica", road_segment_id=rs2, km_of_road=103,
                         km_of_road_note="",
                         latitude=48.46105, longitude=18.69066, see_level=None, description=""))
    s84 = station_service.create_station(
        StationNewSchema(name=" Žarnovica", road_segment_id=rs2, km_of_road=108,
                         km_of_road_note="",
                         latitude=48.49345, longitude=18.73046, see_level=None, description=""))
    s85 = station_service.create_station(
        StationNewSchema(name=" Hliník nad Hronom", road_segment_id=rs2, km_of_road=116,
                         km_of_road_note="",
                         latitude=48.544, longitude=18.78378, see_level=None, description=""))
    s86 = station_service.create_station(
        StationNewSchema(name="R2 Žiar nad Hronom", road_segment_id=rs2, km_of_road=98,
                         km_of_road_note="",
                         latitude=48.57754, longitude=18.8362, see_level=None, description=""))
    s87 = station_service.create_station(
        StationNewSchema(name="R2 Lovčica ", road_segment_id=rs2, km_of_road=95,
                         km_of_road_note="",
                         latitude=48.59777, longitude=18.82098, see_level=None, description=""))
    s88 = station_service.create_station(
        StationNewSchema(name="Žiar nad Hronom", road_segment_id=rs2, km_of_road=125,
                         km_of_road_note="",
                         latitude=48.584167, longitude=18.871005, see_level=None, description=""))
    s89 = station_service.create_station(
        StationNewSchema(name="Žiar n. Hronom východ ", road_segment_id=rs2, km_of_road=127,
                         km_of_road_note="",
                         latitude=48.588589, longitude=18.894561, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4330501")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3620001")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N3010009")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3010050")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "N37435")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB10, "N36166")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N19206")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "N4010228")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N4250684")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N3740590")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s0),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L3610261")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K4910016")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L3150008")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L3020006")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L31312")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P06476")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 6, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "K53110")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "L2930750")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "L3620825")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N4040536")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 10, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s1),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L3610262")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K5010005")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L3150024")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L3020017")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L31346")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P01255")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 6, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "K53108")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "L3630480")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "L3620832")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N4040535")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 10, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s2),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "M3940500")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "M0750002")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "M3050024")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "M3020013")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "M33213")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "L37537")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L53204")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "M3810827")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P2340415")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 6, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "M3740997")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s3),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4441181")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "N36131")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37476")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N08105")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "N4220410")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N4250683")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N4250421")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s4),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4410245")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3540003")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N2950005")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3010017")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37477")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "N20182")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N08106")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "N4140460")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N4410493")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N4250419")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s5),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4441026")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3630002")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N302005")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3240007")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "T01370")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2021, 5, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "N41446")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "S47305")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "N4140458")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N4411102")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N4250422")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s6),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3550461")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230035")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U3440781")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510008")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P41165")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L37503")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "U3030833")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "S4610844")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2020, 11, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "P4820411")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5150A, "")],
            station_id=s7),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3540576")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230005")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U2930264")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2751127")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P41139")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P41121")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "U2850629")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "R2940184")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2020, 11, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5232I, "")],
            station_id=s8),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "K4930001")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "H3920011")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "K4120026")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "K3320008")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "K43335")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "H34243 (BB5)")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "K25408")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "K4620036")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "R4331042")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2019, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "K4630001")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s9),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3620223")],
            station_id=s10),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 19), paid_service_until=datetime(2026, 9, 19),
        installation_date=datetime(2022, 9, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230034")],
            station_id=s10),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 19), paid_service_until=datetime(2026, 9, 19),
        installation_date=datetime(2022, 9, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U3440778")],
            station_id=s10),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 19), paid_service_until=datetime(2026, 9, 19),
        installation_date=datetime(2022, 9, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510012")],
            station_id=s10),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 19), paid_service_until=datetime(2026, 9, 19),
        installation_date=datetime(2022, 9, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N08311")],
            station_id=s10),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 4), paid_service_until=None,
        installation_date=datetime(2017, 7, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "S07104")],
            station_id=s10),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 5, 8), paid_service_until=None,
        installation_date=datetime(2021, 5, 8))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U3030836")],
            station_id=s10),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 19), paid_service_until=datetime(2026, 9, 19),
        installation_date=datetime(2022, 9, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s10),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 19), paid_service_until=datetime(2026, 9, 19),
        installation_date=datetime(2022, 9, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "P301021")],
            station_id=s10),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 19), paid_service_until=None,
        installation_date=datetime(2018, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U2950159")],
            station_id=s10),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 19), paid_service_until=datetime(2026, 9, 19),
        installation_date=datetime(2022, 9, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(CMP6, "140487.0")],
            station_id=s10),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRA411, "J505035")],
            station_id=s10),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5150, "")],
            station_id=s10),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3420885")],
            station_id=s11),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230023")],
            station_id=s11),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U2930248")],
            station_id=s11),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2751122")],
            station_id=s11),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P41163")],
            station_id=s11),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 19), paid_service_until=None,
        installation_date=datetime(2018, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "S07101")],
            station_id=s11),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 5, 8), paid_service_until=None,
        installation_date=datetime(2021, 5, 8))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2851130")],
            station_id=s11),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s11),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "I01123")],
            station_id=s11),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 1, 10), paid_service_until=None,
        installation_date=datetime(2013, 1, 10))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P4630529")],
            station_id=s11),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 19), paid_service_until=None,
        installation_date=datetime(2018, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5232I, "")],
            station_id=s11),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2013, 1, 10))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3550406")],
            station_id=s12),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230016")],
            station_id=s12),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U3440767")],
            station_id=s12),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510009")],
            station_id=s12),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB10, "")],
            station_id=s12),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "S07108")],
            station_id=s12),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 5, 8), paid_service_until=None,
        installation_date=datetime(2021, 5, 8))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L06502")],
            station_id=s12),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 14), paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U2920500")],
            station_id=s12),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850637")],
            station_id=s12),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s12),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "D0710013")],
            station_id=s12),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5232I, "")],
            station_id=s12),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3410445")],
            station_id=s13),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "U0810001")],
            station_id=s13),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 9, 21), paid_service_until=datetime(2022, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U2930278")],
            station_id=s13),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2330628")],
            station_id=s13),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB10, "")],
            station_id=s13),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L26538")],
            station_id=s13),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 14), paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L06503")],
            station_id=s13),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 14), paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U2930188")],
            station_id=s13),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850625")],
            station_id=s13),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s13),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "")],
            station_id=s13),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5232I, "")],
            station_id=s13),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3550374")],
            station_id=s14),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230032")],
            station_id=s14),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U2910418")],
            station_id=s14),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510028")],
            station_id=s14),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "R42339")],
            station_id=s14),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 9, 8), paid_service_until=None,
        installation_date=datetime(2020, 9, 8))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "S44354")],
            station_id=s14),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 25), paid_service_until=None,
        installation_date=datetime(2020, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s14),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 12), paid_service_until=None,
        installation_date=datetime(2011, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "H1040003")],
            station_id=s14),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s14),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "R343019")],
            station_id=s14),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 11, 19), paid_service_until=None,
        installation_date=datetime(2019, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N4740435")],
            station_id=s14),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 10), paid_service_until=None,
        installation_date=datetime(2017, 12, 10))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DR11SYS, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DXS422, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC111, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DST111, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRA411, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT520, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__2_2Ah, "")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 20), paid_service_until=None,
        installation_date=datetime(2017, 6, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5150, "TAFFC1000286")],
            station_id=s15),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 1, 1), paid_service_until=None,
        installation_date=datetime(2016, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "K4930002")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "H3820001")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "K4120004")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "K3320020")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "T24317")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 12, 9), paid_service_until=None,
        installation_date=datetime(2021, 12, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "M18370")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 30), paid_service_until=None,
        installation_date=datetime(2017, 6, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "K25409")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "K4620040")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "K4630010")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "K3510011")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_6150, "TAECB1015709")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_6150, "TADJC1094053")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 4, 14), paid_service_until=None,
        installation_date=datetime(2021, 4, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(TCC_120, "TAEEC1026995")],
            station_id=s16),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 7, 9), paid_service_until=None,
        installation_date=datetime(2015, 7, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3420857")],
            station_id=s18),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4240008")],
            station_id=s18),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U2930230")],
            station_id=s18),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2751123")],
            station_id=s18),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L09115")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 14), paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "L51574")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 5, 25), paid_service_until=None,
        installation_date=datetime(2016, 5, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 12), paid_service_until=None,
        installation_date=datetime(2011, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850633")],
            station_id=s18),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s18),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U4310611")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 11, 7), paid_service_until=None,
        installation_date=datetime(2022, 11, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(CMP6, "140509.0")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRA411, " J505025")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Moxa_Nport_5150, "")],
            station_id=s18),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3550529")],
            station_id=s17),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230040")],
            station_id=s17),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U3440761")],
            station_id=s17),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510015")],
            station_id=s17),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L40113")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 28), paid_service_until=None,
        installation_date=datetime(2015, 10, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "S20471")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 12), paid_service_until=None,
        installation_date=datetime(2020, 11, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 11, 25), paid_service_until=None,
        installation_date=datetime(2011, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850632")],
            station_id=s17),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s17),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "T2930287")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 8, 16), paid_service_until=None,
        installation_date=datetime(2021, 8, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PTB110, "")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 11, 25), paid_service_until=None,
        installation_date=datetime(2011, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N2620139")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 29), paid_service_until=None,
        installation_date=datetime(2017, 6, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__2_2Ah, "")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 20), paid_service_until=None,
        installation_date=datetime(2017, 6, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8367A, "0002D16DC1CF")],
            station_id=s17),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 21), paid_service_until=None,
        installation_date=datetime(2018, 6, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB9387_EHT_A, "0002D1A7E9A0")],
            station_id=s17),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 3, 14), paid_service_until=datetime(2027, 3, 14),
        installation_date=datetime(2023, 3, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L2940730")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K4630018")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L1640017")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L2830022")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "L28501")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "M31360")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 9, 16), paid_service_until=None,
        installation_date=datetime(2016, 9, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "L2930746")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "L2720556")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "L5050245")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 1, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s20),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L2940731")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K4630014")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L1960026")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L2830020")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "M33244")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 11, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "M31358")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L06510")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "L0950286")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "L2720557")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "M3740987")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s22),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L2940732")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K4630017")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L2750006")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L3020021")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "N36130")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2017, 10, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "M31359")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L06506")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "L0510393")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "K3530008")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P2340414")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 21), paid_service_until=None,
        installation_date=datetime(2018, 6, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s23),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L2940733")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K4630019")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L1640024")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L2830018")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "K40501")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "M31371")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L06507")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "L0510394")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "L2720555")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P2340413")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 21), paid_service_until=None,
        installation_date=datetime(2018, 6, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s25),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L2940734")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K4640017")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L2750025")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L2830025")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "S37195")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 13), paid_service_until=None,
        installation_date=datetime(2020, 11, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L40136")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 1, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "K48325")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "L0550657")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "L2920497")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "L5050246")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 1, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s26),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "P2410744")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3820029")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N4750003")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "P1423109")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P11248")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "P06480")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N43407")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "P2150356")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "P1420179")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P2350574")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211, "P061010")],
            station_id=s24),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "P3230358")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "P0510009")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "P1813162")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "P2443452")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P14295")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P28158")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N47410")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "P3220361")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "P3210855")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P3220901")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211, "P061006")],
            station_id=s19),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "P3110779")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "P0640031")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "P1813163")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "P2833085")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P14234")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "N37433")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N43403")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "P2950100")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "P3030348")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P3220900")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211, "P027029")],
            station_id=s21),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3410438")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "U2120032")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U2930272")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2330627")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "")],
            station_id=s42),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L42499")],
            station_id=s42),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 8, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s42),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "U2850620")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "U3020293")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9387_HT_A_Kamera, "0002D1A8CDFF")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 7, 27), paid_service_until=datetime(2027, 7, 27),
        installation_date=datetime(2023, 7, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(TRB_140_Router, "6000340246.0")],
            station_id=s42),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 7, 27), paid_service_until=datetime(2027, 7, 27),
        installation_date=datetime(2023, 7, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4330661")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3530007")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N3020003")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3010048")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37494")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "N38302")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N19210")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "N4240762")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N4020932")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N4250685")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WR21_Router, "604054")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB8367_Kamera, "0002D1603C3D")],
            station_id=s41),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 7), paid_service_until=datetime(2019, 12, 7),
        installation_date=datetime(2017, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4420413")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3440002")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N3020008")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3010052")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "N41447")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37495")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N36410")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT536, "N4340069")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU133, "")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(H685_Router, "660420156A002B71")],
            station_id=s40),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9368_HT_Kamera, "0002D1A7AC74")],
            station_id=s40),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 7, 27), paid_service_until=datetime(2027, 7, 27),
        installation_date=datetime(2023, 7, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "M3940501")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "M0510015")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "M3040005")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "M3020026")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "M06264")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "M33214")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L53208")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "M3810829")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "M3920116")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "M3910741")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WR21_Router, "670214.0")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 3), paid_service_until=None,
        installation_date=datetime(2018, 8, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB8367_Kamera, "0002D14B0879")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=datetime(2018, 10, 31),
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB8367_Kamera, "0002D16DC1CD")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 29), paid_service_until=None,
        installation_date=datetime(2018, 6, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB8367_Kamera, "0002D16DC1CE")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 29), paid_service_until=None,
        installation_date=datetime(2018, 6, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211, "M114011")],
            station_id=s28),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "T1431052")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 4, 29), paid_service_until=None,
        installation_date=datetime(2021, 4, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "S5010015")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 4, 29), paid_service_until=None,
        installation_date=datetime(2021, 4, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "T0913607")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 4, 29), paid_service_until=None,
        installation_date=datetime(2021, 4, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "S5113023")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 4, 29), paid_service_until=None,
        installation_date=datetime(2021, 4, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "R37477")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 11, 14), paid_service_until=None,
        installation_date=datetime(2019, 11, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "T38187")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 12, 7), paid_service_until=None,
        installation_date=datetime(2021, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 15), paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "T1130424")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 4, 29), paid_service_until=None,
        installation_date=datetime(2021, 4, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR13, "")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 30), paid_service_until=None,
        installation_date=datetime(2020, 11, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "U3020294")],
            station_id=s38),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 8, 16), paid_service_until=datetime(2026, 8, 16),
        installation_date=datetime(2022, 8, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9387_HT_A_Kamera, "0002D1A4B57F")],
            station_id=s38),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 7, 27), paid_service_until=datetime(2027, 7, 27),
        installation_date=datetime(2023, 7, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(TRB_140_Router, "6000340888.0")],
            station_id=s38),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 7, 27), paid_service_until=datetime(2027, 7, 27),
        installation_date=datetime(2023, 7, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "J4720002")],
            station_id=s38),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 11, 29), paid_service_until=None,
        installation_date=datetime(2013, 11, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N0610552")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "M3630008")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "M4030018")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "M3330048")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P41164")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 10, 30), paid_service_until=datetime(2022, 10, 30),
        installation_date=datetime(2018, 10, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "M42418")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "M01207")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "N0330807")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "U3020295")],
            station_id=s29),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 8, 17), paid_service_until=datetime(2026, 8, 17),
        installation_date=datetime(2022, 8, 17))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N0320775")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(MOXA_IA_240, "TAFBC1074526")],
            station_id=s29),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N0610535")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "M3610005")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "M4620002")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "M4240001")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "T37140")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 7, 26), paid_service_until=None,
        installation_date=datetime(2022, 7, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37422")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "M01204")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "M5250416")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "M5020430")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "N0130235")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(MOXA_IA_240, "TAFEC1019150")],
            station_id=s30),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 5, 9), paid_service_until=datetime(2022, 5, 9),
        installation_date=datetime(2017, 5, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L3610263")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K5010001")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L3150019")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L3220010")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB2, "L31374")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB10, "U10137")],
            station_id=s31),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 8, 25), paid_service_until=datetime(2026, 8, 25),
        installation_date=datetime(2022, 8, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "K53109")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "L3630486")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "U3010715")],
            station_id=s31),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 8, 25), paid_service_until=datetime(2026, 8, 25),
        installation_date=datetime(2022, 8, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U4851044")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 12, 7), paid_service_until=None,
        installation_date=datetime(2022, 12, 7))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(MOXA_IA_240, "TAEGC1001626")],
            station_id=s31),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "L3610260")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "K4930005")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "L2750017")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "L3020007")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "P41164")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 4, 1), paid_service_until=None,
        installation_date=datetime(2019, 4, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37458")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 10, 30), paid_service_until=None,
        installation_date=datetime(2017, 10, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "L19104")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "L3210711")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "L3250732")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "L3620835")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU26, "")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(MOXA_IA_240, "TAEGC1001708")],
            station_id=s32),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 25), paid_service_until=datetime(2020, 11, 25),
        installation_date=datetime(2015, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "V3230544")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "V3030072")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "V3230537")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "V3210464")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "K03479")],
            station_id=s35),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 6, 25), paid_service_until=None,
        installation_date=datetime(2014, 6, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "R37483")],
            station_id=s35),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 11, 11), paid_service_until=None,
        installation_date=datetime(2019, 11, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s35),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 11, 24), paid_service_until=None,
        installation_date=datetime(2011, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "V2640811")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PTB100, "V2310889")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "S4610846")],
            station_id=s35),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 18), paid_service_until=None,
        installation_date=datetime(2020, 11, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU2_2, "")],
            station_id=s35),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 19), paid_service_until=None,
        installation_date=datetime(2017, 7, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "")],
            station_id=s35),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 11, 24), paid_service_until=None,
        installation_date=datetime(2011, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RUT241_Router, "6000426915.0")],
            station_id=s35),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 24), paid_service_until=datetime(2027, 8, 24),
        installation_date=datetime(2023, 8, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "V3240429")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 22), paid_service_until=datetime(2027, 8, 22),
        installation_date=datetime(2023, 8, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "V3030465")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 22), paid_service_until=datetime(2027, 8, 22),
        installation_date=datetime(2023, 8, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "V2930726")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 22), paid_service_until=datetime(2027, 8, 22),
        installation_date=datetime(2023, 8, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "V3210613")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 22), paid_service_until=datetime(2027, 8, 22),
        installation_date=datetime(2023, 8, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB10, "K47312")],
            station_id=s34),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 9, 17))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P41166")],
            station_id=s34),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s34),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 15), paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "V2650595")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 22), paid_service_until=datetime(2027, 8, 22),
        installation_date=datetime(2023, 8, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 22), paid_service_until=datetime(2027, 8, 22),
        installation_date=datetime(2023, 8, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "E0840001")],
            station_id=s34),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2014, 10, 31), paid_service_until=datetime(2014, 10, 31),
        installation_date=datetime(2009, 10, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "R4331042")],
            station_id=s34),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 11, 26), paid_service_until=None,
        installation_date=datetime(2019, 11, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU2_2, "")],
            station_id=s34),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 19), paid_service_until=None,
        installation_date=datetime(2017, 7, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WR21_Router, "974094.0")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 7, 1), paid_service_until=datetime(2026, 7, 1),
        installation_date=datetime(2022, 7, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9387_HT_A_Kamera, "0002D19ECCE5")],
            station_id=s34),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 7, 1), paid_service_until=datetime(2026, 7, 1),
        installation_date=datetime(2022, 7, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "V3240429")],
            station_id=s33),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 9, 11), paid_service_until=datetime(2027, 9, 11),
        installation_date=datetime(2023, 9, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "V3030466")],
            station_id=s33),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 9, 11), paid_service_until=datetime(2027, 9, 11),
        installation_date=datetime(2023, 9, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "V3230535")],
            station_id=s33),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 9, 11), paid_service_until=datetime(2027, 9, 11),
        installation_date=datetime(2023, 9, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "V3210611")],
            station_id=s33),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 9, 11), paid_service_until=datetime(2027, 9, 11),
        installation_date=datetime(2023, 9, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "")],
            station_id=s33),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "S43295")],
            station_id=s33),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 19), paid_service_until=None,
        installation_date=datetime(2020, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s33),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 15), paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "V2650595")],
            station_id=s33),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 9, 11), paid_service_until=datetime(2027, 9, 11),
        installation_date=datetime(2023, 9, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s33),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 9, 11), paid_service_until=datetime(2027, 9, 11),
        installation_date=datetime(2023, 9, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "")],
            station_id=s33),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "K4250014")],
            station_id=s33),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 11, 10), paid_service_until=None,
        installation_date=datetime(2014, 11, 10))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU2_2, "")],
            station_id=s33),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 19), paid_service_until=None,
        installation_date=datetime(2017, 7, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(TRB140_Router, "")],
            station_id=s33),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 9, 11), paid_service_until=datetime(2027, 9, 11),
        installation_date=datetime(2023, 9, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "V3230543")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 23), paid_service_until=datetime(2027, 8, 23),
        installation_date=datetime(2023, 8, 23))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "V3030073")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 23), paid_service_until=datetime(2027, 8, 23),
        installation_date=datetime(2023, 8, 23))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "V3230540")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 23), paid_service_until=datetime(2027, 8, 23),
        installation_date=datetime(2023, 8, 23))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "V3210465")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 23), paid_service_until=datetime(2027, 8, 23),
        installation_date=datetime(2023, 8, 23))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "T24373")],
            station_id=s27),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 8, 19), paid_service_until=None,
        installation_date=datetime(2021, 8, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37470")],
            station_id=s27),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 6), paid_service_until=None,
        installation_date=datetime(2017, 12, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s27),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 10, 1), paid_service_until=datetime(2015, 10, 1),
        installation_date=datetime(2010, 10, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155E, "V2650601")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 23), paid_service_until=datetime(2027, 8, 23),
        installation_date=datetime(2023, 8, 23))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 23), paid_service_until=datetime(2027, 8, 23),
        installation_date=datetime(2023, 8, 23))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "")],
            station_id=s27),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 10, 1), paid_service_until=datetime(2015, 10, 1),
        installation_date=datetime(2010, 10, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "R2230312")],
            station_id=s27),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 6, 14), paid_service_until=None,
        installation_date=datetime(2019, 6, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU2_2, "")],
            station_id=s27),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 19), paid_service_until=None,
        installation_date=datetime(2017, 7, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WR21_Router, "974536.0")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 6, 30), paid_service_until=datetime(2026, 6, 30),
        installation_date=datetime(2022, 6, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9387_HT_A_Kamera, "0002D1A18297")],
            station_id=s27),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 6, 30), paid_service_until=datetime(2026, 6, 30),
        installation_date=datetime(2022, 6, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DM_32_ROSA, "")],
            station_id=s43),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI_521, "")],
            station_id=s43),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "U26360")],
            station_id=s43),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2024, 11, 15), paid_service_until=datetime(2024, 11, 15),
        installation_date=datetime(2022, 11, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "U37569")],
            station_id=s43),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2024, 11, 11), paid_service_until=datetime(2024, 11, 11),
        installation_date=datetime(2022, 11, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s43),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 11, 15), paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP45D, "")],
            station_id=s43),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s43),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WA15, "")],
            station_id=s43),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2012, 12, 1), paid_service_until=None,
        installation_date=datetime(2010, 12, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9387_HT_A_Kamera, "0002D1A8CE01")],
            station_id=s43),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 1), paid_service_until=datetime(2027, 8, 1),
        installation_date=datetime(2023, 8, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(TRB_245_Router, "6000132507.0")],
            station_id=s43),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 1), paid_service_until=datetime(2027, 8, 1),
        installation_date=datetime(2023, 8, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU2_2, "")],
            station_id=s43),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 19), paid_service_until=None,
        installation_date=datetime(2017, 7, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DM_32_ROSA, "")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI_521, "")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "K05246")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 6, 25), paid_service_until=None,
        installation_date=datetime(2014, 6, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 15), paid_service_until=None,
        installation_date=datetime(2011, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP45D, "")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2009, 1, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR13, "")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 12, 8), paid_service_until=None,
        installation_date=datetime(2021, 12, 8))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P4620355")],
            station_id=s39),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 4), paid_service_until=None,
        installation_date=datetime(2018, 12, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9387_HT_A_Kamera, "0002D1A8CE00")],
            station_id=s39),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 1), paid_service_until=datetime(2027, 8, 1),
        installation_date=datetime(2023, 8, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(TRB_245_Router, "1128157459.0")],
            station_id=s39),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 1), paid_service_until=datetime(2027, 8, 1),
        installation_date=datetime(2023, 8, 1))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DM_32_ROSA, "")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 9, 26), paid_service_until=datetime(2013, 9, 26),
        installation_date=datetime(2010, 9, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI_521, "N143002")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 19), paid_service_until=None,
        installation_date=datetime(2017, 7, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L37525")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 23), paid_service_until=None,
        installation_date=datetime(2015, 10, 23))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "P41162")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 20), paid_service_until=None,
        installation_date=datetime(2018, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 9, 26), paid_service_until=datetime(2013, 9, 26),
        installation_date=datetime(2010, 9, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "K2810031")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 7, 24), paid_service_until=None,
        installation_date=datetime(2014, 7, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 9, 26), paid_service_until=datetime(2013, 9, 26),
        installation_date=datetime(2010, 9, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "S3230202")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 8, 13), paid_service_until=None,
        installation_date=datetime(2020, 8, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(ER4110_Router, "71935.0")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 9, 26), paid_service_until=datetime(2013, 9, 26),
        installation_date=datetime(2010, 9, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU2_2, "")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 19), paid_service_until=None,
        installation_date=datetime(2017, 7, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "R4410966")],
            station_id=s37),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 11, 14), paid_service_until=None,
        installation_date=datetime(2019, 11, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DR11SYS, "")],
            station_id=s36),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2012, 11, 24), paid_service_until=datetime(2012, 11, 24),
        installation_date=datetime(2009, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DXS422, "")],
            station_id=s36),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2012, 11, 24), paid_service_until=datetime(2012, 11, 24),
        installation_date=datetime(2009, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC111, "S223038")],
            station_id=s36),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 8, 26), paid_service_until=None,
        installation_date=datetime(2021, 8, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DST111, "T103005")],
            station_id=s36),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 10, 14), paid_service_until=None,
        installation_date=datetime(2021, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "T36404")],
            station_id=s36),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 11, 29), paid_service_until=None,
        installation_date=datetime(2021, 11, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRA41, "")],
            station_id=s36),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 11, 29), paid_service_until=None,
        installation_date=datetime(2009, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT520, "")],
            station_id=s36),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2012, 11, 24), paid_service_until=datetime(2012, 11, 24),
        installation_date=datetime(2009, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "U3010396")],
            station_id=s36),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 8, 16), paid_service_until=datetime(2026, 8, 16),
        installation_date=datetime(2022, 8, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(IB9387_HT_A_Kamera, "0002D1A8CE02")],
            station_id=s36),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 3), paid_service_until=datetime(2027, 8, 3),
        installation_date=datetime(2023, 8, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(TRB_245_Router, "6000241914.0")],
            station_id=s36),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 8, 3), paid_service_until=datetime(2027, 8, 3),
        installation_date=datetime(2023, 8, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4450498")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3420017")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "N3130012")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3240008")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37486")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "N37499")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N19207")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT536, "N4450178")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera, "0002D16483AE")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS_H685, "660420156A002AA6")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(SOLAR, "")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(SOLAR, "")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU6V__200Ah, "")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU6V__200Ah, "")],
            station_id=s80),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=datetime(2019, 12, 15),
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3550047")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "U3450001")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "U3450932")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U3450533")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "L42435")],
            station_id=s81),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 5, 12), paid_service_until=None,
        installation_date=datetime(2016, 5, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37465")],
            station_id=s81),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 5), paid_service_until=None,
        installation_date=datetime(2017, 12, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s81),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 16), paid_service_until=None,
        installation_date=datetime(2011, 12, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850630")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "S2950324")],
            station_id=s81),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 7, 28), paid_service_until=None,
        installation_date=datetime(2020, 7, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U2760291")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PTB100, "")],
            station_id=s81),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2011, 11, 24), paid_service_until=None,
        installation_date=datetime(2009, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8367A, "0002D176EB83")],
            station_id=s81),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=None,
        installation_date=datetime(2019, 7, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS_IR302, "RF3022130036490")],
            station_id=s81),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 13), paid_service_until=datetime(2026, 10, 13),
        installation_date=datetime(2022, 10, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Návestidlo_4x, "")],
            station_id=s81),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 5), paid_service_until=None,
        installation_date=datetime(2011, 12, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3610492")],
            station_id=s82),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 5), paid_service_until=datetime(2026, 10, 5),
        installation_date=datetime(2022, 10, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230008")],
            station_id=s82),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 5), paid_service_until=datetime(2026, 10, 5),
        installation_date=datetime(2022, 10, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "U2910421")],
            station_id=s82),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 5), paid_service_until=datetime(2026, 10, 5),
        installation_date=datetime(2022, 10, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510018")],
            station_id=s82),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 5), paid_service_until=datetime(2026, 10, 5),
        installation_date=datetime(2022, 10, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37466")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 5), paid_service_until=None,
        installation_date=datetime(2017, 12, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 16), paid_service_until=None,
        installation_date=datetime(2011, 12, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2851132")],
            station_id=s82),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 5), paid_service_until=datetime(2026, 10, 5),
        installation_date=datetime(2022, 10, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s82),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 5), paid_service_until=datetime(2026, 10, 5),
        installation_date=datetime(2022, 10, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "N2620134")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 4), paid_service_until=None,
        installation_date=datetime(2017, 7, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "J4720001")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 11, 29), paid_service_until=None,
        installation_date=datetime(2013, 11, 29))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(CMP6, "122763.0")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2014, 6, 27), paid_service_until=None,
        installation_date=datetime(2012, 6, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRA411, "")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2014, 6, 27), paid_service_until=None,
        installation_date=datetime(2012, 6, 27))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8367A, "0002D14E2588B")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 12, 21), paid_service_until=None,
        installation_date=datetime(2016, 12, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS_IR302, "RF3022130036488")],
            station_id=s82),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 5), paid_service_until=datetime(2026, 10, 5),
        installation_date=datetime(2022, 10, 5))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Návestidlo_4x, "")],
            station_id=s82),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 12, 10), paid_service_until=None,
        installation_date=datetime(2021, 12, 10))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3620033")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230020")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "U2910417")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510006")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "J47170")],
            station_id=s84),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 6, 10), paid_service_until=None,
        installation_date=datetime(2014, 6, 10))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "S43206")],
            station_id=s84),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 20), paid_service_until=None,
        installation_date=datetime(2020, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s84),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 16), paid_service_until=None,
        installation_date=datetime(2011, 12, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850636")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "V2610191")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2027, 7, 21), paid_service_until=datetime(2027, 7, 21),
        installation_date=datetime(2023, 7, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P4620353")],
            station_id=s84),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 28), paid_service_until=None,
        installation_date=datetime(2018, 11, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8367A, "0002D14E258E")],
            station_id=s84),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 12, 21), paid_service_until=None,
        installation_date=datetime(2016, 12, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS, "RF3022130036487")],
            station_id=s84),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__2_2Ah, "")],
            station_id=s84),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 18), paid_service_until=None,
        installation_date=datetime(2017, 7, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Návestidlo_2x, "")],
            station_id=s84),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2014, 3, 26), paid_service_until=None,
        installation_date=datetime(2012, 3, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3620290")],
            station_id=s83),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 14), paid_service_until=datetime(2026, 9, 14),
        installation_date=datetime(2022, 9, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230028")],
            station_id=s83),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 14), paid_service_until=datetime(2026, 9, 14),
        installation_date=datetime(2022, 9, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "U2930255")],
            station_id=s83),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 14), paid_service_until=datetime(2026, 9, 14),
        installation_date=datetime(2022, 9, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510001")],
            station_id=s83),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 14), paid_service_until=datetime(2026, 9, 14),
        installation_date=datetime(2022, 9, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L42491")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 5, 15), paid_service_until=None,
        installation_date=datetime(2016, 5, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "T15342")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 8, 4), paid_service_until=None,
        installation_date=datetime(2021, 8, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2011, 11, 2), paid_service_until=None,
        installation_date=datetime(2009, 11, 2))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850635")],
            station_id=s83),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 14), paid_service_until=datetime(2026, 9, 14),
        installation_date=datetime(2022, 9, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s83),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(1900, 1, 2), paid_service_until=datetime(2026, 9, 14),
        installation_date=datetime(2022, 9, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2011, 11, 2), paid_service_until=None,
        installation_date=datetime(2009, 11, 2))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IP8361, "0002D119BA8F")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 10, 14), paid_service_until=None,
        installation_date=datetime(2014, 10, 14))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8367, "0002D13C22DD")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 1, 28), paid_service_until=None,
        installation_date=datetime(2016, 1, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_MS9321_EHV, "0002D19C9EA0")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 4, 12), paid_service_until=None,
        installation_date=datetime(2022, 4, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS_WR21, "0002D19C9EA0")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 4, 12), paid_service_until=None,
        installation_date=datetime(2022, 4, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12v__2_2Ah, "")],
            station_id=s83),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 18), paid_service_until=None,
        installation_date=datetime(2018, 7, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3550048")],
            station_id=s85),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 13), paid_service_until=datetime(2026, 9, 13),
        installation_date=datetime(2022, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230021")],
            station_id=s85),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 13), paid_service_until=datetime(2026, 9, 13),
        installation_date=datetime(2022, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "U2930273")],
            station_id=s85),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 13), paid_service_until=datetime(2026, 9, 13),
        installation_date=datetime(2022, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510003")],
            station_id=s85),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 13), paid_service_until=datetime(2026, 9, 13),
        installation_date=datetime(2022, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "M47338")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 4), paid_service_until=None,
        installation_date=datetime(2017, 7, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P36183")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 9), paid_service_until=None,
        installation_date=datetime(2018, 11, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2011, 11, 24), paid_service_until=None,
        installation_date=datetime(2009, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2851131")],
            station_id=s85),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 13), paid_service_until=datetime(2026, 9, 13),
        installation_date=datetime(2022, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s85),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 13), paid_service_until=datetime(2026, 9, 13),
        installation_date=datetime(2022, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2011, 11, 24), paid_service_until=None,
        installation_date=datetime(2009, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U2750335")],
            station_id=s85),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 13), paid_service_until=datetime(2026, 9, 13),
        installation_date=datetime(2022, 9, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8367A, "0002D14E258C")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 12, 21), paid_service_until=None,
        installation_date=datetime(2016, 12, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__2_2Ah, "")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 18), paid_service_until=None,
        installation_date=datetime(2017, 7, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS, "740482.0")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 9), paid_service_until=None,
        installation_date=datetime(2018, 11, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Návestidlo_4x, "")],
            station_id=s85),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 11, 26), paid_service_until=None,
        installation_date=datetime(2019, 11, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3540531")],
            station_id=s88),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230006")],
            station_id=s88),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "U2930234")],
            station_id=s88),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510386")],
            station_id=s88),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "R25231")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 10, 21), paid_service_until=None,
        installation_date=datetime(2019, 10, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N08312")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 12), paid_service_until=None,
        installation_date=datetime(2017, 7, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 10, 21), paid_service_until=None,
        installation_date=datetime(2010, 10, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2851133")],
            station_id=s88),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s88),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "F3530011")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 10, 21), paid_service_until=None,
        installation_date=datetime(2010, 10, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "S3230203")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 8, 13), paid_service_until=None,
        installation_date=datetime(2020, 8, 13))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8367A, "0002D14E258D")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 12, 21), paid_service_until=None,
        installation_date=datetime(2016, 12, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__2_2Ah, "")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 18), paid_service_until=None,
        installation_date=datetime(2017, 7, 18))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS, "RF3022130036494")],
            station_id=s88),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 10, 6), paid_service_until=datetime(2026, 10, 6),
        installation_date=datetime(2022, 10, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Návestidlo_4x, "")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 9), paid_service_until=None,
        installation_date=datetime(2017, 12, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Nport_5130, "4087.0")],
            station_id=s88),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 10, 21), paid_service_until=None,
        installation_date=datetime(2010, 10, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4450117")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3620016")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "N3130006")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3240004")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37492")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT536, "N4450520")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8360, "0002D16483AB")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS_H685, "060410156A0011E5")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(SOLAR, "")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(SOLAR, "")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU6V__200Ah, "")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU6V__200Ah, "")],
            station_id=s89),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3610509")],
            station_id=s86),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4240007")],
            station_id=s86),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "U3440772")],
            station_id=s86),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510029")],
            station_id=s86),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "S20472")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 20), paid_service_until=None,
        installation_date=datetime(2020, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L37508")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 1, 12), paid_service_until=None,
        installation_date=datetime(2015, 1, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "K33502")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 1, 12), paid_service_until=None,
        installation_date=datetime(2015, 1, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2851125")],
            station_id=s86),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s86),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "K3750008")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 1, 12), paid_service_until=None,
        installation_date=datetime(2015, 1, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "K3740001")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 1, 12), paid_service_until=None,
        installation_date=datetime(2015, 1, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU_12V_2_2Ah, "")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 1, 12), paid_service_until=None,
        installation_date=datetime(2015, 1, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Návestidlo_2x, "")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 1, 12), paid_service_until=None,
        installation_date=datetime(2015, 1, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(NPort_5110, "TADFC1016847")],
            station_id=s86),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 1, 12), paid_service_until=None,
        installation_date=datetime(2015, 1, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4450096")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N4450096")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU703, "N3130005")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3250007")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N37493")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "N19209")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT536, "N4450521")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8360, "0002D16483AA")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS_H685, "060410156A001201")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(SOLAR, "")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(SOLAR, "")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU6V__200Ah, "")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU6V__200Ah, "")],
            station_id=s87),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 15), paid_service_until=None,
        installation_date=datetime(2017, 12, 15))

    # povazska bystrica ssud5

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3610499")],
            station_id=s45),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230010")],
            station_id=s45),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U3440763")],
            station_id=s45),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510026")],
            station_id=s45),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "U31316")],
            station_id=s45),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 11, 9), paid_service_until=None,
        installation_date=datetime(2022, 11, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB10, "P36197")],
            station_id=s45),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 6), paid_service_until=None,
        installation_date=datetime(2018, 11, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s45),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 20), paid_service_until=None,
        installation_date=datetime(2011, 12, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850623")],
            station_id=s45),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s45),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "U3010399")],
            station_id=s45),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__2_2Ah, "")],
            station_id=s45),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 20), paid_service_until=None,
        installation_date=datetime(2017, 7, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Nport_5232I_T, "TAGGB1140804")],
            station_id=s45),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 4), paid_service_until=None,
        installation_date=datetime(2017, 12, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3610508")],
            station_id=s48),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230026")],
            station_id=s48),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U3440771")],
            station_id=s48),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2510021")],
            station_id=s48),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "L42439")],
            station_id=s48),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 5, 12), paid_service_until=None,
        installation_date=datetime(2016, 5, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "R42340")],
            station_id=s48),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 9, 4), paid_service_until=None,
        installation_date=datetime(2020, 9, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "S07119")],
            station_id=s48),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 24), paid_service_until=None,
        installation_date=datetime(2020, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850626")],
            station_id=s48),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s48),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "")],
            station_id=s48),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 5, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "U2760290")],
            station_id=s48),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 22), paid_service_until=datetime(2026, 9, 22),
        installation_date=datetime(2022, 9, 22))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Nport_5430I, "")],
            station_id=s48),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2016, 5, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3620222")],
            station_id=s49),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=datetime(2026, 9, 28),
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "U3470015")],
            station_id=s49),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=datetime(2026, 9, 28),
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U3550520")],
            station_id=s49),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=datetime(2026, 9, 28),
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U3540410")],
            station_id=s49),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=datetime(2026, 9, 28),
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "M01419")],
            station_id=s49),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 11, 4), paid_service_until=None,
        installation_date=datetime(2016, 11, 4))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P41138")],
            station_id=s49),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 6), paid_service_until=None,
        installation_date=datetime(2018, 11, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "F38220")],
            station_id=s49),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 11, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2851127")],
            station_id=s49),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=datetime(2026, 9, 28),
        installation_date=datetime(2022, 9, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s49),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 11, 26), paid_service_until=None,
        installation_date=datetime(2021, 11, 26))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "S2950325")],
            station_id=s49),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 7, 28), paid_service_until=None,
        installation_date=datetime(2020, 7, 28))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "S4610845")],
            station_id=s49),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 24), paid_service_until=None,
        installation_date=datetime(2020, 11, 24))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Nport_5130, "TBAEE1105175")],
            station_id=s49),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 12, 15), paid_service_until=None,
        installation_date=datetime(2021, 12, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "M4020532")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "M0430010")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "M3040013")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211, "M114012")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSCVIS, "")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DST111, "M151049")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT520, "M2740541")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s50),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "M4020536")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "M0440003")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "M3050022")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211, "M212003")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSCVIS, "")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DST111__smer_BA_, "L533024")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211, "N392004")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=datetime(2019, 11, 20),
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DST111__smer_ZA_, "N271020")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=datetime(2019, 11, 20),
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT520, "M3850306")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s52),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 12), paid_service_until=datetime(2018, 10, 12),
        installation_date=datetime(2016, 10, 12))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "U3410457")],
            station_id=s46),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "T4230017")],
            station_id=s46),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "U2930257")],
            station_id=s46),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "U2330614")],
            station_id=s46),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB5, "U37547")],
            station_id=s46),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 11, 9), paid_service_until=None,
        installation_date=datetime(2022, 11, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N08327")],
            station_id=s46),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 30), paid_service_until=None,
        installation_date=datetime(2017, 6, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "")],
            station_id=s46),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 20), paid_service_until=None,
        installation_date=datetime(2011, 12, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "U2850627")],
            station_id=s46),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTR503A, "")],
            station_id=s46),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "U3020547")],
            station_id=s46),
        component_warranty_id=inv_id,
        components_warranty_source=ComponentWarrantySource.INVESTMENT_CONTRACT,
        component_warranty_until=datetime(2026, 9, 6), paid_service_until=datetime(2026, 9, 6),
        installation_date=datetime(2022, 9, 6))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "M4450499")],
            station_id=s46),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 11, 9), paid_service_until=None,
        installation_date=datetime(2016, 11, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Nport_5230, "")],
            station_id=s46),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2011, 12, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "N4430515")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "N3440014")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N3020011")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "N3010045")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511BB2, "L37513")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WXT536, "N4340964")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(Kamera_IB8360, "0002D16483A9")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(GPRS_H685, "660420156A002AB3")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 11, 20), paid_service_until=None,
        installation_date=datetime(2017, 11, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__75Ah, "")],
            station_id=s47),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2024, 3, 15), paid_service_until=None,
        installation_date=datetime(2022, 3, 15))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "P2620186")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "P0440005")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "N4750024")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "P2413085")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P06469")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "P06486")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211_smer_BA_, "P027011")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "P2540866")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "P2450280")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G3, "N43406")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P2610202")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 8, 30), paid_service_until=datetime(2020, 8, 30),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s51),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 8, 30))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(RWS200, "P3810561")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DMU703, "P3520013")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PMU701, "P3450122")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRI701, "P3340600")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P28109")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB5, "N45318")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DSC211_smer_BA_, "P224028")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(HMP155, "P3640840")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(PWD12, "P3810648")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G3, "N47407")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(WMT700, "P3710890")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(AKU12V__26Ah, "")],
            station_id=s44),
        component_warranty_id=None,
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 10, 3), paid_service_until=datetime(2020, 10, 3),
        installation_date=datetime(2018, 10, 3))

