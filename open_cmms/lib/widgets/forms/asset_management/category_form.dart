import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class CategoryForm extends StatefulWidget implements hasFormTitle {
  final AssetTypesState assetTypes = Get.find();
  late final AssetCategorySchema? editItem;
  late final AssetCategorySchema? parent;

  CategoryForm.createNewSub({Key? key, required AssetCategorySchema this.parent}) : super(key: key) {
    editItem = null;
  }
  CategoryForm.createNewMain({Key? key}) : super(key: key) {
    editItem = null;
    parent = null;
  }

  CategoryForm.editItem({Key? key, required AssetCategorySchema editItem})
      : super(key: key) {
    this.editItem = editItem;
    this.parent = assetTypes.getAssetTypeById(editItem.parentId!)!;
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
  final AssetTypesState assetTypes = Get.find();
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String description = "";

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Expanded(
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
                if (widget.parent != null)
                  Text("main category: " + widget.parent!.name),
                Text("custom fields"),
                Flexible(child: Placeholder()),
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        if (widget.editItem != null) {
                          assetTypes.editType(
                              widget.editItem!.id, name, description);
                        } else {
                          assetTypes.createNewType(
                              widget.parent?.id, true, [], name, description);
                        }
                        Get.back();
                      }
                    },
                    child: Text("submit")),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
