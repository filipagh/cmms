import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../models/asset_type.dart';
import '../../../states/state_asset_types.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class CategoryForm extends StatefulWidget implements hasFormTitle {
  final StateAssetTypes assetTypes = Get.find();
  late final AssetType? editItem;
  late final AssetType? parent;

  CategoryForm.createNewSub({Key? key, required this.parent}) : super(key: key) {
    this.editItem = null;
  }
  CategoryForm.createNewMain({Key? key}) : super(key: key) {
    this.editItem = null;
    this.parent = null;
  }

  CategoryForm.editItem({Key? key, required AssetType editItem})
      : super(key: key) {
    this.editItem = editItem;
    this.parent = assetTypes.getAssetTypeById(editItem.parent!)!;
  }

  @override
  State<CategoryForm> createState() => CategoryFormState();

  String getTitle() {
    return editItem == null
        ? "Create new Category"
        : "Edit Category : ${editItem!.name}";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class CategoryFormState extends State<CategoryForm> {
  final StateAssetTypes assetTypes = Get.find();
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String description = "";

  @override
  void initState() {

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

            if (widget.parent != null) Text("main category: " + widget.parent!.name),
            Text("custom fields"),
            Placeholder(),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    if (widget.editItem != null) {
                      assetTypes.editType(
                          widget.editItem!.id, name, description);
                    } else {
                      assetTypes.createNewType(
                          widget.parent?.id, true, name, description);
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
