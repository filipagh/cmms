import datetime

import xlsxwriter

from assetmanager.application import asset_manager_loader
from base import main
from stationmanager.application.action_history.action_history_projector import ActionHistoryProjector
from stationmanager.application.assigned_component.assigned_component_projector import AssignedComponentProjector
from stationmanager.domain.model.assigned_component import AssignedComponentState
from stationmanager.infrastructure.persistence import station_repo


def export_xslx(station_id):
    station = station_repo.get_by_id(station_id)
    assets = asset_manager_loader.load_assets()
    assigned_component_projector: AssignedComponentProjector = main.runner.get(AssignedComponentProjector)
    components = assigned_component_projector.get_by_station(station_id)
    action_history_projector: ActionHistoryProjector = main.runner.get(ActionHistoryProjector)
    history = action_history_projector.get_by_station(station_id, False)

    name = station.name + " " + datetime.datetime.now().__str__() + ".xlsx"
    workbook = xlsxwriter.Workbook(name)
    worksheet = workbook.add_worksheet()

    # Widen the first column to make the text clearer.
    # worksheet.set_column("A:A", 20)

    # Add a bold format to use to highlight cells.
    # bold = workbook.add_format({"bold": True})

    # Write some simple text.
    worksheet.write("A1", "Informácie o stanici")

    worksheet.write("A2", "Meno stanice")
    worksheet.write("B2", station.name)

    worksheet.write("A3", "Km cestného úseku")
    worksheet.write("B3", station.km_of_road)

    worksheet.write("A4", "Poznámka k pozícii since")
    worksheet.write("B4", station.km_of_road_note)

    worksheet.write("A5", "Gps dĺžka")
    worksheet.write("B5", station.longitude)
    worksheet.write("A6", "Gps šírka")
    worksheet.write("B6", station.latitude)
    worksheet.write("A7", "Nadmorská výska")
    worksheet.write("B7", station.see_level)

    worksheet.write("A8", "Poznámka")
    worksheet.write("B8", station.description)
    worksheet.write("A9", "ID")
    worksheet.write("B9", str(station.id))

    worksheet.write("A11", "komponenty")

    worksheet.write("A12", "Názov")
    worksheet.write("B12", "Sériove číslo")
    worksheet.write("C12", "Dátum inštalácie")
    worksheet.write("D12", "Záruka na komponent do")
    worksheet.write("E12", "Predplatený servis")
    worksheet.write("F12", "Technický servis")

    index = 12
    for component in components:
        if component.status in [AssignedComponentState.INSTALLED, AssignedComponentState.WILL_BE_REMOVED]:
            index += 1
            for a in assets:
                if a.id == component.asset_id:
                    asset = a
                    break

            worksheet.write("A" + str(index), asset.name)
            worksheet.write("B" + str(index), component.serial_number)
            worksheet.write("C" + str(index), component.installed_at.__str__())
            worksheet.write("D" + str(index), component.component_warranty_until.__str__())
            worksheet.write("E" + str(index), component.prepaid_service_until.__str__())
            worksheet.write("F" + str(index), component.service_contract_until.__str__())

    index += 2

    worksheet.write("A" + str(index), "Historia akcii")
    index += 1
    worksheet.write("A" + str(index), "Cas")
    worksheet.write("B" + str(index), "Text")

    for log in history:
        index += 1
        worksheet.write("A" + str(index), log.datetime.__str__())
        worksheet.write("B" + str(index), log.text)

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
