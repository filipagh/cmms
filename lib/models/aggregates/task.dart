import 'package:get/get.dart';
import 'package:open_cmms/models/assigned_component.dart';
import 'package:open_cmms/models/item.dart';

import '../station.dart';
import '../task_action.dart';
import '../task_component.dart';

class TaskAggregate {
  String taskid = 'temp';
  late final Station station;
  final List<TaskAction> actions = <TaskAction>[].obs;
  final Map<String, List<TaskComponent>> taskComponents =
      <String, List<TaskComponent>>{}.obs;

  TaskAggregate(this.station);

  void installComponent(Item i) {
    var action = _getOrCreate(ActionJob.install);
    taskComponents[action.id]!.add(TaskComponent(
        'temp', action.id, i.productId, TaskComponentStatus.awaiting));
  }

  TaskAction _getOrCreate(ActionJob jobType) {
    var action = actions.firstWhereOrNull((element) => element.job == jobType);
    if (action == null) {
      action =
          TaskAction("temp$jobType", taskid, jobType, ActionStatus.awaiting);
      actions.add(action);
      taskComponents[action.id] = <TaskComponent>[];
    }
    return action;
  }

  void removeComponent(AssignedComponent i) {
    var action = _getOrCreate(ActionJob.remove);
    taskComponents[action.id]!.add(TaskComponent('temp', action.id, i.productId,
        TaskComponentStatus.awaiting, i.assignedComponentId));
  }
}
