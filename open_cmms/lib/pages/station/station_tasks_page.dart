import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/widgets/task_list_title.dart';

import '../../models/task_state_filter.dart';
import '../../states/tasks_list_state.dart';

class StationTasksPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Tasks';
  final StationSchema station;

  StationTasksPage({Key? key, required this.station}) : super(key: key) {
    List<TaskStateCustom> list = [
      TaskStateCustom(TaskState.ready),
      TaskStateCustom(TaskState.open)
    ];
    _tasksListState = Get.put(TasksListState(station, list.toList()));
    list.add(TaskStateCustom(TaskState.removed));
    list.add(TaskStateCustom(TaskState.done));
    options.addAll(list);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _tasksListState.loadMore();
      }
    });
  }

  late TasksListState _tasksListState;
  List<TaskStateCustom> options = <TaskStateCustom>[];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 200,
                child: GetX<TasksListState>(
                  builder: (state) => DropDownMultiSelect<TaskStateCustom>(
                    options: options,
                    selectedValues: state.getFilterTasksStates(),
                    onChanged: (v) {
                      state.setFilterTasksStates(v);
                    },
                    whenEmpty: "filtrovať podla stavu",
                  ),
                )),
          ],
        ),
        Expanded(
          child: GetX<TasksListState>(builder: (state) {
            var i = state.getTasks();
            return ListView.builder(
              itemCount: i.length,
              itemBuilder: (BuildContext context, int index) {
                return buildTaskListTitle(i[index]);
              },
            );
          }),
        )
      ],
    );
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
