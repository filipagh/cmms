import 'package:flutter/material.dart';
import 'package:open_cmms/models/task_model.dart';


import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class Task extends StatefulWidget {
  final String taskId;
  const Task({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  TaskModel? taskModel;
  bool isModelLoaded = false;
  @override

  void initState() {
     taskModel = getDummyTaskById(widget.taskId);
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
