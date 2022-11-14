import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/service/backend_api/action_hisotry_service.dart';

class StationHistoryPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/History';
  final StationSchema station;

  StationHistoryPage({Key? key, required this.station}) : super(key: key);

  final RxList<ActionHistorySchema> items = <ActionHistorySchema>[].obs;

  @override
  Widget build(BuildContext context) {
    ActionHistoryService()
        .getByStationActionHistoryByStationGet(station.id)
        .then((value) => items.addAll(value ?? []));
    return Column(
      children: [
        Expanded(
          child: Obx(() {  var i = items.reversed.toList(); return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(i[index].text),
                  subtitle: Text("datum: "+i[index].datetime.toString()),
                ),
              );
            },
          );}),
        )
      ],
    );
  }
}
