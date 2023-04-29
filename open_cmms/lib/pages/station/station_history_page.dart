import 'package:BackendAPI/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/service/backend_api/action_hisotry_service.dart';

import '../tasks/task_page_factory.dart';

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
                    title: processReferences(i[index].text),
                    subtitle: Text("datum: " + i[index].datetime.toString()),
                  ),
                );
              },
            );
          }),
        )
      ],
    );
  }

  Widget processReferences(String text) {
    var matches = "\$\$".allMatches(text);
    if (matches.length > 0) {
      var prefix = text.substring(0, matches.first.start);
      var suffix = text.substring(matches.last.end);
      var taskId = text.substring(matches.first.end, matches.last.start);

      return RichText(
          text: TextSpan(
        text: prefix,
        children: [
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () => TaskPageFactory().openTaskFromId(taskId),
              text: "(odkaz)",
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline)),
          TextSpan(text: suffix)
        ],
      ));
    }

    return Text(text);
  }
}
