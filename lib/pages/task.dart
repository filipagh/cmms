import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/task.dart';
import '../states/tasks_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class TaskPage extends StatefulWidget {
  final String taskId;
  const TaskPage({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TasksState _tasksState = Get.find();
  Task? taskModel;
  bool isModelLoaded = false;
  @override

  void initState() {
     taskModel = _tasksState.tasks[widget.taskId];
    super.initState();
  }

  Widget buildContent() {
    if (taskModel != null) {
      return buildRoadSegment();
    }
    return buildMissingRoadSegment();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: buildContent(),
          )
        ],
      ),
    );
  }

  Column buildRoadSegment() {
    return Column(
            children: [
              Text(
                "Task "+ taskModel!.id,
                textScaleFactor: 5,
              ),
              Divider(),
            ],
          );
  }

  Widget buildMissingRoadSegment() {
    return Center(child: Text("Missing data for Asset ID: "+ widget.taskId,textScaleFactor: 2,));
  }
}
