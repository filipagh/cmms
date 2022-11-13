import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/station/station_components_page.dart';
import 'package:open_cmms/pages/station/station_info_page.dart';

class StationTabMenu extends StatelessWidget {
  final String stationId;

  StationTabMenu({Key? key, required this.stationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildColumn();
  }

  Column buildColumn() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, children: getButtons());
  }

  List<Widget> getButtons() {
    List<Widget> list = [];
    buttonList.forEach((element) {
      list.add(ElevatedButton.icon(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        ),
        onPressed: () {
          // Get.offAndToNamed(
          Get.toNamed(
              StationBasePage.ENDPOINT + '/' + stationId + element.endpoint);
        },
        label: Text(element.label),
        icon: element.icon,
      ));
      list.add(Divider());
    });
    return list;
  }

  List<StationButton> buttonList = [
    StationButton(
        "Informacie", const Icon(Icons.info), StationInfoPage.ENDPOINT),
    StationButton("Komponenty", const Icon(Icons.settings), StationComponentsPage.ENDPOINT),
    StationButton("Ulohy", const Icon(Icons.task), ""),
    StationButton("Historia", const Icon(Icons.history), ""),
  ];
}

class StationButton {
  late String label;
  late Icon icon;
  late String endpoint;

  StationButton(this.label, this.icon, this.endpoint);
}
