import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';

class StationInfoPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Info';
  final StationSchema station;

  const StationInfoPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText("Meno stanice: " + station.name),
        SelectableText(
            "Km cestneho useku: " + (station.kmOfRoad?.toString() ?? "")),
        SelectableText("Km cestneho useku poznamka: " + station.kmOfRoadNote),
        SelectableText(
            "Gps - dlzka: " + (station.longitude?.toString() ?? "-")),
        SelectableText("Gps - sirka: " + (station.latitude?.toString() ?? '-')),
        SelectableText(
            "nadmorska vyska: " + (station.seeLevel?.toString() ?? '-')),
        SelectableText("poznamka: " + station.description),
        SelectableText("ID: " + station.id),
      ],
    );
  }
}
