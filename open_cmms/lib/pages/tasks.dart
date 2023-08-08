import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/states/tasks_list_state.dart';
import 'package:open_cmms/widgets/custom_app_bar.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/station/station_picker.dart';

import '../models/task_state_filter.dart';
import '../widgets/forms/tasks/create_task.dart';
import '../widgets/main_menu_widget.dart';
import '../widgets/task_list_title.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key, required}) : super(key: key) {
    List<TaskStateCustom> list = [
      TaskStateCustom(TaskState.ready),
      TaskStateCustom(TaskState.open)
    ];
    _tasksListState = Get.put(TasksListState(null, list.toList()));
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
// Container(
//   width: 200,
//   child: const TextField(
//     decoration: InputDecoration(
//       hintText: "Hľadať (WIP)",
//       enabled: false,
//     ),
//   ),
// ),
                    Container(
                        width: 400,
                        child: GetX<TasksListState>(
                          builder: (state) =>
                              DropDownMultiSelect<TaskStateCustom>(
                            options: options,
                            selectedValues: state.getFilterTasksStates(),
                            onChanged: (v) {
                              state.setFilterTasksStates(v);
                            },
                            whenEmpty: "filtrovať podla stavu",
                          ),
                        )),
                    const Spacer(),
                    ElevatedButton.icon(
                        label: const Text("načítaj úlohy"),
                        onPressed: () {
                          _tasksListState.reload();
                        },
                        icon: const Icon(Icons.refresh)),
                    Padding(padding: const EdgeInsets.all(10)),
                    ElevatedButton(
                      onPressed: () async {
                        StationSchema station =
                            await showFormDialog(StationPickerForm());
                        showFormDialog(CreateTaskForm(station: station))
                            .then((value) {
                          if (value) {
                            _tasksListState.reload();
                            showOk("úloha bola vytvorená");
                          }
                        });
                      },
                      child: const Text("nová úloha"),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(child: GetX<TasksListState>(
                  builder: (state) {
                    var list = state.getTasks();
                    return ListView.builder(
                        controller: _scrollController,
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
}
