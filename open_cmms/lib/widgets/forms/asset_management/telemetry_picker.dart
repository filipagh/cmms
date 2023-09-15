import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/asset_telemetry_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class TelemetryPickerForm extends StatelessWidget implements PopupForm {
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
  Widget getContent() {
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
                  child: Text("pokracovat")),
            ],
          )
        ],
      );
    });

  }
}
