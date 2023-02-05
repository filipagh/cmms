import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/asset_telemetry_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class TelemetryPickerForm extends StatelessWidget implements hasFormTitle {
  TelemetryPickerForm({Key? key}) : super(key: key) {
    AssetTelemetryState _telemetryState = Get.find();
    options = _telemetryState.options.value;
    selectedType = options.types.first.obs;
    selectedValue = options.values.first.obs;
  }

  late TelemetryOptions options;
  late Rx<AssetTelemetryType> selectedType;
  late Rx<AssetTelemetryValue> selectedValue;

  String getTitle() {
    return "Vybrat telemetriu";
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton<AssetTelemetryType>(
            value: selectedType.value,
            items: options.types
                .map((e) => DropdownMenuItem<AssetTelemetryType>(
                      value: e,
                      child: Text(e.value),
                    ))
                .toList(),
            onChanged: (v) {
              selectedType.value = v!;
            },
          ),
          DropdownButton<AssetTelemetryValue>(
            value: selectedValue.value,
            items: options.values
                .map((e) => DropdownMenuItem<AssetTelemetryValue>(
                      value: e,
                      child: Text(e.value),
                    ))
                .toList(),
            onChanged: (v) {
              selectedValue.value = v!;
            },
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
                      child: Text("spat")),
                  ElevatedButton(
                      onPressed: () {
                        Get.back(
                            result: AssetTelemetry(
                                type: selectedType.value,
                                value: selectedValue.value));
                      },
                      child: Text("pokracovat"))
                ],
              ),
            ],
          )
        ],
      );
    });

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
