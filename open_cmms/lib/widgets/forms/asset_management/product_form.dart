import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class ProductForm extends StatefulWidget implements hasFormTitle {
  final AssetTypesState assetTypes = Get.find();
  late final AssetSchema? editItem;
  late final AssetCategorySchema parent;

  ProductForm.createNew({Key? key, required this.parent}) : super(key: key) {
    editItem = null;
  }

  ProductForm.editItem({Key? key, this.editItem})
      : super(key: key) {
    parent = assetTypes.getAssetTypeById(editItem!.categoryId)!;
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
                  widget.editItem == null ? "" : widget.editItem!.name,
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
