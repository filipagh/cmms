import datetime

from base import main
import xlsxwriter

from assetmanager.application import asset_manager_loader
from stationmanager.application.action_history.action_history_projector import ActionHistoryProjector
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.domain.model.assigned_component import AssignedComponentState
from stationmanager.infrastructure.persistence import station_repo


def export_xslx(station_id):
    station = station_repo.get_by_id(station_id)
    assets = asset_manager_loader.load_assets()
    components = main.runner.get(AssignedComponentProjector).get_by_station(station_id)
    history = main.runner.get(ActionHistoryProjector).get_by_station(station_id)

    name = station.name + " " + datetime.datetime.now().__str__() + ".xlsx"
    workbook = xlsxwriter.Workbook(name)
    worksheet = workbook.add_worksheet()

    # Widen the first column to make the text clearer.
    # worksheet.set_column("A:A", 20)

    # Add a bold format to use to highlight cells.
    # bold = workbook.add_format({"bold": True})

    # Write some simple text.
    worksheet.write("A1", "Informacie o stanici")

    worksheet.write("A2", "Meno stanice")
    worksheet.write("B2", station.name)

    worksheet.write("A3", "Km cestneho useku")
    worksheet.write("B3", station.km_of_road)

    worksheet.write("A4", "Km cestneho useku poznamka")
    worksheet.write("B4", station.km_of_road_note)

    worksheet.write("A5", "Gps dlzka")
    worksheet.write("B5", station.longitude)
    worksheet.write("A6", "Gps sirka")
    worksheet.write("B6", station.latitude)
    worksheet.write("A7", "nadmorska vyska")
    worksheet.write("B7", station.see_level)


    worksheet.write("A8", "poznamka")
    worksheet.write("B8", station.description)
    worksheet.write("A9", "ID")
    worksheet.write("B9", str(station.id))

    worksheet.write("A11", "komponenty")


    worksheet.write("A12", "Nazov")
    worksheet.write("B12", "Seriove cislo")
    worksheet.write("C12", "Datum instalacie")
    worksheet.write("D12", "Zaruka do")


    index = 12
    for component in components:
        if component.status in [AssignedComponentState.INSTALLED, AssignedComponentState.WILL_BE_REMOVED]:
            index += 1
            for a in assets:
                if a.id == component.asset_id:
                    asset = a
                    break

            worksheet.write("A"+str(index), asset.name)
            worksheet.write("B"+str(index), component.serial_number)
            worksheet.write("C"+str(index), component.installed_at.__str__())
            worksheet.write("D"+str(index), component.warranty_period_until.__str__())

    index += 2

    worksheet.write("A"+str(index), "Historia akcii")
    index += 1
    worksheet.write("A"+str(index), "Cas")
    worksheet.write("B"+str(index), "Text")



    for log in history:
        index += 1
        worksheet.write("A"+str(index), log.datetime.__str__())
        worksheet.write("B"+str(index), log.text)



    # Text with formatting.
    # worksheet.write("A2", "World", bold)

    # Write some numbers, with row/column notation.
    # worksheet.write(2, 0, 123)
    # worksheet.write(3, 0, 123.456)
    #
    # # Insert an image.
    # worksheet.insert_image("B5", "logo.png")

    workbook.close()

    return name