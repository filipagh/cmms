import 'package:get/get.dart';

import '../station.dart';
import '../task_action.dart';
import '../task_component.dart';

class TaskAggregate {
  late final Station station;
  final List<TaskAction> actions = <TaskAction>[].obs;
  final Map<String, List<TaskComponent>> taskComponents = <String, List<TaskComponent>>{}.obs;

  TaskAggregate(this.station);
}


