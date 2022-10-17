import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';
import 'package:open_cmms/states/items_state_dummy.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state.dart';
import '../../../states/items_state.dart';

class AddComponentForm extends StatelessWidget implements hasFormTitle {
  late final Station station;

  AddComponentForm({Key? key})
      : super(key: key);

  String getTitle() {
    return "Vybrat komponent";
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    AssetTypesState _assetTypes = Get.find();
    var items = _assetTypes.getAllProducts();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("searchbar"),

        SizedBox(height: 50, child: Placeholder()),
        SizedBox(
          width: 500,
          height: 600,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var i = items[index];
              return Card(
                child: ListTile(
                  onTap: () => Get.back(result: i),
                  title: Center(child: Text(i.name)),
                ),
              );
            },),
        )
      ],
    );

    //
    //   ConstrainedBox(
    //   constraints: BoxConstraints(maxWidth: 500),
    //   child: Form(
    //     key: _formKey,
    //     child: Column(
    //       children: [
    //         ElevatedButton(onPressed: () {}, child: Text('add component')),
    //         Container(
    //           width: 500,
    //           height: 600,
    //           child: Obx(() {
    //             return ListView.builder(
    //                 itemCount: editItems.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return buildCardFromFormItem(editItems[index]);
    //                 });
    //           }),
    //         ),
    //         // TextFormField(
    //         //   onSaved: (value) {
    //         //     name = value!;
    //         //   },
    //         //   initialValue:
    //         //       widget.editItem == null ? "" : widget.editItem!.name,
    //         //   decoration: InputDecoration(labelText: 'name'),
    //         //   validator: (value) {
    //         //     return value == null || value.isEmpty ? "add name" : null;
    //         //   },
    //         // ),
    //         // TextFormField(
    //         //   onSaved: (value) {
    //         //     description = value!;
    //         //   },
    //         //   initialValue:
    //         //       widget.editItem == null ? "" : widget.editItem!.text,
    //         //   decoration: InputDecoration(labelText: 'description'),
    //         // ),
    //         // TextFormField(
    //         //   onSaved: (value) {
    //         //     ssud = value!;
    //         //   },
    //         //   initialValue:
    //         //       widget.editItem == null ? "" : widget.editItem!.ssud,
    //         //   decoration: InputDecoration(labelText: 'ssud'),
    //         // ),
    //
    //         TextButton(
    //             onPressed: () {
    //               // if (_formKey.currentState!.validate()) {
    //               //   _formKey.currentState?.save();
    //               //   if (widget.editItem != null) {
    //               //     widget._roadSegmentState.editRoadSegment(widget.editItem!.id, name, description,ssud);
    //               //   } else {
    //               //     widget._roadSegmentState.createNewRoadSegment( name, description,ssud);
    //               //   }
    //               //   Get.back();
    //               // }
    //             },
    //             child: Text("submit")),
    //       ],
    //     ),
    //   ),
    // );
  }

}
