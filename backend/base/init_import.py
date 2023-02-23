from assetmanager.application.model.schema import AssetCategoryNewSchema, AssetNewSchema
from assetmanager.domain.model.asset_telemetry import AssetTelemetry, AssetTelemetryType, AssetTelemetryValue
from assetmanager.infrastructure import rest_router
from roadsegmentmanager.application.model.schema import RoadSegmentNewSchema
from roadsegmentmanager.infrastructure import rest_router as rs_router
from stationmanager.application.assigned_component.model.schema import AssignedComponentNewSchema
from stationmanager.application.model.schema import StationNewSchema
from stationmanager.infrastructure import station_rest_router, assigned_component_rest_router

default_category = "zakladne komponenty"
import_rs_1 = "D1 (auto importovane)"
import_rs_2 = "D4 (auto importovane)"


def import_assets():
    print("zacinam import assetov")
    for i in rest_router.get_asset_categories():
        if i.name == default_category:
            print("import skip")
            return
    cat_id = rest_router.create_new_category(
        AssetCategoryNewSchema(name=default_category, description="zakladne komponenty auto-import")).id
    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="HMP155 Teplomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WXT536 Multisenzor", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.AIR_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.AIR_PRESSURE, value=AssetTelemetryValue.HECTO_PASCAL),
        AssetTelemetry(type=AssetTelemetryType.AIR_HUMIDITY, value=AssetTelemetryValue.PERCENTAGE)]))

    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DTS12G Zemny teplomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="WMT700 Vetromer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.WIND_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_SPEED, value=AssetTelemetryValue.METER_PER_SECOND),
        AssetTelemetry(type=AssetTelemetryType.WIND_GUST_DIRECTION, value=AssetTelemetryValue.CIRCLE_DEGREES),
    ]))
    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="PWD12 Senzor počasia", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.VISIBILITY, value=AssetTelemetryValue.METERS),
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND),

    ]))
    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DST Senzor teploty vozovky", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS)]))

    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DSC Senzor stavu vozovky", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.GROUND_TEMPERATURE, value=AssetTelemetryValue.CELSIUS),
        AssetTelemetry(type=AssetTelemetryType.ROAD_WARNING_STATUS, value=AssetTelemetryValue.STRING),
        AssetTelemetry(type=AssetTelemetryType.ROAD_RAIN_STATUS, value=AssetTelemetryValue.STRING),
        AssetTelemetry(type=AssetTelemetryType.ROAD_SURFACE_STATUS, value=AssetTelemetryValue.STRING)
    ]))
    rest_router.create_new_asset(AssetNewSchema(category_id=cat_id, name="DRD11 Zrážkomer", telemetry=[
        AssetTelemetry(type=AssetTelemetryType.RAINFALL_INTENSITY, value=AssetTelemetryValue.MILLIMETER_PER_SECOND)]))


def import_station():
    print("zacinam import dummy stanic")
    for i in rs_router.get_all():
        if i.name == import_rs_1:
            print("import skip")
            return
    rs_id = rs_router.create_road_segment(RoadSegmentNewSchema(name=import_rs_1, ssud=import_rs_1))
    s1 = station_rest_router.create_station(
        StationNewSchema(name="aupark 1", road_segment_id=rs_id, km_of_road=1.2,
                         km_of_road_note="poznamka zaciatok dialnice",
                         longitude=48.1318009, latitude=17.1003623, see_level=200, description="aupark 1"))
    assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s1),
                                                              warranty_period_days=365)

    s2 = station_rest_router.create_station(
        StationNewSchema(name="aupark 2", road_segment_id=rs_id, km_of_road=1.2,
                         km_of_road_note="poznamka zaciatok dialnice",
                         longitude=48.1319009, latitude=17.1005623, see_level=200, description="aupark 2"))
    assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s2),
                                                          warranty_period_days=365)

    rs_router.create_road_segment(RoadSegmentNewSchema(name=import_rs_2, ssud=import_rs_2))
    s1 = station_rest_router.create_station(
        StationNewSchema(name="pristavny most 1", road_segment_id=rs_id, km_of_road=3.2,
                         km_of_road_note="poznamka most",
                         longitude=48.1337916, latitude=17.138576, see_level=200, description="pristavny most 1"))
    assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s1),
                                                              warranty_period_days=365)

    s2 = station_rest_router.create_station(
        StationNewSchema(name="pristavny most 2", road_segment_id=rs_id, km_of_road=3.2,
                         km_of_road_note="poznamka most",
                         longitude=48.1319009, latitude=17.1005623, see_level=200, description="pristavny most 2"))
    assigned_component_rest_router.create_installed_component(new_components=_get_all_assets_to_install(station_id=s2),
                                                              warranty_period_days=365)

def _get_all_assets_to_install(station_id):
    col = []
    for a in rest_router.get_assets():
        col.append(AssignedComponentNewSchema(asset_id=a.id, station_id=station_id))
    return col
