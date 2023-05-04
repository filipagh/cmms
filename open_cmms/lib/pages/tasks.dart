import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/custom_app_bar.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/station/station_picker.dart';

import '../models/task_state_filter.dart';
import '../widgets/forms/tasks/create_task.dart';
import '../widgets/main_menu_widget.dart';
import '../widgets/task_list_title.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key, required}) : super(key: key) {
    setup();
  }

  final RxList<TaskSchema> tasks = <TaskSchema>[].obs;

  List<TaskStateCustom> selectedTaskState = <TaskStateCustom>[];
  List<TaskStateCustom> options = <TaskStateCustom>[];

  @override
  Widget build(BuildContext context) {
    loadTasks(taskState: selectedTaskState.map((e) => e.state).toList());
    return Scaffold(
      appBar: CustomAppBar(
        pageText: Text("Úlohy"),
      ),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Hľadať (WIP)",
                          enabled: false,
                        ),
                      ),
                    ),
                    Container(
                        width: 200,
                        child: DropDownMultiSelect<TaskStateCustom>(
                          options: options,
                          selectedValues: selectedTaskState,
                          onChanged: (v) {
                            selectedTaskState = v;
                            loadTasks(
                                taskState: selectedTaskState
                                    .map((e) => e.state)
                                    .toList());
                          },
                          whenEmpty: "filtrovať podla stavu",
                        )),
                    const Spacer(),
                    ElevatedButton.icon(
                        label: const Text("načítaj úlohy"),
                        onPressed: () {
                          loadTasks();
                        },
                        icon: const Icon(Icons.refresh)),
                    Padding(padding: const EdgeInsets.all(10)),
                    ElevatedButton(
                      onPressed: () async {
                        StationSchema station =
                            await showFormDialog(StationPickerForm());
                        showFormDialog(CreateTaskForm(station: station));
                      },
                      child: const Text("nová úloha"),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(child: Obx(
                  () {
                    var list = tasks;
                    return ListView.builder(
                        addRepaintBoundaries: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildTaskListTitle(list[index]);
                        });
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  loadTasks({List<TaskState> taskState = const []}) {
    TasksService()
        .loadAllTaskManagerGetTasksGet(filterState: taskState)
        .then((value) {
      tasks.clear();
      tasks.addAll(value ?? []);
      tasks.refresh();
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
}
