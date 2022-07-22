import 'dart:core';

import 'package:get/get.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/action.dart';

class ActionState extends GetxController {
  int _sequence = 0;

  //taskId <id, action>
  Map<String, Map<String, Action>> actions =
      <String, Map<String, Action>>{}.obs;

  @override
  void onInit() {
    HelpAction.task0actionremove =
        _initNewAction(HelpTask.task0, ActionStatus.awaiting);
    HelpAction.task0actionadd =
        _initNewAction(HelpTask.task0, ActionStatus.awaiting);
    HelpAction.task1actionchceck =
        _initNewAction(HelpTask.task1, ActionStatus.inProgress);
    super.onInit();
  }

  String _initNewAction(taskId, status) {
    var id = _getNewId();
    var item = Action(id, taskId, status);
    if (!actions.containsKey(item.taskId)) {
      actions[taskId] = <String, Action>{}.obs;
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
