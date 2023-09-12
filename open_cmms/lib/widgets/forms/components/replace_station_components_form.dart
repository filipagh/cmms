import 'package:BackendAPI/api.dart' as schema;
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/set_new_component_warranty_form.dart';
import 'package:open_cmms/widgets/forms/tasks/create_change_components_task.dart';

import '../../../service/backend_api/assigned_components_service.dart';
import '../../../states/station/components_state.dart';

class ReplaceStationComponentsForm extends StatelessWidget
    implements hasFormTitle {
  final schema.StationSchema station;

  ReplaceStationComponentsForm({Key? key, required this.station})
      : super(key: key) {
    try {
      _assignedComponentState = Get.find(tag: station.id);
      setEditItems(_assignedComponentState);
    } catch (e) {
      Get.putAsync(() => AssignedComponentsState(station.id).load(),
              tag: station.id)
          .then((value) => setEditItems(value));
    }
  }

  String getTitle() {
    return "Zmena komponentov v stanici: ${station.name}";
  }

  @override
  Widget getInstance() {
    return this;
  }

  RxList<FormItem> items = <FormItem>[].obs;

  late final AssignedComponentsState _assignedComponentState;
  final AssetTypesState _assets = Get.find();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Column(
        children: [
          // ElevatedButton(
          //     onPressed: () {
          //       showFormDialog<AssetSchema>(ComponentPickerForm())
          //           .then((value) {
          //         items.insert(0, FormItem(value!));
          //       });
          //     },
          //     child: Text('Pridat komponent')),
          Container(
            width: 500,
            height: Get.height - 300,
            child: Obx(() {
              var list = items.value;
              list.sort((a, b) => a.asset.name.compareTo(b.asset.name));
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return buildCardFromFormItem(list[index]);
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
                      child: Text("spať")),
                ],
              ),
              Row(
                children: [
                  Obx(() {
                    bool hasChange =
                        getNewItems().length + getToRemoveItems().length > 0;
                    return Row(
                      children: [
                        Text("pridane: " + getNewItems().length.toString()),
                        VerticalDivider(),
                        Text("odstranene: " +
                            getToRemoveItems().length.toString()),
                        VerticalDivider(),
                        ElevatedButton(
                            onPressed: !hasChange
                                ? null
                                : () async {
                                    List<TaskComponentAddNewSchema> add = [];

                                    var newItems = getNewItems();

                                    newItems.forEach((element) async {
                                      add.add(TaskComponentAddNewSchema(
                                          newAssetId: element.asset.id,
                                          warranty: element.warranty,
                                          serviceContractsId:
                                              (await ServiceContractService()
                                                          .getServiceContractContractsForComponentGet(
                                                              element
                                                                  .assignedComponent
                                                                  .id))
                                                      ?.map((e) => e.id)
                                                      .toList() ??
                                                  []));
                                    });

                                    List<TaskComponentRemoveNewSchema> remove =
                                        [];
                                    getToRemoveItems().forEach((element) {
                                      remove.add(TaskComponentRemoveNewSchema(
                                          assignedComponentId:
                                              element.assignedComponent!.id));
                                    });

                                    var result = await showFormDialog(
                                        CreateChangeComponentsTaskForm(
                                            station: station,
                                            add: add,
                                            remove: remove));
                                    if (result != null) {
                                      Get.back(result: result);
                                    }
                                  },
                            child: Text("pokračovať"))
                      ],
                    );
                  }),
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
    const String serialNumberPrefix = "sériové číslo: ";
    var noSerialNumber = "žiadné sériové číslo";
    var serialNumberWillAddTechnic = "sériové číslo bude pridané technikom";
    switch (item.status) {
      case FormItemStatus.instaled:
        return Card(
          color: Colors.white,
          child: ListTile(
            trailing: IconButton(
              onPressed: () => removeItem(item),
              icon: Icon(Icons.refresh),
            ),
            title: Text(_assets.getAssetById(item.asset.id)!.name),
            subtitle: Text(serialNumberPrefix +
                (item.assignedComponent!.serialNumber ?? noSerialNumber)),
          ),
        );
      case FormItemStatus.tobeinstaled:
        return Card(
          color: Colors.green[200],
          child: ListTile(
            title: Text(item.asset.name),
            subtitle: Text(serialNumberPrefix +
                (item.assignedComponent!.serialNumber ??
                    serialNumberWillAddTechnic)),
          ),
        );
      case FormItemStatus.toberemoved:
        return Card(
          color: Colors.red[200],
          child: ListTile(
            title: Text(item.asset.name),
            subtitle: Text(serialNumberPrefix +
                (item.assignedComponent!.serialNumber ?? noSerialNumber)),
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
            title: Text(item.asset.name),
            subtitle: Text(serialNumberPrefix +
                (item.assignedComponent?.serialNumber ??
                    serialNumberWillAddTechnic)),
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
              title: Text(item.asset.name),
              subtitle: Text(serialNumberPrefix +
                  (item.assignedComponent!.serialNumber ?? noSerialNumber))),
        );
    }
  }

  void setEditItems(AssignedComponentsState state) {
    state.components.forEach((element) {
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
      items.add(FormItem.installed(
          element, status, _assets.getAssetById(element.assetId)!));
    });
  }

  removeItem(FormItem item) async {
    item.status = FormItemStatus.nowremoved;
    var warranty = await AssignedComponentService()
        .getReplacmentWarrantyAssignedComponentsReplacmentWarranryGet(
            componentId: item.assignedComponent.id);
    await showFormDialog(SetNewComponentWarrantyForm(
      suggestedWarranty: warranty,
    ));
    items.insert(items.indexOf(item), FormItem(item.asset, item, warranty!));
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
  late AssignedComponentSchema assignedComponent;
  late AssetSchema asset;
  late FormItemStatus status;
  late ComponentWarranty warranty;

  FormItem.new(this.asset, FormItem replace, this.warranty) {
    status = FormItemStatus.nowadded;
    assignedComponent = replace.assignedComponent;
  }

  FormItem.installed(this.assignedComponent, this.status, this.asset) {
    warranty = ComponentWarranty(
        componentWarrantyUntil: assignedComponent.componentWarrantyUntil,
        componentWarrantySource: assignedComponent.componentWarrantySource,
        componentWarrantyId: assignedComponent.componentWarrantyId,
        componentPrepaidServiceUntil: assignedComponent.prepaidServiceUntil,
        componentTechnicalWarrantyId: assignedComponent.serviceContractId,
        componentTechnicalWarrantyUntil: assignedComponent.serviceContractUntil,
        componentWarrantyDays: 0,
        componentPrepaidServiceDays: 0);
  }
}
