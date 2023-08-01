import 'package:BackendAPI/api.dart' as schema;
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/component_picker.dart';
import 'package:open_cmms/widgets/forms/components/serial_number_form.dart';
import 'package:open_cmms/widgets/forms/util/date_utils.dart';

import '../../../states/station/components_state.dart';

class SetStationComponentsForm extends StatelessWidget implements hasFormTitle {
  final schema.StationSchema station;

  SetStationComponentsForm.editComponentsInStation(
      {Key? key, required this.station})
      : super(key: key) {
    _assignedComponentState = Get.find(tag: station.id);
  }

  String getTitle() {
    return "Zmena komponentov v stanici: ${station.name}";
  }

  @override
  Widget getInstance() {
    return this;
  }

  RxList<FormItem> items = <FormItem>[].obs;
  late AssignedComponentsState _assignedComponentState;
  final AssetTypesState _assets = Get.find();
  final TextEditingController warrantyDate = TextEditingController();
  final TextEditingController removeDate = TextEditingController();
  final TextEditingController installDate = TextEditingController();
  final TextEditingController warrantyDays = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? warrantyPeriodDays;

  updateWarranty(DateTime newDate, {bool updateDays = true}) {
    warrantyDate.text = newDate.toIso8601String().split("T").first;
    var now = DateTime.parse(installDate.text);
    var delta =
        newDate.difference(DateTime(now.year, now.month, now.day)).inDays;
    if (updateDays) {
      warrantyDays.text = delta.toString();
    }
    warrantyPeriodDays = delta;
    _formKey.currentState!.validate();
  }

  updateWarrantyDays(int days) {
    updateWarranty(DateTime.parse(installDate.text).add(Duration(days: days)),
        updateDays: false);
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
                      showFormDialog<AssetSchema>(ComponentPickerForm(
                        hideArchivedAssets: false,
                      )).then((asset) {
                        if (asset != null) {
                          showFormDialog(SerialNumberForm(asset: asset)).then(
                              (serialNumber) => items.insert(
                                  0, FormItem(asset.id, serialNumber)));
                        }
                      });
                    },
                    child: const Text('Pridat komponent')),
                SizedBox(
                  width: 500,
                  height: Get.height - 500,
                  child: Obx(() {
                    return ListView.builder(
                        // shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildCardFromFormItem(items[index]);
                        });
                  }),
                ),
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Čas instalacie komponentov"),
                  controller: installDate,
                  validator: (v) {
                    return v == null || v.isEmpty ? "zvolte datum" : null;
                  },
                  onTap: () {
                    var now = DateTime.now();
                    showDatePicker(
                        context: context,
                            firstDate:
                                now.subtract(const Duration(days: 365 * 10)),
                            lastDate: now,
                            initialDate: now)
                        .then((value) {
                      installDate.text =
                          value!.toIso8601String().split("T").first;
                    });
                  },
                )),
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
                                        firstDate:
                                            DateTime.parse(installDate.text),
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
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Čas odstranenia komponentov"),
                  controller: removeDate,
                  onTap: () {
                    var now = DateTime.now();
                    showDatePicker(
                        context: context,
                            firstDate:
                                now.subtract(const Duration(days: 365 * 10)),
                            lastDate: now,
                            initialDate: now)
                        .then((value) {
                      removeDate.text =
                          value!.toIso8601String().split("T").first;
                    });
                  },
                )),
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
                                serialNumber: element.serialNumber));
                          });
                          var add = false;
                          var remove = false;
                          if (col.isNotEmpty) {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            add = true;
                          }
                          List<schema.AssignedComponentIdSchema> colr = [];
                          getToRemoveItems().forEach((element) {
                            colr.add(schema.AssignedComponentIdSchema(
                                id: element.assignedComponentId!));
                          });
                          if (colr.isNotEmpty) {
                            if (removeDate.value.text.isEmpty) {
                              showError(
                                  "vyplnte datum odstranenia komponentov");
                              return;
                            }
                            remove = true;
                          }

                          if (add) {
                            AssignedComponentService()
                                .createInstalledComponentAssignedComponentsCreateInstalledComponentPost(
                                    warrantyPeriodDays!,
                                    convertDatetimeToUtc(
                                        DateTime.parse(installDate.value.text)),
                                    col);
                          }
                          if (remove) {
                            AssignedComponentService()
                                .removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(
                                    convertDatetimeToUtc(
                                        DateTime.parse(removeDate.value.text)),
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
    const String serialNumberPrefix = "sériové číslo: ";
    var noSerialNumber = "žiadné sériové číslo";
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
              subtitle: Text(
                  serialNumberPrefix + (item.serialNumber ?? noSerialNumber))),
        );
      case FormItemStatus.tobeinstaled:
        return Card(
          color: Colors.green[200],
          child: ListTile(
              title: Text(_assets.getAssetById(item.assetId)!.name),
              subtitle: Text(
                  serialNumberPrefix + (item.serialNumber ?? noSerialNumber))),
        );
      case FormItemStatus.toberemoved:
        return Card(
          color: Colors.red[200],
          child: ListTile(
              title: Text(_assets.getAssetById(item.assetId)!.name),
              subtitle: Text(
                  serialNumberPrefix + (item.serialNumber ?? noSerialNumber))),
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
              subtitle: Text(
                  serialNumberPrefix + (item.serialNumber ?? noSerialNumber))),
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
            subtitle: Text(
                serialNumberPrefix + (item.serialNumber ?? noSerialNumber)),
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
  late String? serialNumber;

  FormItem.new(this.assetId, this.serialNumber) {
    status = FormItemStatus.nowadded;
  }

  FormItem.installed(
      schema.AssignedComponentSchema assignedComponent, this.status) {
    assignedComponentId = assignedComponent.id;
    assetId = assignedComponent.assetId;
    serialNumber = assignedComponent.serialNumber;
  }
}
