import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/custom_app_bar.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/station/station_picker.dart';

import '../models/station.dart';
import '../widgets/forms/tasks/create_task.dart';
import '../widgets/main_menu_widget.dart';

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
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Tasks",
                  textScaleFactor: 5,
                ),
                Row(
                  children: [
                    Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        Station station =
                            await showFormDialog(StationPickerForm());
                        showFormDialog(CreateTaskForm(station: station));
                      },
                      child: Text("create task"),
                    ),
                  ],
                ),
                Divider(),
                Expanded(child: Obx(
                  () {
                    var list = tasks;
                    return ListView.builder(
                        addRepaintBoundaries: true,
                        padding: const EdgeInsets.all(8),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Get.toNamed("/Tasks/${list[index].id}");
                              },
                              hoverColor: Colors.blue.shade200,
                              title: Text(list[index].name),
                              subtitle: Container(
                                child: Text('task id: ${list[index].id}'),
                              ),
                            ),
                          );
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
