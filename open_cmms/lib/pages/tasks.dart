import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/custom_app_bar.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/station/station_picker.dart';

import '../widgets/forms/tasks/create_task.dart';
import '../widgets/main_menu_widget.dart';
import '../widgets/task_list_title.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key, required}) : super(key: key);

  final RxList<TaskSchema> tasks = <TaskSchema>[].obs;

  @override
  Widget build(BuildContext context) {
    loadTasks();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Tasks",
                      textScaleFactor: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          loadTasks();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
                Row(
                  children: [
                    const Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    const Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        StationSchema station =
                            await showFormDialog(StationPickerForm());
                        showFormDialog(CreateTaskForm(station: station));
                      },
                      child: const Text("create task"),
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

  loadTasks() {
    TasksService().loadTaskManagerGetTasksGet().then((value) {
      tasks.clear();
      tasks.addAll(value ?? []);
      tasks.refresh();
    });
  }
}
