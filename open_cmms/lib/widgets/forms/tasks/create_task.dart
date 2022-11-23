import 'package:BackendAPI/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/aggregates/task.dart';
import 'package:open_cmms/models/task_component.dart';
import 'package:open_cmms/states/items_state_dummy.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/edit_station_components_form.dart';

import '../../../states/asset_types_state_dummy.dart';

class CreateTaskForm extends StatelessWidget implements hasFormTitle {
  final StationSchema station;
  final ItemsState_dummy _itemsState = Get.find();
  final AssetTypesStateDummy _typeState = Get.find();

  CreateTaskForm({Key? key, required this.station, TaskAggregate? task})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                  showFormDialog(EditStationComponentsForm(station: station));
                },
                child: Text("edit components")),
            ElevatedButton(onPressed: () {}, child: Text("manual service")),
            ElevatedButton(onPressed: () {}, child: Text("remote service")),
          ],
        ),
        // Container(height: 600, width: 500, child: buildTaskActionList()),
      ],
    );
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  String getTitle() {
    return "Create new task for station: ${station.name}";
  }

  // Widget buildTaskActionList() {
  //   return Obx(() {
  //     return ListView(children: buildActionsTiles());
  //   });
  // }
  //
  // List<Widget> buildActionsTiles() {
  //   List<Widget> tiles = [];
  //   task.actions.forEach((action) {
  //     tiles.add(buildcompinentTile(action));
  //   });
  //   return tiles;
  // }
  //
  // ListTile buildcompinentTile(TaskAction action) {
  //   switch (action.job) {
  //     case ActionJob.install:
  //       return ListTile(
  //         title: Text("install this components:"),
  //         subtitle: buildComponentsString(task.taskComponents[action.id]),
  //       );
  //     case ActionJob.remove:
  //       return ListTile(
  //         title: Text("remove this components:"),
  //         subtitle: buildComponentsString(task.taskComponents[action.id]),
  //       );
  //     case ActionJob.remoteService:
  //       return ListTile(
  //         title: Text("remote service this components:"),
  //         subtitle: buildComponentsString(task.taskComponents[action.id]),
  //       );
  //   }
  // }

  buildComponentsString(List<TaskComponent>? taskComponent) {
    var string = '';
    taskComponent?.forEach((element) {
      string =
          string + ' ' + _typeState.getAssetTypeById(element.productId)!.name;
    });
    return string.trim();
  }
}
