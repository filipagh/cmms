import 'package:BackendAPI/api.dart' as schema;
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class RemoveComponentToStationForm extends StatelessWidget
    implements hasFormTitle {
  final schema.StationSchema station;
  final schema.AssignedComponentSchema component;
  final AssetTypesState _assetTypes = Get.find();
  late AssetSchema asset = _assetTypes.getAssetById(component.assetId)!;

  RemoveComponentToStationForm(
      {Key? key, required this.station, required this.component})
      : super(key: key);

  @override
  String getTitle() {
    return "Odinštalovať komponent ${asset.name} na stanicu ${station.name}";
  }

  @override
  Widget getInstance() {
    return this;
  }

  Rxn<DateTime> uninstallDate = Rxn<DateTime>();
  var uninstallDateText = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: (TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Dátum odinstalacie komponentu",
                  ),
                  readOnly: true,
                  controller: uninstallDateText,
                  validator: (v) {
                    return (v == null || v.isEmpty) ? "zvoľte dátum" : null;
                  },
                  onTap: () {
                    var now = DateTime.now();
                    showDatePicker(
                            context: context,
                            firstDate:
                                now.subtract(const Duration(days: 365 * 20)),
                            lastDate: now,
                            initialDate: now)
                        .then((value) {
                      if (value == null) {
                        return;
                      }
                      uninstallDate.value = value;
                      uninstallDateText.text =
                          value.toIso8601String().split("T").first;
                    });
                  },
                ))),
              ],
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
                        child: const Text("Späť")),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          await AssignedComponentService()
                              .removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(
                                  uninstallDate.value!, [
                            AssignedComponentIdSchema(id: component.id)
                          ]);

                          Get.back(result: true);
                        },
                        child: const Text("odinštalovať")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
