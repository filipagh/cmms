import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/models/assigned_component.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/assigned_component_state.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../models/item.dart';

class StationComponentsForm extends StatefulWidget implements hasFormTitle {
  late final Station station;

  StationComponentsForm.editComponents({Key? key, required Station editItem})
      : super(key: key) {
    this.station = editItem;
  }

  @override
  State<StationComponentsForm> createState() => StationComponentsFormState();

  String getTitle() {
    return "Edit components of : ${station.name}";
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
  List<Item> additems = [];
  List<AssignedComponent> removeComponents = [];
  List<FormItem> editItems = <FormItem>[].obs;

  @override
  void initState() {
    actualComponents = _assignedComponentState
            .components[widget.station.id]?.values
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
            ElevatedButton(onPressed: () {}, child: Text('add component')),
            Container(
              width: 500,
              height: 600,
              child: Obx(() {
                return ListView.builder(
                    itemCount: editItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildCardFromFormItem(editItems[index]);
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

            TextButton(
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
      ),
    );
  }

  Card buildCardFromFormItem(FormItem item) {
    switch (item.status) {
      case FormItemStatus.instaled:
        return Card(
          color: Colors.white,
          child: ListTile(
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
            title: Text(item.assetType.name),
          ),
        );
      case FormItemStatus.nowremoved:
        return Card(
          color: Colors.red[400],
          child: ListTile(
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
      editItems.add(FormItem(element.productId, status));
    });
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
  final AssetTypesState _assetTypesState = Get.find();
  late String productId;
  late FormItemStatus status;
  late AssetType assetType;

  FormItem(this.productId, this.status) {
    assetType = _assetTypesState.getAssetTypeById(productId)!;
  }
}
