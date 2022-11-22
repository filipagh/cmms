import 'package:BackendAPI/api.dart' as schema;
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/component_picker.dart';
import 'package:open_cmms/widgets/forms/tasks/create_change_components_task.dart';

import '../../../states/station/components_state.dart';

class EditStationComponentsForm extends StatelessWidget implements hasFormTitle {
  final schema.StationSchema station;

  EditStationComponentsForm(
      {Key? key, required this.station})
      : super(key: key);

  String getTitle() {
    return "Zmena komponentov v stanici: ${station.name}";
  }

  @override
  Widget getInstance() {
    return this;
  }

  RxList<FormItem> items = <FormItem>[].obs;
  final AssignedComponentsState _assignedComponentState = Get.find();
  final AssetTypesState _assets = Get.find();

  @override
  Widget build(BuildContext context) {
    setEditItems();
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                showFormDialog<AssetSchema>(ComponentPickerForm())
                    .then((value) {
                  items.insert(0, FormItem(value!.id));
                });
              },
              child: Text('Pridat komponent')),
          Container(
            width: 500,
            height: 600,
            child: Obx(() {
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCardFromFormItem(items[index]);
                  });
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Back")),
                ],
              ),
              Row(
                children: [
                  Obx(() {
                    return Row(
                      children: [
                        Text("added: " + getNewItems().length.toString()),
                        VerticalDivider(),
                        Text(
                            "removed: " + getToRemoveItems().length.toString()),
                        VerticalDivider(),
                      ],
                    );
                  }),
                  ElevatedButton(
                      onPressed: () {
                        List<TaskComponentAddNewSchema> add = [];

                        getNewItems().forEach((element) {
                          add.add(TaskComponentAddNewSchema(newAssetId: element.assetId));
                        });

                        List<TaskComponentRemoveNewSchema> remove = [];
                        getToRemoveItems().forEach((element) {
                          remove.add(TaskComponentRemoveNewSchema(assignedComponentId: element.assignedComponentId!));
                        });


                        Get.back();
                        showFormDialog(CreateChangeComponentsTaskForm(station: station, add: add, remove: remove));
                      },
                      child: Text("submit")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<FormItem> getNewItems() {
    return items
        .where((element) => element.status == FormItemStatus.nowadded)
        .toList();
  }

  List<FormItem> getToRemoveItems() {
    return items
        .where((element) => element.status == FormItemStatus.nowremoved)
        .toList();
  }

  Card buildCardFromFormItem(FormItem item) {
    switch (item.status) {
      case FormItemStatus.instaled:
        return Card(
          color: Colors.white,
          child: ListTile(
            trailing: IconButton(
              onPressed: () => removeItem(item),
              icon: Icon(Icons.delete),
            ),
            title: Text(_assets.getAssetById(item.assetId)!.name),
          ),
        );
      case FormItemStatus.tobeinstaled:
        return Card(
          color: Colors.green[200],
          child: ListTile(
            title: Text(_assets.getAssetById(item.assetId)!.name),
          ),
        );
      case FormItemStatus.toberemoved:
        return Card(
          color: Colors.red[200],
          child: ListTile(
            title: Text(_assets.getAssetById(item.assetId)!.name),
          ),
        );
      case FormItemStatus.nowadded:
        return Card(
          color: Colors.green[400],
          child: ListTile(
            trailing: IconButton(
              onPressed: () => removeNowAddedItem(item),
              icon: Icon(Icons.close),
            ),
            title: Text(_assets.getAssetById(item.assetId)!.name),
          ),
        );
      case FormItemStatus.nowremoved:
        return Card(
          color: Colors.red[400],
          child: ListTile(
            trailing: IconButton(
              onPressed: () => rollBackRemove(item),
              icon: Icon(Icons.rotate_left),
            ),
            title: Text(_assets.getAssetById(item.assetId)!.name),
          ),
        );
    }
  }

  void setEditItems() {
    _assignedComponentState.components.forEach((element) {
      var status;
      switch (element.status) {
        case schema.AssignedComponentState.awaiting:
          status = FormItemStatus.tobeinstaled;
          break;
        case schema.AssignedComponentState.installed:
          status = FormItemStatus.instaled;
          break;
        case schema.AssignedComponentState.willBeRemoved:
          status = FormItemStatus.toberemoved;
          break;
        case schema.AssignedComponentState.removed:
          return;
      }
      items.add(FormItem.installed(element, status));
    });
  }

  removeItem(FormItem item) {
    item.status = FormItemStatus.nowremoved;
    items.refresh();
  }

  removeNowAddedItem(FormItem item) {
    items.remove(item);
  }

  rollBackRemove(FormItem item) {
    item.status = FormItemStatus.instaled;
    items.refresh();
  }
}

enum FormItemStatus {
  instaled,
  tobeinstaled,
  toberemoved,
  nowadded,
  nowremoved
}

class FormItem {
  late String? assignedComponentId;
  late String assetId;
  late FormItemStatus status;

  FormItem.new(this.assetId) {
    status = FormItemStatus.nowadded;
  }

  FormItem.installed(
      schema.AssignedComponentSchema assignedComponent, this.status) {
    assignedComponentId = assignedComponent.id;
    assetId = assignedComponent.assetId;
  }
}