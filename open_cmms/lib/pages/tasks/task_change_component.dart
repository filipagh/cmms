import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu_widget.dart';


class TaskChangeComponentsPage extends StatelessWidget {

  static const String ENDPOINT = '/TaskChangeComponent';
  final String taskId;
  TaskChangeComponentsPage({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  final Rxn<TaskChangeComponentsSchema> task = Rxn<TaskChangeComponentsSchema>();
  bool isModelLoaded = false;

  loadTask() {
    TasksService().loadTaskManagerGetComponentTaskTaskIdGet(taskId).then((value) => task.value = value);
  }

  Widget buildContent() {
   return Obx(() {
      if (task.value != null) {
        return buildRoadSegment();
      }
      return buildMissingRoadSegment();
    });
  }

  @override

  Widget build(BuildContext context) {
    loadTask();
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
                "Task "+ task.value!.id,
                textScaleFactor: 5,
              ),
              Divider(),
            ],
          );
  }

  Widget buildMissingRoadSegment() {
    return SizedBox(width:200, height:200, child: CircularProgressIndicator());
  }
}
