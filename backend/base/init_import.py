from datetime import datetime
from time import sleep

from assetmanager.application.model.schema import AssetCategoryNewSchema, AssetNewSchema, AssetIdSchema
from assetmanager.domain.model.asset_telemetry import AssetTelemetry, AssetTelemetryType, AssetTelemetryValue
from assetmanager.infrastructure import rest_router
from base import main
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from roadsegmentmanager.infrastructure import rest_router as rs_router
from stationmanager.application.assigned_component.model.schema import AssignedComponentNewSchema
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


def import_assets():
    print("zacinam import assetov")
    for i in rest_router.get_asset_categories():
        if i.name == default_category:
            print("import skip")
            return
    sleep(10)
    cat_id = rest_router.create_new_category(
        AssetCategoryNewSchema(name=default_category, description="zakladne komponenty auto-import")).id
    hmp155 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="HMP155 Teplomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    wxt536 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WXT536 Multisenzor", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.AIR_PRESSURE, value=AssetTelemetryValue.HECTO_PASCAL),
        AssetTelemetry(type=AssetTelemetryType.AIR_HUMIDITY, value=AssetTelemetryValue.PERCENTAGE)]))

    wxt520 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WXT520 Multisenzor", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.AIR_PRESSURE, value=AssetTelemetryValue.HECTO_PASCAL),
        AssetTelemetry(type=AssetTelemetryType.AIR_HUMIDITY, value=AssetTelemetryValue.PERCENTAGE)]))

    dts12g = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DTS12G Zemny teplomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    wmt700 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WMT700 Vetromer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
    ]))
    pwd12 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="PWD12 Senzor počasia", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.VISIBILITY, value=AssetTelemetryValue.METERS),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),

    ]))
    dst111 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DST 111 Senzor teploty vozovky", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    dsc211 = rest_router.create_new_asset(
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

    dsc111 = rest_router.create_new_asset(
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
    drd11 = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DRD11 Zrážkomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND)]))
    DR11SYS = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DR11SYS", telemetry=[]))
    AKU12V_2_2ah = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="AKU12V, 2,2Ah", telemetry=[]))
    AKU12V_26ah = rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="AKU12V, 26Ah", telemetry=[]))
    dmu703 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DMU703 Centralna jednotka", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.DEW_POINT_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))
    pmu701 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="PMU701 Power management jednotka", telemetry=[]))
    rws200 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="RWS200 Modul stanice", telemetry=[]))
    dxs422 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DXS422 Modul stanice", telemetry=[]))
    dri701 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRI701", telemetry=[]))
    drs511bb5 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRS511BB5", telemetry=[]))
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
    DTS12G = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DTS12G", telemetry=[]))
    PTB110 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="PTB110", telemetry=[]))
    DTR503A = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DTR503A", telemetry=[]))
    HMP155E = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="HMP155E", telemetry=[]))
    HMP155 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="HMP155", telemetry=[]))
    AKU26 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="AKU26", telemetry=[]))
    CMP6 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="CMP6", telemetry=[]))
    DRA411 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRA411", telemetry=[]))
    moxa_nport_5232 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5232", telemetry=[]))
    moxa_nport_5150 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 5150", telemetry=[]))
    moxa_nport_6150 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Moxa Nport 6150", telemetry=[]))
    TCC_120 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="TCC-120", telemetry=[]))
    RS232_RS485 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="RS232/RS485", telemetry=[]))

    DRD11 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DRD11", telemetry=[]))
    Kamera_IB8367A = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB8367A", telemetry=[]))
    Kamera_IB9387_EHT_A = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="Kamera IB9387-EHT-A", telemetry=[]))

    station_service = main.runner.get(StationService)
    print("zacinam import stanic")
    for i in rs_router.get_all():
        if i.name == import_rs_1:
            print("import skip")
            return

    rs_id_beharovce = rs_router.create_road_segment(RoadSegmentNewSchema(name="Behárovce", ssud="SSUD 10"))
    levoca = station_service.create_station(
        StationNewSchema(name="Levoča", road_segment_id=rs_id_beharovce, km_of_road=352,
                         km_of_road_note="",
                         latitude=49.00838, longitude=20.59656, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "N4330501"), _InstallAsset(dmu703, "N3620001"),
                       _InstallAsset(pmu701, "N3010009"),
                       _InstallAsset(dri701, "N3010050"), _InstallAsset(drs511bb5, "N37435"),
                       _InstallAsset(DRS511AB10, "N36166"),
                       _InstallAsset(DTS12G, "N19206"), _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "N4010228"), _InstallAsset(wmt700, "N4250684"),
                       _InstallAsset(pwd12, "N3740590"), _InstallAsset(AKU26)
                       ],
            station_id=levoca),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 11, 21))

    sibenik_zp = station_service.create_station(
        StationNewSchema(name="Šibenik - Západný portál", road_segment_id=rs_id_beharovce, km_of_road=353,
                         km_of_road_note="",
                         latitude=49.01005, longitude=20.60950, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "L3610261"), _InstallAsset(dmu703, "K4910016"),
                       _InstallAsset(pmu701, "L3150008"),
                       _InstallAsset(dri701, "L3020006"),
                       _InstallAsset(DRS511AB2, "L31312"),
                       _InstallAsset(DTS12G, "K53110"), _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "L2930750"), _InstallAsset(wmt700, "L3620825"),
                       _InstallAsset(AKU26)
                       ],
            station_id=sibenik_zp),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(drs511bb5, "P06476"),
                       ],
            station_id=sibenik_zp),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 6, 21))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(pwd12, "N4040536")
                       ],
            station_id=sibenik_zp),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 10, 26))

    sibenik_vp = station_service.create_station(
        StationNewSchema(name="Šibenik - Východný portál", road_segment_id=rs_id_beharovce, km_of_road=354,
                         km_of_road_note="",
                         latitude=49.00855, longitude=20.62287, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "L3610262"), _InstallAsset(dmu703, "K5010005"),
                       _InstallAsset(pmu701, "L3150024"),
                       _InstallAsset(dri701, "L3020017"),
                       _InstallAsset(DRS511AB2, "L31346"),
                       _InstallAsset(DTS12G, "K53108"), _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "L3630480"), _InstallAsset(wmt700, "L3620832"),
                       _InstallAsset(AKU26)
                       ],
            station_id=sibenik_vp),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2015, 11, 18))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(drs511bb5, "P01255"),
                       ],
            station_id=sibenik_vp),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2018, 6, 26))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(pwd12, "N4040535")
                       ],
            station_id=sibenik_vp),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None,
        installation_date=datetime(2017, 10, 26))

    spis_hrbov = station_service.create_station(
        StationNewSchema(name="Spišský Hrhov", road_segment_id=rs_id_beharovce, km_of_road=355,
                         km_of_road_note="",
                         latitude=49.00649, longitude=20.63338, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "M3940500"), _InstallAsset(dmu703, "M0750002"),
                       _InstallAsset(pmu701, "M3050024"),
                       _InstallAsset(dri701, "M3020013"),
                       _InstallAsset(DRS511AB2, "M33213"),
                       _InstallAsset(drs511bb5, "L37537"),
                       _InstallAsset(DTS12G, "L53204"), _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "M3810827"),
                       _InstallAsset(pwd12, "M3740997"),
                       _InstallAsset(AKU26)
                       ],
            station_id=spis_hrbov), components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2016, 10, 31))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(wmt700, "P2340415"),
                       ],
            station_id=spis_hrbov),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2018, 6, 21))

    dolany = station_service.create_station(
        StationNewSchema(name="Doľany", road_segment_id=rs_id_beharovce, km_of_road=356.5,
                         km_of_road_note="",
                         latitude=49.00731, longitude=20.65201, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "N4441181"), _InstallAsset(dmu703, ), _InstallAsset(pmu701, ),
                       _InstallAsset(dri701, ),
                       _InstallAsset(drs511bb5, "N36131"),
                       _InstallAsset(DRS511AB2, "N37476"),
                       _InstallAsset(DTS12G, "N08105"), _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "N4220410"),
                       _InstallAsset(wmt700, "N4250683"),
                       _InstallAsset(pwd12, "N4250421"),
                       _InstallAsset(AKU26)
                       ],
            station_id=dolany),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2017, 12, 12))

    klckov = station_service.create_station(
        StationNewSchema(name="Klčov", road_segment_id=rs_id_beharovce, km_of_road=357.5,
                         km_of_road_note="",
                         latitude=49.00919, longitude=20.66240, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "N4410245"), _InstallAsset(dmu703, "N3540003"),
                       _InstallAsset(pmu701, "N2950005"),
                       _InstallAsset(dri701, "N3010017"),
                       _InstallAsset(DRS511BB10, "N20182"),
                       _InstallAsset(DRS511AB2, "N37477"),
                       _InstallAsset(DTS12G, "N08106"), _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "N4140460"),
                       _InstallAsset(wmt700, "N4410493"),
                       _InstallAsset(pwd12, "N4250419"),
                       _InstallAsset(AKU26)
                       ],
            station_id=klckov),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2017, 12, 11))

    nemesany = station_service.create_station(
        StationNewSchema(name="Nemešany", road_segment_id=rs_id_beharovce, km_of_road=358.5,
                         km_of_road_note="",
                         latitude=49.00805, longitude=20.67606, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "N4441026"), _InstallAsset(dmu703, "N3630002"),
                       _InstallAsset(pmu701, "N302005"),
                       _InstallAsset(dri701, "N3240007"),
                       _InstallAsset(DRS511BB10, "N41446"),
                       _InstallAsset(DTS12G, "S47305"), _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "N4140458"),
                       _InstallAsset(wmt700, "N4411102"),
                       _InstallAsset(pwd12, "N4250422"),
                       _InstallAsset(AKU26)
                       ],
            station_id=nemesany),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2017, 12, 13))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "T01370"),
                       ],
            station_id=nemesany),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2021, 5, 15))

    jablonov = station_service.create_station(
        StationNewSchema(name="Jablonov", road_segment_id=rs_id_beharovce, km_of_road=361,
                         km_of_road_note="",
                         latitude=49.00778, longitude=20.71240, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3550461"), _InstallAsset(dmu703, "T4230035"),
                       _InstallAsset(pmu701, "U3440781"),
                       _InstallAsset(dri701, "U2510008"),

                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "U3030833"),

                       ],
            station_id=jablonov),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(drs511bb5, "P41165"),

                       ],
            station_id=jablonov),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2018, 12, 12))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "L37503"),
                       _InstallAsset(DTS12G, ),
                       _InstallAsset(pwd12, "P4820411"),
                       _InstallAsset(AKU26),

                       ],
            station_id=jablonov),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(wmt700, "S4610844"),

                       ],
            station_id=jablonov),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2020, 11, 12))

    studenec = station_service.create_station(
        StationNewSchema(name="Studenec", road_segment_id=rs_id_beharovce, km_of_road=365,
                         km_of_road_note="",
                         latitude=49.00745, longitude=20.76677, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3540576"), _InstallAsset(dmu703, "T4230005"),
                       _InstallAsset(pmu701, "U2930264"),
                       _InstallAsset(dri701, "U2751127"),

                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "U2850629"),

                       ],
            station_id=studenec),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 28), paid_service_until=None,
        installation_date=datetime(2022, 9, 28))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "P41139"), _InstallAsset(DRS511AB2, "P41121"),

                       ],
            station_id=studenec),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2018, 11, 19))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DTS12G, ),
                _InstallAsset(pwd12, ),
                _InstallAsset(AKU26),
                _InstallAsset(moxa_nport_5232),

            ],
            station_id=studenec),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2010, 6, 3))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(wmt700, "R2940184"),

                       ],
            station_id=studenec),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2020, 11, 12))

    bijatovce = station_service.create_station(
        StationNewSchema(name="Bijacovce", road_segment_id=rs_id_beharovce, km_of_road=367,
                         km_of_road_note="",
                         latitude=49.00712, longitude=20.79333, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "K4930001"), _InstallAsset(dmu703, "H3920011"),
                       _InstallAsset(pmu701, "K4120026"),
                       _InstallAsset(dri701, "K3320008"),
                       _InstallAsset(DRS511AB2, "K43335"), _InstallAsset(DRS511AB2, "H34243 (BB5)"),
                       _InstallAsset(DTS12G, "K25408"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "K4620036"),
                       _InstallAsset(pwd12, ),
                       _InstallAsset(AKU26),
                       _InstallAsset(HMP155E, "U2850629"),
                       ],
            station_id=bijatovce),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2014, 12, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(wmt700, "R4331042"),
                       ],
            station_id=bijatovce),
        components_warranty_source=ComponentWarrantySource.NAN,
        component_warranty_until=None, paid_service_until=None, installation_date=datetime(2019, 11, 19))

    beharovce = station_service.create_station(
        StationNewSchema(name="Behárovce", road_segment_id=rs_id_beharovce, km_of_road=369,
                         km_of_road_note="",
                         latitude=49.00954, longitude=20.82380, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3620223"), _InstallAsset(dmu703, "T4230034"),
                       _InstallAsset(pmu701, ),
                       _InstallAsset(dri701, ),
                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, ),
                       _InstallAsset(wmt700, "140487"),
                       ],
            station_id=beharovce),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 12, 19), paid_service_until=datetime(2026, 12, 19),
        installation_date=datetime(2022, 12, 19))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "N08311")
                       ],
            station_id=beharovce),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 7, 4), paid_service_until=None, installation_date=datetime(2017, 7, 4))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DTS12G, "S07104"),
            ],
            station_id=beharovce),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 8, 5), paid_service_until=None, installation_date=datetime(2021, 5, 8))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(CMP6, "140487"),
                       _InstallAsset(DRA411, "J505035"),
                       _InstallAsset(moxa_nport_5150, ),

                       ],
            station_id=beharovce),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "P301021"),
                       ],
            station_id=beharovce),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 11, 19), paid_service_until=None,
        installation_date=datetime(2018, 11, 19))

    korytne = station_service.create_station(
        StationNewSchema(name="Korytné", road_segment_id=rs_id_beharovce, km_of_road=370,
                         km_of_road_note="",
                         latitude=49.00929, longitude=20.83533, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3420885"), _InstallAsset(dmu703, "T4230023"),
                       _InstallAsset(pmu701, "U2930248"),
                       _InstallAsset(dri701, "U2751122"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "U2851130"),
                       ],
            station_id=korytne),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(drs511bb5, "P41163"),
                _InstallAsset(wmt700, ),
            ],
            station_id=korytne),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 11, 19), paid_service_until=None,
        installation_date=datetime(2018, 11, 19))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, "S07101"),

                       ],
            station_id=korytne),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 5, 8), paid_service_until=None, installation_date=datetime(2021, 5, 8))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, ), _InstallAsset(moxa_nport_5232, )
                       ],
            station_id=korytne),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2015, 1, 10), paid_service_until=None,
        installation_date=datetime(2013, 1, 10))

    branisko_zp = station_service.create_station(
        StationNewSchema(name="Branisko - Západný portál", road_segment_id=rs_id_beharovce, km_of_road=370.5,
                         km_of_road_note="",
                         latitude=49.01023, longitude=20.84231, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3550406"), _InstallAsset(dmu703, "T4230016"),
                       _InstallAsset(pmu701, "U3440767"),
                       _InstallAsset(dri701, "U2510009"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "U2850637"),
                       _InstallAsset(wmt700, "U2920500"),
                       ],
            station_id=branisko_zp),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 20), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 20))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRS511AB2, "S07108")
                       ],
            station_id=branisko_zp),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 5, 8), paid_service_until=None, installation_date=datetime(2021, 5, 8))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB10, ),
                _InstallAsset(DTS12G, ),
                _InstallAsset(pwd12, ),
                _InstallAsset(moxa_nport_5232, ),
            ],
            station_id=branisko_zp),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 14), paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    branisko_vp = station_service.create_station(
        StationNewSchema(name="Branisko - Východný portál", road_segment_id=rs_id_beharovce, km_of_road=375.5,
                         km_of_road_note="",
                         latitude=48.99639, longitude=20.90643, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3410445"), _InstallAsset(dmu703, "U0810001"),
                       _InstallAsset(pmu701, "U2930278"),
                       _InstallAsset(dri701, "U2330628"),
                       _InstallAsset(DRS511AB10, "T47210"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "U2850625"),
                       _InstallAsset(wmt700, "U2930188"),
                       ],
            station_id=branisko_vp),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 20),
        installation_date=datetime(2022, 9, 21))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, ),
                _InstallAsset(DTS12G, ),
                _InstallAsset(pwd12, ),
                _InstallAsset(moxa_nport_5232, ),
            ],
            station_id=branisko_vp),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 14), paid_service_until=None,
        installation_date=datetime(2015, 10, 14))

    siroke = station_service.create_station(
        StationNewSchema(name="Široké", road_segment_id=rs_id_beharovce, km_of_road=376,
                         km_of_road_note="",
                         latitude=48.99611, longitude=20.91203, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3550374"), _InstallAsset(dmu703, "T4230032"),
                       _InstallAsset(pmu701, "U2910418"),
                       _InstallAsset(dri701, "U2510028"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155, "H1040003"),
                       ],
            station_id=siroke),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 21), paid_service_until=datetime(2026, 9, 21),
        installation_date=datetime(2022, 9, 21))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "R42339"),
            ],
            station_id=siroke),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 9, 8), paid_service_until=None, installation_date=datetime(2020, 9, 8))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "S44354"),
            ],
            station_id=siroke),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 25), paid_service_until=None,
        installation_date=datetime(2020, 11, 25))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DTS12G, ),

                       ],
            station_id=siroke),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 12), paid_service_until=None,
        installation_date=datetime(2011, 12, 12))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DRD11, "R343019"),
                       ],
            station_id=siroke),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2021, 11, 19), paid_service_until=None,
        installation_date=datetime(2019, 11, 19))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(wmt700, "N4740435"),
                       ],
            station_id=siroke),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 12, 10), paid_service_until=None,
        installation_date=datetime(2017, 12, 10))

    siroke_zarez = station_service.create_station(
        StationNewSchema(name="Široké zárez", road_segment_id=rs_id_beharovce, km_of_road=377.5,
                         km_of_road_note="",
                         latitude=48.99623, longitude=20.9177, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(DR11SYS, ),
                       _InstallAsset(dxs422, ),
                       _InstallAsset(dsc111, ),
                       _InstallAsset(dst111, ),
                       _InstallAsset(dts12g, ),
                       _InstallAsset(DRA411, ),
                       _InstallAsset(wxt520, ),
                       ],
            station_id=siroke_zarez),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 13), paid_service_until=None,
        installation_date=datetime(2011, 12, 13))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(AKU12V_2_2ah, ),
            ],
            station_id=siroke_zarez),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 20), paid_service_until=None,
        installation_date=datetime(2017, 6, 20))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(RS232_RS485, "IAA9415425"),
                _InstallAsset(moxa_nport_5150, "TAFFC1000286"),
            ],
            station_id=siroke_zarez),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 1, 1), paid_service_until=None, installation_date=datetime(2016, 1, 1))

    siroke_zjazd = station_service.create_station(
        StationNewSchema(name="Široké zjazd", road_segment_id=rs_id_beharovce, km_of_road=378.5,
                         km_of_road_note="",
                         latitude=49.00925, longitude=20.93921, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "K4930002"), _InstallAsset(dmu703, "H3820001"),
                       _InstallAsset(pmu701, "K4120004"),
                       _InstallAsset(dri701, "K3320020"),
                       _InstallAsset(DTS12G, "K25409"),
                       _InstallAsset(HMP155, "K4620040"),
                       _InstallAsset(DTR503A, ),
                       _InstallAsset(pwd12, "K4630010"),
                       _InstallAsset(wmt700, "K3510011"),
                       _InstallAsset(AKU12V_26ah, ),
                       _InstallAsset(moxa_nport_6150, "TAECB1015709"),
                       ],
            station_id=siroke_zjazd),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "T24317"),
            ],
            station_id=siroke_zjazd),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 12, 9), paid_service_until=None,
        installation_date=datetime(2021, 12, 9))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511BB5, "M18370"),
            ],
            station_id=siroke_zjazd),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 30), paid_service_until=None,
        installation_date=datetime(2017, 6, 30))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(moxa_nport_6150, "TADJC1094053"),
            ],
            station_id=siroke_zjazd),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 4, 14), paid_service_until=None,
        installation_date=datetime(2021, 4, 14))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(TCC_120, "TAEEC1026995"),
            ],
            station_id=siroke_zjazd),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 7, 9), paid_service_until=None, installation_date=datetime(2015, 7, 9))

    fricovce2 = station_service.create_station(
        StationNewSchema(name="Fričovce2", road_segment_id=rs_id_beharovce, km_of_road=381,
                         km_of_road_note="",
                         latitude=49.01828, longitude=20.96831, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3420857"),
                       _InstallAsset(dmu703, "T4240008"),
                       _InstallAsset(pmu701, "U2930230"),
                       _InstallAsset(dri701, "U2751123"),
                       _InstallAsset(HMP155, "U2850633"),
                       _InstallAsset(DTR503A, ),
                       _InstallAsset(wmt700, "U4310611"),
                       ],
            station_id=fricovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "L09115"),
            ],
            station_id=fricovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 14), paid_service_until=None,
        installation_date=datetime(2015, 10, 14))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511BB5, "L51574"),
            ],
            station_id=fricovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 5, 25), paid_service_until=None,
        installation_date=datetime(2016, 5, 25))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DTS12G, ),
                _InstallAsset(DRD11, ),
                _InstallAsset(moxa_nport_5150, ),
            ],
            station_id=fricovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 12, 12), paid_service_until=None,
        installation_date=datetime(2011, 12, 12))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(CMP6, "140509"),
                _InstallAsset(DRA411, " J505025"),
            ],
            station_id=fricovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2016, 12, 19), paid_service_until=None,
        installation_date=datetime(2014, 12, 19))

    fricovce1 = station_service.create_station(
        StationNewSchema(name="Fričovce1", road_segment_id=rs_id_beharovce, km_of_road=380,
                         km_of_road_note="",
                         latitude=49.01501, longitude=20.95292, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "U3550529"),
                       _InstallAsset(dmu703, "T4230040"),
                       _InstallAsset(pmu701, "U3440761"),
                       _InstallAsset(dri701, "U2510015"),
                       _InstallAsset(HMP155, "U2850632"),
                       _InstallAsset(DTR503A, ),
                       ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2026, 9, 27), paid_service_until=datetime(2026, 9, 27),
        installation_date=datetime(2022, 9, 27))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "L40113"),
            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2017, 10, 28), paid_service_until=None,
        installation_date=datetime(2015, 10, 28))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511BB, "S20471"),
            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 12), paid_service_until=None,
        installation_date=datetime(2020, 11, 12))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DTS12G, ),
                _InstallAsset(PTB110, ),
            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2013, 11, 25), paid_service_until=None,
        installation_date=datetime(2011, 11, 25))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(pwd12, "T2930287"),
            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2023, 8, 16), paid_service_until=None,
        installation_date=datetime(2021, 8, 16))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(AKU12V_2_2ah, ),
            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 20), paid_service_until=None,
        installation_date=datetime(2017, 6, 20))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(wmt700, "N2620139"),

            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2019, 6, 29), paid_service_until=None,
        installation_date=datetime(2017, 6, 29))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(Kamera_IB8367A, "0002D16DC1CF"),

            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 21), paid_service_until=None,
        installation_date=datetime(2018, 6, 21))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(Kamera_IB9387_EHT_A, "0002D1A7E9A0"),

            ],
            station_id=fricovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2027, 3, 14), paid_service_until=datetime(2027, 3, 14),
        installation_date=datetime(2023, 3, 14))

    hendrichovce_2 = station_service.create_station(
        StationNewSchema(name="Hendrichovce 2", road_segment_id=rs_id_beharovce, km_of_road=383.5,
                         km_of_road_note="",
                         latitude=49.02634, longitude=20.99610, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "L2940730"),
                       _InstallAsset(dmu703, "K4630018"),
                       _InstallAsset(pmu701, "L1640017"),
                       _InstallAsset(dri701, "L2830022"),
                       _InstallAsset(DRS511BB10, "L28501"),
                       _InstallAsset(DTS12G, ),
                       _InstallAsset(HMP155, "L2930746"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(pwd12, "L2720556"),

                       _InstallAsset(AKU12V_26ah, ),
                       ],
            station_id=hendrichovce_2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "M31360"),
                _InstallAsset(wmt700, "L5050245"),
            ],
            station_id=hendrichovce_2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 1, 11))

    bertotovce1 = station_service.create_station(
        StationNewSchema(name="Bertotovce 1", road_segment_id=rs_id_beharovce, km_of_road=385.5,
                         km_of_road_note="",
                         latitude=49.02622, longitude=21.02226, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "L2940731"),
                       _InstallAsset(dmu703, "K4630014"),
                       _InstallAsset(pmu701, "L1960026"),
                       _InstallAsset(dri701, "L2830020"),
                       _InstallAsset(DTS12G, "L06510"),
                       _InstallAsset(HMP155, "L0950286"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(pwd12, "L2720557"),
                       _InstallAsset(AKU12V_26ah, ),
                       ],
            station_id=bertotovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511BB10, "M33244"),
            ],
            station_id=bertotovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 11, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "M31358"),
            ],
            station_id=bertotovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(wmt700, "M3740987"),
            ],
            station_id=bertotovce1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 20))

    bertotovce2 = station_service.create_station(
        StationNewSchema(name="Bertotovce 2", road_segment_id=rs_id_beharovce, km_of_road=386.5,
                         km_of_road_note="",
                         latitude=49.02012, longitude=21.03514, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "L2940732"),
                       _InstallAsset(dmu703, "K4630017"),
                       _InstallAsset(pmu701, "L2750006"),
                       _InstallAsset(dri701, "L3020021"),
                       _InstallAsset(DTS12G, "L06506"),
                       _InstallAsset(HMP155, "L0510393"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(pwd12, "K3530008"),
                       _InstallAsset(AKU12V_26ah, ),
                       ],
            station_id=bertotovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511BB10, "N36130"),
            ],
            station_id=bertotovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2017, 10, 9))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "M31359"),
            ],
            station_id=bertotovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(wmt700, "P2340414"),
            ],
            station_id=bertotovce2),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 21), paid_service_until=None,
        installation_date=datetime(2018, 6, 21))

    chminany = station_service.create_station(
        StationNewSchema(name="Chmiňany", road_segment_id=rs_id_beharovce, km_of_road=389.5,
                         km_of_road_note="",
                         latitude=49.00072, longitude=21.10239, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "L2940733"),
                       _InstallAsset(dmu703, "K4630019"),
                       _InstallAsset(pmu701, "L1640024"),
                       _InstallAsset(dri701, "L2830018"),
                       _InstallAsset(DRS511BB10, "K40501"),
                       _InstallAsset(DTS12G, "L06507"),
                       _InstallAsset(HMP155, "L0510394"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(pwd12, "L2720555"),
                       _InstallAsset(AKU12V_26ah, ),
                       ],
            station_id=chminany),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "M31371"),
            ],
            station_id=chminany),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2018, 10, 31), paid_service_until=None,
        installation_date=datetime(2016, 9, 16))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(wmt700, "P2340413"),
            ],
            station_id=chminany),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 21), paid_service_until=None,
        installation_date=datetime(2018, 6, 21))

    chminianska_nova_ves = station_service.create_station(
        StationNewSchema(name="Chminianska Nová Ves", road_segment_id=rs_id_beharovce, km_of_road=392.5,
                         km_of_road_note="",
                         latitude=48.57754, longitude=18.83620, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "L2940734"),
                       _InstallAsset(dmu703, "K4640017"),
                       _InstallAsset(pmu701, "L2750025"),
                       _InstallAsset(dri701, "L2830025"),
                       _InstallAsset(DTS12G, "K48325"),
                       _InstallAsset(HMP155, "L0550657"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(pwd12, "L2920497"),
                       _InstallAsset(AKU12V_26ah, ),
                       ],
            station_id=chminianska_nova_ves),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2015, 12, 31))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511BB10, "S37195"),
            ],
            station_id=chminianska_nova_ves),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2022, 11, 30), paid_service_until=None,
        installation_date=datetime(2020, 11, 13))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(DRS511AB2, "L40136"),
            ],
            station_id=chminianska_nova_ves),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 12, 31), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 1, 11))

    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[
                _InstallAsset(wmt700, "L5050246"),
            ],
            station_id=chminianska_nova_ves),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 6, 21), paid_service_until=datetime(2020, 12, 31),
        installation_date=datetime(2016, 1, 11))

    bertotovce3 = station_service.create_station(
        StationNewSchema(name="Bertotovce 3", road_segment_id=rs_id_beharovce, km_of_road=387.5,
                         km_of_road_note="",
                         latitude=49.01622, longitude=21.03930, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "P2410744"),
                       _InstallAsset(dmu703, "N3820029"),
                       _InstallAsset(pmu701, "N4750003"),
                       _InstallAsset(dri701, "P1423109"),
                       _InstallAsset(DRS511AB2, "P11248"),
                       _InstallAsset(DRS511AB5, "P06480"),
                       _InstallAsset(DTS12G, "N43407"),
                       _InstallAsset(HMP155, "P2150356"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(pwd12, "P1420179"),
                       _InstallAsset(wmt700, "P2350574"),
                       _InstallAsset(AKU12V_26ah, ),
                       _InstallAsset(dsc211, "P061010"),
                       ],
            station_id=bertotovce3),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 7, 31), paid_service_until=datetime(2020, 7, 31),
        installation_date=datetime(2018, 7, 31))

    hendrichovce_1 = station_service.create_station(
        StationNewSchema(name="Hendrichovce 1", road_segment_id=rs_id_beharovce, km_of_road=383,
                         km_of_road_note="",
                         latitude=49.02405, longitude=20.99034, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "P3230358"),
                       _InstallAsset(dmu703, "P0510009"),
                       _InstallAsset(pmu701, "P1813162"),
                       _InstallAsset(dri701, "P2443452"),
                       _InstallAsset(DRS511AB2, "P14295"),
                       _InstallAsset(DRS511AB5, "P28158"),
                       _InstallAsset(DTS12G, "N47410"),
                       _InstallAsset(HMP155, "P3220361"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(pwd12, "P3210855"),
                       _InstallAsset(wmt700, "P3220901"),
                       _InstallAsset(AKU12V_26ah, ),
                       _InstallAsset(dsc211, "P061006"),
                       ],
            station_id=hendrichovce_1),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 13), paid_service_until=datetime(2020, 9, 13),
        installation_date=datetime(2018, 9, 13))

    hendrichovce_3 = station_service.create_station(
        StationNewSchema(name="Hendrichovce 3", road_segment_id=rs_id_beharovce, km_of_road=384,
                         km_of_road_note="",
                         latitude=49.02626, longitude=21.00951, see_level=None, description=""))
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "P3110779"), _InstallAsset(dmu703, "P0640031"),
                       _InstallAsset(pmu701, "P1813163"),
                       _InstallAsset(dri701, "P2833085"),
                       _InstallAsset(DRS511AB2, "P14234"),
                       _InstallAsset(DRS511AB5, "N37433"),
                       _InstallAsset(dsc211, "P027029"),
                       _InstallAsset(DTR503A),
                       _InstallAsset(HMP155E, "P2950100"),
                       _InstallAsset(wmt700, "P3220900"),
                       _InstallAsset(pwd12, "P3030348"),
                       _InstallAsset(AKU26, "P3030348"),
                       ],
            station_id=hendrichovce_3),
        components_warranty_source=ComponentWarrantySource.COMPANY_WARRANTY,
        component_warranty_until=datetime(2020, 9, 12), paid_service_until=datetime(2020, 9, 12),
        installation_date=datetime(2018, 9, 12))

    # # -------------------------------------------------------------
    # rs_id_pb = rs_router.create_road_segment(RoadSegmentNewSchema(name=import_rs_1, ssud="SSUD 5"))
    #
    # pb_stakada = station_service.create_station_legacy(
    #     StationNewSchema(name="PB Estakáda", road_segment_id=rs_id_pb, km_of_road=169.5,
    #                      km_of_road_note="",
    #                      latitude=49.12305, longitude=18.44497, see_level=None, description=""), legacy_ids="72,82")
    # assigned_component_rest_router.create_installed_component(
    #     new_components=_get_selected_assets_to_install(
    #         asset_ids=[_InstallAsset(rws200, "M4020536"), _InstallAsset(dmu703), _InstallAsset(pmu701),
    #                    _InstallAsset(wxt520, "M3850306"), _InstallAsset(dsc211, "M212003"),
    #                    _InstallAsset(dst111, "L533024"),
    #                    _InstallAsset(dsc211, "N392004"), _InstallAsset(dst111, "N271020")],
    #         station_id=pb_stakada),
    #     component_warranty_until=365, installation_date=datetime.now())
    #
    # sverepec_mur = station_service.create_station_legacy(
    #     StationNewSchema(name="Sverepec múr", road_segment_id=rs_id_pb, km_of_road=163, km_of_road_note='',
    #                      latitude=49.07726, longitude=18.41599, see_level=None, description=''), legacy_ids='94')
    # assigned_component_rest_router.create_installed_component(
    #     new_components=_get_selected_assets_to_install(
    #         asset_ids=[_InstallAsset(rws200, "P2620186"), _InstallAsset(dmu703), _InstallAsset(pmu701),
    #                    _InstallAsset(pwd12, "P2450280"),
    #                    _InstallAsset(dsc211, "P027011"), _InstallAsset(wmt700, "P2610202")
    #             , _InstallAsset(hmp155), _InstallAsset(dts12g, "N43406"),
    #                    _InstallAsset(dsc211), _InstallAsset(dst111)],
    #         station_id=sverepec_mur),
    #     component_warranty_until=365, installation_date=datetime.now())
    #
    # sverepec_most = station_service.create_station_legacy(
    #     StationNewSchema(name="Sverepec Most", road_segment_id=rs_id_pb, km_of_road=162, km_of_road_note='',
    #                      latitude=49.07199, longitude=18.40343, see_level=None, description=''), legacy_ids='73')
    # assigned_component_rest_router.create_installed_component(
    #     new_components=_get_selected_assets_to_install(
    #         asset_ids=[_InstallAsset(rws200, "M4020532"), _InstallAsset(dmu703), _InstallAsset(pmu701),
    #                    _InstallAsset(dsc211, "M114012"),
    #                    _InstallAsset(dst111, "M151049"), _InstallAsset(wxt520, "M2740541")
    #                    ],
    #         station_id=sverepec_most),
    #     component_warranty_until=365, installation_date=datetime.now())
    #
    # kockovsky_kanal = station_service.create_station_legacy(
    #     StationNewSchema(name="Kočkovský kanál", road_segment_id=rs_id_pb, km_of_road=151, km_of_road_note='',
    #                      latitude=49.03606, longitude=18.27317, see_level=None, description=''), legacy_ids='95')
    # assigned_component_rest_router.create_installed_component(
    #     new_components=_get_selected_assets_to_install(
    #         asset_ids=[_InstallAsset(rws200, "P3810561"), _InstallAsset(dmu703), _InstallAsset(pmu701),
    #                    _InstallAsset(pwd12, "P3810648"),
    #                    _InstallAsset(dsc211, "P224028"),
    #                    _InstallAsset(wmt700, "P3710890"), _InstallAsset(hmp155, "P3640840"),
    #                    _InstallAsset(dts12g, "N47407"),
    #                    ],
    #         station_id=kockovsky_kanal),
    #     component_warranty_until=365, installation_date=datetime.now())
    #
    # rs_id_trencin = rs_router.create_road_segment(RoadSegmentNewSchema(name="Trenčín", ssud="SSUD 4"))
    #
    # prejta = station_service.create_station_legacy(
    #     StationNewSchema(name="Prejta", road_segment_id=rs_id_trencin, km_of_road=141, km_of_road_note='',
    #                      latitude=48.97838, longitude=18.17723, see_level=None, description=''), legacy_ids='50')
    # assigned_component_rest_router.create_installed_component(
    #     new_components=_get_selected_assets_to_install(
    #         asset_ids=[_InstallAsset(dxs422, "F383004"), _InstallAsset(dsc111),
    #                    _InstallAsset(dst111, "G123001"),
    #                    _InstallAsset(wxt520, "P3710890")
    #                    ],
    #         station_id=prejta),
    #     component_warranty_until=365, installation_date=datetime.now())
    #
    # trencin = station_service.create_station_legacy(
    #     StationNewSchema(name="Trenčín", road_segment_id=rs_id_trencin, km_of_road=124, km_of_road_note='privádzač TN',
    #                      latitude=48.89400, longitude=18.00350, see_level=None, description=''), legacy_ids='54')
    # assigned_component_rest_router.create_installed_component(
    #     new_components=_get_selected_assets_to_install(
    #         asset_ids=[_InstallAsset(dxs422, "G022008"), _InstallAsset(dsc111),
    #                    _InstallAsset(dst111),
    #                    _InstallAsset(wxt520), _InstallAsset(dts12g)
    #                    ],
    #         station_id=trencin),
    #     component_warranty_until=365, installation_date=datetime.now())
    #
    # drietoma = station_service.create_station_legacy(
    #     StationNewSchema(name="Drietoma", road_segment_id=rs_id_trencin, km_of_road=111, km_of_road_note='',
    #                      latitude=48.87759, longitude=17.96092, see_level=None, description=''), legacy_ids='1')
    # assigned_component_rest_router.create_installed_component(
    #     new_components=_get_selected_assets_to_install(
    #         asset_ids=[_InstallAsset(dxs422, "H463008"), _InstallAsset(dsc111, "K284079"),
    #                    _InstallAsset(dst111, "K381044"),
    #                    _InstallAsset(wxt520, "K4940009")
    #                    ],
    #         station_id=drietoma),
    #     component_warranty_until=365, installation_date=datetime.now())



def _get_all_assets_to_install(station_id):
    col = []
    for a in rest_router.get_assets():
        # todo: fix this ked budu realne serial numbers udaje k dispozicii
        col.append(AssignedComponentNewSchema(asset_id=a.id, station_id=station_id, serial_number="123456"))
    return col


def _get_selected_assets_to_install(asset_ids: list[_InstallAsset], station_id):
    col = []

    for a in asset_ids:
        # todo: fix this ked budu realne serial numbers udaje k dispozicii
        col.append(
            AssignedComponentNewSchema(asset_id=a.asset_id.id, station_id=station_id, serial_number=a.serial_number,
                                       service_contracts_id=[]))
    return col
