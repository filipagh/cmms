import 'package:BackendAPI/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/states/stations_actions_list_state.dart';

import '../tasks/task_page_factory.dart';

class StationHistoryPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/History';
  final StationSchema station;
  final ScrollController scrollController = ScrollController();

  StationHistoryPage({Key? key, required this.station}) : super(key: key) {
    actionState = Get.put(StationsActionListState(station));
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          actionState.loadMore();
        }
      }
    });
  }

  late StationsActionListState actionState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GetX<StationsActionListState>(builder: (state) {
            var i = state.getStationsHistory().toList();
            return ListView.builder(
              controller: scrollController,
              itemCount: i.length,
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
