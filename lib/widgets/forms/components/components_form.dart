import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/aggregates/task.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/models/assigned_component.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/assigned_component_state.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/add_component.dart';

import '../../../models/item.dart';

class StationComponentsForm extends StatefulWidget implements hasFormTitle {
  late final TaskAggregate task;



  StationComponentsForm.editComponentsInStation({Key? key, required Station editItem})
      : super(key: key) {
    this.task = TaskAggregate(editItem);
  }
  StationComponentsForm.editComponentsInTask({Key? key, required TaskAggregate task})
      : super(key: key) {
    this.task = task;
  }

  @override
  State<StationComponentsForm> createState() => StationComponentsFormState();

  String getTitle() {
    return "Edit components of : ${task.station.name}";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class StationComponentsFormState extends State<StationComponentsForm> {
  final _formKey = GlobalKey<FormState>();
  final AssignedComponentState _assignedComponentState = Get.find();
  final ItemsState _itemsState = Get.find();
  List<AssignedComponent> actualComponents = [];
  List<Item> additems = <Item>[].obs;
  List<AssignedComponent> removeComponents = <AssignedComponent>[].obs;
  final _ComponentFormState _componentFormState = Get.put(_ComponentFormState());

  @override
  void initState() {
    actualComponents = _assignedComponentState
            .components[widget.task.station.id]?.values
            .toList() ??
        [];
    this.buildEditItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showFormDialog<Item>(
                          AddComponentForm(editItem: widget.task.station))
                      .then((value) {
                    _componentFormState.addNewComponent(value!.productId);
                    additems.add(value);
                  });
                },
                child: Text('add component')),
            Container(
              width: 500,
              height: 600,
              child: GetBuilder<_ComponentFormState>(builder: (_) {
                return ListView.builder(
                    itemCount: _.editItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCardFromFormItem(_.editItems[index]);
                    });
              }),
            ),
            // TextFormField(
            //   onSaved: (value) {
            //     name = value!;
            //   },
            //   initialValue:
            //       widget.editItem == null ? "" : widget.editItem!.name,
            //   decoration: InputDecoration(labelText: 'name'),
            //   validator: (value) {
            //     return value == null || value.isEmpty ? "add name" : null;
            //   },
            // ),
            // TextFormField(
            //   onSaved: (value) {
            //     description = value!;
            //   },
            //   initialValue:
            //       widget.editItem == null ? "" : widget.editItem!.text,
            //   decoration: InputDecoration(labelText: 'description'),
            // ),
            // TextFormField(
            //   onSaved: (value) {
            //     ssud = value!;
            //   },
            //   initialValue:
            //       widget.editItem == null ? "" : widget.editItem!.ssud,
            //   decoration: InputDecoration(labelText: 'ssud'),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  ElevatedButton(onPressed: () {Get.back();}, child: Text("Back")),
                ],),
                Row(

                  children: [
                    Obx(() {
                      return Row(children: [
                      Text("added: "+additems.length.toString()),
                      VerticalDivider(),
                      Text("removed: "+removeComponents.length.toString()),
                      VerticalDivider(),
                      ],);
                    }),
                    ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          //   _formKey.currentState?.save();
                          //   if (widget.editItem != null) {
                          //     widget._roadSegmentState.editRoadSegment(widget.editItem!.id, name, description,ssud);
                          //   } else {
                          //     widget._roadSegmentState.createNewRoadSegment( name, description,ssud);
                          //   }
                          //   Get.back();
                          // }
                        },
                        child: Text("submit")),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card buildCardFromFormItem(FormItem item) {
    switch (item.status) {
      case FormItemStatus.instaled:
        return Card(
          color: Colors.white,
          child: ListTile(
            trailing: IconButton(onPressed: ()=>removeItem(item), icon: Icon(Icons.delete),),
            title: Text(item.assetType.name),
          ),
        );
      case FormItemStatus.tobeinstaled:
        return Card(
          color: Colors.green[200],
          child: ListTile(
            title: Text(item.assetType.name),
          ),
        );
      case FormItemStatus.toberemoved:
        return Card(
          color: Colors.red[200],
          child: ListTile(
            title: Text(item.assetType.name),
          ),
        );
      case FormItemStatus.nowadded:
        return Card(
          color: Colors.green[400],
          child: ListTile(
            trailing: IconButton(onPressed: ()=>removeNowAddedItem(item), icon: Icon(Icons.close),),
            title: Text(item.assetType.name),

          ),
        );
      case FormItemStatus.nowremoved:
        return Card(
          color: Colors.red[400],
          child: ListTile(
            trailing: IconButton(onPressed: ()=>rollBackRemove(item), icon: Icon(Icons.rotate_left),),
            title: Text(item.assetType.name),
          ),
        );
    }
  }

  void buildEditItems() {
    this.actualComponents.forEach((element) {
      var status;
      switch (element.actualState) {

        case AssignedComponentStateEnum.awaiting:
          status = FormItemStatus.tobeinstaled;
          break;
        case AssignedComponentStateEnum.installed:
          status = FormItemStatus.instaled;
          break;
        case AssignedComponentStateEnum.willBeRemoved:
          status = FormItemStatus.toberemoved;
          break;
        case AssignedComponentStateEnum.removed:
          return;
      }
      _componentFormState.addInstalledComponent(element.productId, status, element);
    });
  }

  removeItem(FormItem item) {
    removeComponents.add(item.assignedComponent!);
    _componentFormState.removeItem(item);

  }

  removeNowAddedItem(FormItem item) {
    additems.remove(_itemsState.getById(item.productId));
    _componentFormState.removeNowAddedItem(item);
  }

  rollBackRemove(FormItem item) {
    removeComponents.remove(item.assignedComponent!);
    _componentFormState.rollbackItem(item);

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
  late int id;
  final AssetTypesState _assetTypesState = Get.find();
  late String productId;
  late AssignedComponent? assignedComponent;
  late FormItemStatus status;
  late AssetType assetType;

  FormItem(this.id, this.productId, this.status, [this.assignedComponent]) {
    assetType = _assetTypesState.getAssetTypeById(productId)!;
  }
}



class _ComponentFormState extends GetxController {
  List<FormItem> editItems = <FormItem>[].obs;
  int _sequence = 0;

  void removeItem(FormItem item) {
    editItems[editItems.indexWhere((element) => element.id == item.id)].status=FormItemStatus.nowremoved;
    update();
  }

  void addInstalledComponent(
      String productId, status, AssignedComponent element) {
    editItems.add(FormItem(_sequence, productId, status, element));
    _sequence++;
  }

  void addNewComponent(String productId) {
    editItems.add(FormItem(_sequence, productId, FormItemStatus.nowadded));
    _sequence++;
    update();
  }

  void rollbackItem(FormItem item) {
    editItems[editItems.indexWhere((element) => element.id == item.id)].status=FormItemStatus.instaled;
    update();
  }

  void removeNowAddedItem(FormItem item) {
    editItems.removeWhere((element) => element.id == item.id);
    update();
  }
}