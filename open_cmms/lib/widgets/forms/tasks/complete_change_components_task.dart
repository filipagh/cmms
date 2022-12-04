import 'package:BackendAPI/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/station/components_state.dart';

class CompleteChangeComponentsTaskForm extends StatelessWidget
    implements hasFormTitle {
  String stationId;
  TaskChangeComponentsSchema task;
  final AssetTypesState _assets = Get.find();

  late AssignedComponentsState components;
  final List<String> selectedItems = <String>[].obs;

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
                          task.id,
                          selectedItems
                              .map((e) => TaskChangeComponentRequestId(id: e))
                              .toList())
                      .then((value) => Get.back());
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
      tiles.add(ListTile(
        title: Text(_assets.getAssetById(element.newAssetId)!.name),
        selectedTileColor: Colors.green[200],
        selected: selectedItems.contains(element.id),
        onTap: element.state != TaskComponentState.allocated
            ? null
            : () {
                if (selectedItems.contains(element.id)) {
                  selectedItems.remove(element.id);
                } else {
                  selectedItems.add(element.id);
                }
                selectedItems.obs.refresh();
              },
      ));
    });

    tiles.add(ListTile(
      title: Text("Odobrat komponenty:"),
    ));
    task.remove.forEach((element) {
      tiles.add(ListTile(
        title: GetBuilder<AssignedComponentsState>(
            tag: stationId,
            builder: (_components) {
              final comp = _components.getById(element.assignedComponentId);
              if (comp == null) return const Text("loading...");
              final asset = _assets.getAssetById(comp.assetId);
              if (asset == null) return const Text("loading...");
              return Text(asset.name);
            }),
        selectedTileColor: Colors.green[200],
        selected: selectedItems.contains(element.id),
        onTap: element.state != TaskComponentState.installed
            ? null
            : () {
                if (selectedItems.contains(element.id)) {
                  selectedItems.remove(element.id);
                } else {
                  selectedItems.add(element.id);
                }
                selectedItems.obs.refresh();
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
