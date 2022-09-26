import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/aggregates/task.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/models/task_action.dart';
import 'package:open_cmms/models/task_component.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state.dart';

class CreateTaskForm extends StatelessWidget implements hasFormTitle {
  late TaskAggregate task;

  final ItemsState _itemsState = Get.find();
  final AssetTypesState _typeState = Get.find();


  CreateTaskForm({Key? key, required Station station, TaskAggregate? task})
      : super(key: key) {
    this.task = task ?? TaskAggregate(station);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("edit components")),
            ElevatedButton(onPressed: () {}, child: Text("manual service")),
            ElevatedButton(onPressed: () {}, child: Text("remote service")),
          ],
        ),
        Container(height: 600,width: 500,
            child: buildTaskActionList()),
      ],
    );
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  String getTitle() {
    return "Create new task for station: ${task.station.name}";
  }

  Widget buildTaskActionList() {
    return Obx(() {
      return ListView(
          children: buildActionsTiles()
      );
    });
  }

  List<Widget> buildActionsTiles() {
    List<Widget> tiles = [];
    task.actions.forEach((action) {
      tiles.add(buildcompinentTile(action));
    });
    return tiles;
  }

  ListTile buildcompinentTile(TaskAction action) {
    switch (action.job) {
      case ActionJob.install:
        return ListTile(
          title: Text("install this components:"),
          subtitle: buildComponentsString(task.taskComponents[action.id]),
        );
      case ActionJob.remove:
        return ListTile(
          title: Text("remove this components:"),
          subtitle: buildComponentsString(task.taskComponents[action.id]),
        );
      case ActionJob.remoteService:
        return ListTile(
          title: Text("remote service this components:"),
          subtitle: buildComponentsString(task.taskComponents[action.id]),
        );
    }
  }

  buildComponentsString(List<TaskComponent>? taskComponent) {
    var string = '';
    taskComponent?.forEach((element) {
      string =
          string + ' ' + _typeState.getAssetTypeById(element.productId)!.name;
    });
    return string.trim();
  }

}
