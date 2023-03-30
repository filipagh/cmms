import 'package:BackendAPI/api.dart' as schema;
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/component_picker.dart';

import '../../../states/station/components_state.dart';

class SetStationComponentsForm extends StatelessWidget implements hasFormTitle {
  final schema.StationSchema station;

  SetStationComponentsForm.editComponentsInStation(
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
  final TextEditingController warrantyDate = TextEditingController();
  final TextEditingController warrantyDays = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? warrantyPeriodDays;

  updateWarranty(DateTime newDate, {bool updateDays = true}) {
    warrantyDate.text = newDate.toIso8601String().split("T").first;
    var now = DateTime.now();
    var delta =
        newDate.difference(DateTime(now.year, now.month, now.day)).inDays;
    if (updateDays) {
      warrantyDays.text = delta.toString();
    }
    warrantyPeriodDays = delta;
    _formKey.currentState!.validate();
  }

  updateWarrantyDays(int days) {
    updateWarranty(DateTime.now().add(Duration(days: days)), updateDays: false);
  }

  @override
  Widget build(BuildContext context) {
    setEditItems();
    // return ConstrainedBox(
    //   constraints: BoxConstraints(maxWidth: Get.width - 200, maxHeight: Get.height),
    //   child: Column(children: [

    // child: Column(
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showFormDialog<AssetSchema>(const ComponentPickerForm())
                          .then((value) {
                        items.insert(0, FormItem(value!.id));
                      });
                    },
                    child: const Text('Pridat komponent')),
                SizedBox(
                  width: 500,
                  height: Get.height - 300,
                  child: Obx(() {
                    return ListView.builder(
                        // shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildCardFromFormItem(items[index]);
                        });
                  }),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: "Zaruka do"),
                              controller: warrantyDate,
                              validator: (v) {
                                return v == null || v.isEmpty
                                    ? "zvolte datum"
                                    : null;
                              },
                              onTap: () {
                                var now = DateTime.now();
                                showDatePicker(
                                        context: context,
                                        firstDate: now,
                                        lastDate: now.add(
                                            const Duration(days: 365 * 20)),
                                        initialDate: DateTime(
                                            now.year + 2, now.month, now.day))
                                    .then((value) {
                                  updateWarranty(value!);
                                });
                              },
                            )),
                            const Spacer(),
                            Expanded(
                                child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: "Pocet dni na zaruku"),
                              validator: (v) {
                                return v == null || v.isEmpty
                                    ? "zvolte pocet dni"
                                    : null;
                              },
                              onChanged: (v) {
                                updateWarrantyDays(int.parse(v));
                              },
                              controller: warrantyDays,
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Back")),
                  ],
                ),
                Row(
                  children: [
                    Obx(() {
                      return Row(
                        children: [
                          Text("added: " + getNewItems().length.toString()),
                          const VerticalDivider(),
                          Text("removed: " +
                              getToRemoveItems().length.toString()),
                          const VerticalDivider(),
                        ],
                      );
                    }),
                    ElevatedButton(
                        onPressed: () {
                          List<schema.AssignedComponentNewSchema> col = [];
                          getNewItems().forEach((element) {
                            col.add(schema.AssignedComponentNewSchema(
                                assetId: element.assetId,
                                stationId: station.id,
                                serialNumber: "123"));
                          });
                          if (col.isNotEmpty) {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            AssignedComponentService()
                                .createInstalledComponentAssignedComponentsCreateInstalledComponentPost(
                                    warrantyPeriodDays!, col);
                          }
                          List<schema.AssignedComponentIdSchema> colr = [];
                          getToRemoveItems().forEach((element) {
                            colr.add(schema.AssignedComponentIdSchema(
                                id: element.assignedComponentId!));
                          });
                          if (colr.isNotEmpty) {
                            AssignedComponentService()
                                .removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(
                                    colr);
                          }

                          Get.back();
                        },
                        child: const Text("submit")),
                  ],
                ),
              ],
            ),
          )
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
              icon: const Icon(Icons.delete),
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
              icon: const Icon(Icons.close),
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
              icon: const Icon(Icons.rotate_left),
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
