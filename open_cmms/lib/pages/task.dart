import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/tasks/task_page_factory.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class TaskPage extends StatelessWidget {
  static const String ENDPOINT = '/task';
  final String taskId;

  TaskPage({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskPageFactory()
        .getTaskUrlFromId(taskId)
        .then((value) => Get.toNamed(value));

    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Center(
              child: Text("Uloha neexistuje"),
            ),
          )
        ],
      ),
    );
  }
}
