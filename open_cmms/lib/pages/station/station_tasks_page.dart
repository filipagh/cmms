import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/task_list_title.dart';

class StationTasksPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Tasks';
  final StationSchema station;

  StationTasksPage({Key? key, required this.station}) : super(key: key);

  final RxList<TaskSchema> items = <TaskSchema>[].obs;

  @override
  Widget build(BuildContext context) {
    TasksService()
        .loadTaskManagerGetTasksGet(stationId: station.id)
        .then((value) => items.addAll(value ?? []));
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            var i = items.toList();
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return buildTaskListTitle(i[index]);
              },
            );
          }),
        )
      ],
    );
  }
}


String getTaskName(TaskType taskType) {
  String name = "";
  switch (taskType) {
    case TaskType.componentChange:
      name = "Zmena komponentov";
      break;
    case TaskType.onSiteService:
      name = "Osobna kontrola";
      break;
    case TaskType.remoteService:
      name = "Kontrola na dialku";
      break;
  }
  return name;
}