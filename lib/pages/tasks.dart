import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/tasks_state.dart';
import 'package:open_cmms/widgets/custom_app_bar.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/station/station_picker.dart';

import '../models/aggregates/task.dart';
import '../models/station.dart';
import '../widgets/forms/tasks/create_task.dart';
import '../widgets/main_menu_widget.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key, required}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
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
                        showFormDialog(CreateTaskForm(
                          task: TaskAggregate(station),
                        ));
                      },
                      child: Text("create task"),
                    ),
                  ],
                ),
                Divider(),
                Expanded(child: GetX<TasksState>(
                  builder: (_) {
                    var list = _.tasks.values.toList();
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
}
