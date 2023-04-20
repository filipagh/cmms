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
    dmu703 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DMU703 Centralna jednotka", telemetry=[
            AssetTelemetry(type=AssetTelemetryType.DEW_POINT_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))
    pmu701 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="PMU701 Power management jednotka", telemetry=[]))
    rws200 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="RWS200 Modul stanice", telemetry=[]))
    dxs422 = rest_router.create_new_asset(
        AssetNewSchema(category_id=cat_id, name="DXS422 Modul stanice", telemetry=[]))

    station_service = main.runner.get(StationService)
    print("zacinam import dummy stanic")
    for i in rs_router.get_all():
        if i.name == import_rs_1:
            print("import skip")
            return
    rs_id_pb = rs_router.create_road_segment(RoadSegmentNewSchema(name=import_rs_1, ssud="5"))

    pb_stakada = station_service.create_station_legacy(
        StationNewSchema(name="PB Estakáda", road_segment_id=rs_id_pb, km_of_road=169.5,
                         km_of_road_note="",
                         latitude=49.12305, longitude=18.44497, see_level=None, description=""), legacy_ids="72,82")
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "M4020536"), _InstallAsset(dmu703), _InstallAsset(pmu701),
                       _InstallAsset(wxt520, "M3850306"), _InstallAsset(dsc211, "M212003"),
                       _InstallAsset(dst111, "L533024"),
                       _InstallAsset(dsc211, "N392004"), _InstallAsset(dst111, "N271020")],
            station_id=pb_stakada),
        warranty_period_days=365)

    sverepec_mur = station_service.create_station_legacy(
        StationNewSchema(name="Sverepec múr", road_segment_id=rs_id_pb, km_of_road=163, km_of_road_note='',
                         latitude=49.07726, longitude=18.41599, see_level=None, description=''), legacy_ids='94')
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "P2620186"), _InstallAsset(dmu703), _InstallAsset(pmu701),
                       _InstallAsset(pwd12, "P2450280"),
                       _InstallAsset(dsc211, "P027011"), _InstallAsset(wmt700, "P2610202")
                , _InstallAsset(hmp155), _InstallAsset(dts12g, "N43406"),
                       _InstallAsset(dsc211), _InstallAsset(dst111)],
            station_id=sverepec_mur),
        warranty_period_days=365)

    sverepec_most = station_service.create_station_legacy(
        StationNewSchema(name="Sverepec Most", road_segment_id=rs_id_pb, km_of_road=162, km_of_road_note='',
                         latitude=49.07199, longitude=18.40343, see_level=None, description=''), legacy_ids='73')
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "M4020532"), _InstallAsset(dmu703), _InstallAsset(pmu701),
                       _InstallAsset(dsc211, "M114012"),
                       _InstallAsset(dst111, "M151049"), _InstallAsset(wxt520, "M2740541")
                       ],
            station_id=sverepec_most),
        warranty_period_days=365)

    kockovsky_kanal = station_service.create_station_legacy(
        StationNewSchema(name="Kočkovský kanál", road_segment_id=rs_id_pb, km_of_road=151, km_of_road_note='',
                         latitude=49.03606, longitude=18.27317, see_level=None, description=''), legacy_ids='95')
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(rws200, "P3810561"), _InstallAsset(dmu703), _InstallAsset(pmu701),
                       _InstallAsset(pwd12, "P3810648"),
                       _InstallAsset(dsc211, "P224028"),
                       _InstallAsset(wmt700, "P3710890"), _InstallAsset(hmp155, "P3640840"),
                       _InstallAsset(dts12g, "N47407"),
                       ],
            station_id=kockovsky_kanal),
        warranty_period_days=365)

    rs_id_trencin = rs_router.create_road_segment(RoadSegmentNewSchema(name="Trenčín", ssud="4"))

    prejta = station_service.create_station_legacy(
        StationNewSchema(name="Prejta", road_segment_id=rs_id_trencin, km_of_road=141, km_of_road_note='',
                         latitude=48.97838, longitude=18.17723, see_level=None, description=''), legacy_ids='50')
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(dxs422, "F383004"), _InstallAsset(dsc111),
                       _InstallAsset(dst111, "G123001"),
                       _InstallAsset(wxt520, "P3710890")
                       ],
            station_id=prejta),
        warranty_period_days=365)

    trencin = station_service.create_station_legacy(
        StationNewSchema(name="Trenčín", road_segment_id=rs_id_trencin, km_of_road=124, km_of_road_note='privádzač TN',
                         latitude=48.89400, longitude=18.00350, see_level=None, description=''), legacy_ids='54')
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(dxs422, "G022008"), _InstallAsset(dsc111),
                       _InstallAsset(dst111),
                       _InstallAsset(wxt520), _InstallAsset(dts12g)
                       ],
            station_id=trencin),
        warranty_period_days=365)

    drietoma = station_service.create_station_legacy(
        StationNewSchema(name="Drietoma", road_segment_id=rs_id_trencin, km_of_road=111, km_of_road_note='',
                         latitude=48.87759, longitude=17.96092, see_level=None, description=''), legacy_ids='1')
    assigned_component_rest_router.create_installed_component(
        new_components=_get_selected_assets_to_install(
            asset_ids=[_InstallAsset(dxs422, "H463008"), _InstallAsset(dsc111, "K284079"),
                       _InstallAsset(dst111, "K381044"),
                       _InstallAsset(wxt520, "K4940009")
                       ],
            station_id=drietoma),
        warranty_period_days=365)

    #
    # rs_id = rs_router.create_road_segment(RoadSegmentNewSchema(name=import_rs_2, ssud=import_rs_2))
    # s1 = station_rest_router.create_station(
    #     StationNewSchema(name="aupark 1", road_segment_id=rs_id, km_of_road=1.2,
    #                      km_of_road_note="poznamka zaciatok dialnice",
    #                      latitude=48.1318009, longitude=17.1003623, see_level=200, description="aupark 1"))
    # assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s1),
    #                                                           warranty_period_days=365)
    #
    # s2 = station_rest_router.create_station(
    #     StationNewSchema(name="aupark 2", road_segment_id=rs_id, km_of_road=1.2,
    #                      km_of_road_note="poznamka zaciatok dialnice",
    #                      latitude=48.1319009, longitude=17.1005623, see_level=200, description="aupark 2"))
    # assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s2),
    #                                                           warranty_period_days=365)
    #
    # s1 = station_rest_router.create_station(
    #     StationNewSchema(name="pristavny most 1", road_segment_id=rs_id, km_of_road=3.2,
    #                      km_of_road_note="poznamka most",
    #                      latitude=48.1337916, longitude=17.138576, see_level=200, description="pristavny most 1"))
    # assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s1),
    #                                                           warranty_period_days=365)
    #
    # s2 = station_rest_router.create_station(
    #     StationNewSchema(name="pristavny most 2", road_segment_id=rs_id, km_of_road=3.2,
    #                      km_of_road_note="poznamka most",
    #                      latitude=48.1357916, longitude=17.139576, see_level=200, description="pristavny most 2"))
    # assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s2),
    #                                                           warranty_period_days=365)


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
            AssignedComponentNewSchema(asset_id=a.asset_id.id, station_id=station_id, serial_number=a.serial_number))
    return col
