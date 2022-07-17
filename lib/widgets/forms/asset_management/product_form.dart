import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../models/asset_type.dart';
import '../../../states/asset_types_state.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class ProductForm extends StatefulWidget implements hasFormTitle {
  final StateAssetTypes assetTypes = Get.find();
  late final AssetType? editItem;
  late final AssetType parent;

  ProductForm.createNew({Key? key, required this.parent}) : super(key: key) {
    this.editItem = null;
  }

  ProductForm.editItem({Key? key, required AssetType editItem})
      : super(key: key) {
    this.editItem = editItem;
    this.parent = assetTypes.getAssetTypeById(editItem.parent!)!;
  }

  @override
  State<ProductForm> createState() => ProductFormState();

  String getTitle() {
    return editItem == null
        ? "Create new Product"
        : "Edit Product : ${editItem!.name}";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class ProductFormState extends State<ProductForm> {
  final StateAssetTypes assetTypes = Get.find();
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String description = "";

  late AssetType _mainCat;
  AssetType? _subCat;

  @override
  void initState() {
    _mainCat = widget.parent.parent == null
        ? widget.parent
        : assetTypes.getAssetTypeById(widget.parent.parent!)!;
    if (_mainCat != widget.parent) {
      _subCat = widget.parent;
    }
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
            TextFormField(
              onSaved: (value) {
                name = value!;
              },
              initialValue:
                  widget.editItem == null ? "" : widget.editItem!.name,
              decoration: InputDecoration(labelText: 'name'),
              validator: (value) {
                return value == null || value.isEmpty ? "add name" : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                description = value!;
              },
              initialValue:
                  widget.editItem == null ? "" : widget.editItem!.text,
              decoration: InputDecoration(labelText: 'description'),
            ),
            Text("main category: " + _mainCat.name),
            Text("sub category: " + (_subCat?.name ?? "N/A")),
            Text("custom fields"),
            Placeholder(),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    if (widget.editItem != null) {
                      assetTypes.editType(widget.editItem!.id, name, description);
                    } else {
                      assetTypes.createNewType(
                          widget.parent.id, false, name, description);
                    }
                    Get.back();
                  }
                },
                child: Text("submit")),
          ],
        ),
      ),
    );
  }
}
