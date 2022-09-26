import 'dart:core';

import 'package:get/get.dart';
import 'package:open_cmms/helper.dart';

import '../models/task_component.dart';

class TaskComponentState extends GetxController {
  int _sequence = 0;
  //actionId <id, taskcomp>
  Map<String, Map<String, TaskComponent>> components =
      <String, Map<String, TaskComponent>>{}.obs;

  @override
  void onInit() {
    _initNewTaskComponent(HelpAction.task0actionremove, HelpProduct.productTEPLOANALOGID, TaskComponentStatus.installed);
    _initNewTaskComponent(HelpAction.task0actionadd, HelpProduct.productTEPLODIGIID, TaskComponentStatus.awaiting);
    super.onInit();
  }

  void _initNewTaskComponent(actionId,productId,TaskComponentStatus status) {
    var id = _getNewId();
    var item = TaskComponent(id, actionId, productId, status);
    if (!components.containsKey(item.actionId)) {
      components[actionId] = <String, TaskComponent>{}.obs;
      components[actionId]![id] = item;
    } else {
      components[actionId]![id] = item;
    }
  }

  String _getNewId() {
    var id = _sequence.toString();
    _sequence++;
    return id;
  }
}
