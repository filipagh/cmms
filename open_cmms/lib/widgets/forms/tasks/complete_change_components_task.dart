import 'package:BackendAPI/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/serial_number_form.dart';

import '../../../snacbars.dart';
import '../../../states/station/components_state.dart';

class CompleteChangeComponentsTaskForm extends StatelessWidget
    implements hasFormTitle {
  String stationId;
  TaskChangeComponentsSchema task;
  final AssetTypesState _assets = Get.find();

  late AssignedComponentsState components;
  final List<TaskChangeComponentRequestCompleted> completedItems =
      <TaskChangeComponentRequestCompleted>[].obs;

  CompleteChangeComponentsTaskForm(
      {Key? key, required this.stationId, required this.task})
      : super(key: key) {
    try {
      components = Get.find();
    } catch (e) {
      components = Get.put(AssignedComponentsState(stationId));
    }
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  String getTitle() {
    return "Dokoncenie ulohy: ${task.name}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 600, width: 500, child: buildComponentsEditList()),
        // Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Zrusit")),
            ElevatedButton(
                onPressed: () {
                  TasksService()
                      .completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPost(
                          task.id, completedItems)
                      .then((value) {
                    Get.back();
                    showOk("komponenty boli zmenené");
                  });
                },
                child: Text("Dokoncit ulohu")),
          ],
        )
      ],
    );
  }

  Widget buildComponentsEditList() {
    return Obx(() {
      return ListView(children: buildActionsTiles());
    });
  }

  List<Widget> buildActionsTiles() {
    List<Widget> tiles = [];
    tiles.add(ListTile(
      title: Text("Pridat komponenty:"),
    ));
    task.add.forEach((element) {
      if (element.state == TaskComponentState.installed) {
        return;
      }
      var assetSchema = _assets.getAssetById(element.newAssetId);
      TaskChangeComponentRequestCompleted? asDoneObject =
          completedItems.firstWhereOrNull((item) => item.id == element.id);
      tiles.add(ListTile(
        title: Text(assetSchema!.name),
        subtitle: asDoneObject != null
            ? Text("sériové čislo: " + (asDoneObject.serialNumber ?? ""))
            : null,
        selectedTileColor: Colors.green[200],
        selected: asDoneObject != null,
        onTap: element.state != TaskComponentState.allocated
            ? null
            : () async {
                if (asDoneObject != null) {
                  completedItems.remove(asDoneObject);
                } else {
                  completedItems.add(TaskChangeComponentRequestCompleted(
                      id: element.id,
                      serialNumber: await showFormDialog(
                          SerialNumberForm(asset: assetSchema))));
                }
                completedItems.obs.refresh();
              },
      ));
    });

    tiles.add(ListTile(
      title: Text("Odobrat komponenty:"),
    ));
    task.remove.forEach((element) {
      if (element.state == TaskComponentState.removed) {
        return;
      }
      tiles.add(GetBuilder<AssignedComponentsState>(
        tag: stationId,
        builder: (_components) {
          var title = "";
          final comp = _components.getById(element.assignedComponentId);
          if (comp == null)
            title = "loading...";
          else {
            final asset = _assets.getAssetById(comp.assetId);
            if (asset == null)
              title = "loading...";
            else
              title = asset.name;
          }
          TaskChangeComponentRequestCompleted? asDoneObject =
              completedItems.firstWhereOrNull((item) => element.id == item.id);

          return ListTile(
            title: Text(title),
            subtitle: Text("sériové čislo: " + (comp?.serialNumber ?? "")),
            selectedTileColor: Colors.green[200],
            selected: asDoneObject != null,
            onTap: element.state != TaskComponentState.installed
                ? null
                : () {
                    if (asDoneObject != null) {
                      completedItems.remove(asDoneObject);
                    } else {
                      completedItems.add(
                          TaskChangeComponentRequestCompleted(id: element.id));
                    }

                    completedItems.obs.refresh();
                  },
          );
        },
      ));
    });

    return tiles;
  }

  buildComponentsString(Iterable<String> assetsIds) {
    List<String> string = [];
    if (assetsIds.isEmpty) {
      return "Nic";
    }
    assetsIds.forEach((element) {
      string.add(_assets.getAssetById(element)!.name);
    });
    return string.join(", ");
  }
}
