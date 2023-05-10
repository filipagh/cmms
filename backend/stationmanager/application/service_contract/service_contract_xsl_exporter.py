import datetime

import xlsxwriter

from base import main
from roadsegmentmanager.application.road_segment_projector import RoadSegmentProjector
from stationmanager.application.service_contract.service_contract_projector import ServiceContractProjector
from stationmanager.application.station_projector import StationProjector
from stationmanager.infrastructure.persistence.service_contract_repo import StationServiceContractModel


def export_stations_without_service_contract_xslx():
    active_contracts = main.runner.get(ServiceContractProjector).get_all_active()
    stations = main.runner.get(StationProjector).get_all(active_only=True)
    station_ids = []
    for station in stations:
        station_ids.append(station.id)
    road_segments = main.runner.get(RoadSegmentProjector).get_all(only_active=True)

    for contract in active_contracts:
        station_in_contract: StationServiceContractModel
        for station_in_contract in contract.station_id_list:
            try:
                station_ids.remove(station_in_contract.station_id)
            except ValueError:
                pass

    stations_without_service = []
    for s in station_ids:
        for station in stations:
            if station.id == s:
                stations_without_service.append(station)

    name = "Stanice bez servisnej zmluvy " + datetime.datetime.now().__str__() + ".xlsx"

    workbook = xlsxwriter.Workbook(name, {"in_memory": True})
    worksheet = workbook.add_worksheet()

    if len(stations_without_service) == 0:
        worksheet.write("A1", "Vsetky stanice maju servisnu zmluvu")
        workbook.close()
        return name

    worksheet.write("A1", "Stanice bez servisnej zmluvy")
    worksheet.write("A2", "Nazov stanice")
    worksheet.write("B2", "Nazov cesnteho useku")
    worksheet.write("C2", "ssud")

    index = 2
    for station in stations_without_service:
        index += 1
        worksheet.write("A" + str(index), station.name)
        for road_segment in road_segments:
            if road_segment.id == station.road_segment_id:
                worksheet.write("B" + str(index), road_segment.name)
                worksheet.write("C" + str(index), road_segment.ssud)

    workbook.close()

    return name
