import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/telemetry_picker.dart';

import '../../../states/asset_types_state.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class ProductForm extends StatefulWidget implements hasFormTitle {
  final AssetTypesState assetTypes = Get.find();
  late final AssetSchema? editItem;
  late final AssetCategorySchema parent;
  final List<AssetTelemetry> telemetry = <AssetTelemetry>[].obs;

  ProductForm.createNew({Key? key, required this.parent}) : super(key: key) {
    editItem = null;
  }

  ProductForm.editItem({Key? key, this.editItem}) : super(key: key) {
    parent = assetTypes.getAssetTypeById(editItem!.categoryId)!;
  }

  @override
  State<ProductForm> createState() => ProductFormState();

  String getTitle() {
    return editItem == null
        ? "Vytvoriť nový produkt"
        : "Editovať produkt : ${editItem!.name}";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class ProductFormState extends State<ProductForm> {
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
    widget.telemetry.addAll(widget.editItem?.telemetry ?? []);
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
                initialValue:
                    widget.editItem == null ? "" : widget.editItem!.name,
                decoration: InputDecoration(labelText: 'názov'),
                validator: (value) {
                  return value == null || value.isEmpty ? "pridať názov" : null;
                },
              ),
              TextFormField(
                onSaved: (value) {
                  description = value!;
                },
                initialValue:
                    widget.editItem == null ? "" : widget.editItem!.name,
                decoration: InputDecoration(labelText: 'popis'),
              ),
              Divider(),
              Text("Hlavna kategoria: " + _mainCat.name),
              Text("Vedlajsia kategoria: " + (_subCat?.name ?? "---")),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Telemetria: "),
                  ElevatedButton.icon(
                    onPressed: () async {
                      AssetTelemetry telemetryItem =
                          await showFormDialog(TelemetryPickerForm());
                      widget.telemetry.add(telemetryItem);
                    },
                    label: Text("Pridat"),
                    icon: Icon(Icons.add),
                  )
                ],
              ),
              Obx(() {
                return SizedBox(
                  width: 500,
                  height: Get.height - 500,
                  child: ListView.builder(
                    itemCount: widget.telemetry.length,
                    itemBuilder: (BuildContext context, int index) {
                      var t = widget.telemetry[index];
                      return Card(
                        child: ListTile(
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
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
                child: Text("zrušiť")),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    if (widget.editItem != null) {
                      Get.back();
                      assetTypes.editType(
                          widget.editItem!.id, name, description);
                    } else {
                      Get.back();
                      assetTypes.createNewType(widget.parent.id, false,
                          widget.telemetry, name, description);
                    }
                  }
                },
                child: Text("uložiť")),
          ],
        )
      ],
    );
  }
}
