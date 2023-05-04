import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/task_list_title.dart';

import '../../models/task_state_filter.dart';

class StationTasksPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Tasks';
  final StationSchema station;
  List<TaskStateCustom> selectedTaskState = <TaskStateCustom>[];
  List<TaskStateCustom> options = <TaskStateCustom>[];

  StationTasksPage({Key? key, required this.station}) : super(key: key) {
    setup();
  }

  final RxList<TaskSchema> items = <TaskSchema>[].obs;

  @override
  Widget build(BuildContext context) {
    loadTasks(taskState: selectedTaskState.map((e) => e.state).toList());
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 200,
                child: DropDownMultiSelect<TaskStateCustom>(
                  options: options,
                  selectedValues: selectedTaskState,
                  onChanged: (v) {
                    selectedTaskState = v;
                    loadTasks(
                        taskState:
                            selectedTaskState.map((e) => e.state).toList());
                  },
                  whenEmpty: "filtrovať podla stavu",
                )),
          ],
        ),
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

  void loadTasks({List<TaskState> taskState = const []}) {
    TasksService()
        .loadAllTaskManagerGetTasksGet(
            stationId: station.id, filterState: taskState)
        .then((value) {
      items.clear();
      items.addAll(value ?? []);
    });
  }

  void setup() {
    var list = [
      TaskStateCustom(TaskState.ready),
      TaskStateCustom(TaskState.open)
    ];
    this.selectedTaskState.addAll(list);
    list.add(TaskStateCustom(TaskState.removed));
    list.add(TaskStateCustom(TaskState.done));
    this.options.addAll(list);
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
}
