import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';

import '../pages/tasks/task_page_factory.dart';

Widget buildTaskListTitle(TaskSchema task) {
  return Card(
    child: ListTile(
      onTap: () {
        TaskPageFactory().openTaskPageFromModel(task);
      },
      hoverColor: Colors.blue.shade200,
      leading: Icon(getStatusIcon(task.state)),
      title: Text("${_getTaskName(task.taskType)}: ${task.name}"),
      subtitle: Text('vytvorene: ${task.createdOn}'),
      tileColor: _getTileColor(task.state),
    ),
  );
}

Color? _getTileColor(TaskState taskState) {
  switch (taskState) {
    case TaskState.done:
      return Colors.green[100];
      break;
    case TaskState.open:
      return Colors.yellow[100];
      break;
    case TaskState.ready:
      return Colors.blue[100];
      break;
    case TaskState.removed:
      return Colors.red[100];
      break;
  }
  return Colors.grey[200];
}

IconData getStatusIcon(TaskState taskState) {
  switch (taskState) {
    case TaskState.done:
      return Icons.done_all;
      break;
    case TaskState.open:
      return Icons.warning_amber;
      break;
    case TaskState.ready:
      return Icons.watch_later_outlined;
      break;
    case TaskState.removed:
      return Icons.highlight_remove;
      break;
  }
  return Icons.error;
}

String _getTaskName(TaskType taskType) {
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
