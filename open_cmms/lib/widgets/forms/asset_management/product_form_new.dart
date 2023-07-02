import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/telemetry_picker.dart';

import '../../../states/asset_types_state.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class ProductFormNew extends StatefulWidget implements hasFormTitle {
  final AssetTypesState assetTypes = Get.find();

  late final AssetCategorySchema parent;
  final List<AssetTelemetry> telemetry = <AssetTelemetry>[].obs;

  ProductFormNew({Key? key, required this.parent}) : super(key: key);

  @override
  State<ProductFormNew> createState() => ProductFormNewState();

  String getTitle() {
    return "Vytvoriť nový produkt";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class ProductFormNewState extends State<ProductFormNew> {
  final AssetTypesState assetTypes = Get.find();
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String description = "";

  late AssetCategorySchema _mainCat;
  AssetCategorySchema? _subCat;

  @override
  void initState() {
    _mainCat = widget.parent.parentId == null
        ? widget.parent
        : assetTypes.getAssetTypeById(widget.parent.parentId!)!;
    if (_mainCat != widget.parent) {
      _subCat = widget.parent;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onSaved: (value) {
                  name = value!;
                },
                decoration: const InputDecoration(labelText: 'názov'),
                validator: (value) {
                  return value == null || value.isEmpty ? "pridať názov" : null;
                },
              ),
              TextFormField(
                onSaved: (value) {
                  description = value!;
                },
                decoration: const InputDecoration(labelText: 'popis'),
              ),
              const Divider(),
              Text("Hlavna kategoria: " + _mainCat.name),
              Text("Vedlajsia kategoria: " + (_subCat?.name ?? "---")),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Telemetria: "),
                  ElevatedButton.icon(
                    onPressed: () async {
                      AssetTelemetry? telemetryItem =
                          await showFormDialog(TelemetryPickerForm());
                      if (telemetryItem != null) {
                        widget.telemetry.add(telemetryItem);
                      }
                    },
                    label: const Text("Pridat"),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
              Obx(() {
                return SizedBox(
                  width: 500,
                  height: Get.height - 400,
                  child: ListView.builder(
                    itemCount: widget.telemetry.length,
                    itemBuilder: (BuildContext context, int index) {
                      var t = widget.telemetry[index];
                      return Card(
                        child: ListTile(
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              widget.telemetry.removeAt(index);
                            },
                          ),
                          title: Center(
                              child:
                                  Text(t.type.value + "  |  " + t.value.value)),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("zrušiť")),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    Get.back();
                    assetTypes.createNewType(widget.parent.id, false,
                        widget.telemetry, name, description);
                  }
                },
                child: const Text("uložiť")),
          ],
        )
      ],
    );
  }
}
