import 'dart:core';

import 'package:get/get.dart';
import 'package:open_cmms/helper.dart';

import '../models/task_action.dart';

class ActionState extends GetxController {
  int _sequence = 0;

  //taskId <id, action>
  Map<String, Map<String, TaskAction>> actions =
      <String, Map<String, TaskAction>>{}.obs;

  @override
  void onInit() {
    HelpAction.task0actionremove =
        _initNewAction(HelpTask.task0,ActionJob.remove, ActionStatus.awaiting);
    HelpAction.task0actionadd =
        _initNewAction(HelpTask.task0,ActionJob.install, ActionStatus.awaiting);
    HelpAction.task1actionchceck =
        _initNewAction(HelpTask.task1,ActionJob.remoteService, ActionStatus.inProgress);
    super.onInit();
  }

  String _initNewAction(taskId,job, status) {
    var id = _getNewId();
    var item = TaskAction(id, taskId,job, status);
    if (!actions.containsKey(item.taskId)) {
      actions[taskId] = <String, TaskAction>{}.obs;
      actions[taskId]![id] = item;
    } else {
      actions[taskId]![id] = item;
    }
    return id;
  }

  String _getNewId() {
    var id = _sequence.toString();
    _sequence++;
    return id;
  }
}
