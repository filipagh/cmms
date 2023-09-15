import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class CategoryForm extends StatefulWidget implements PopupForm {
  final AssetTypesState assetTypes = Get.find();
  late final AssetCategorySchema? editItem;
  late final AssetCategorySchema? parent;

  CategoryForm.createNewSub(
      {Key? key, required AssetCategorySchema this.parent})
      : super(key: key) {
    editItem = null;
  }

  CategoryForm.createNewMain({Key? key}) : super(key: key) {
    editItem = null;
    parent = null;
  }

  CategoryForm.editItem({Key? key, required AssetCategorySchema editItem})
      : super(key: key) {
    this.editItem = editItem;
    this.parent = editItem.parentId != null
        ? assetTypes.getAssetTypeById(editItem.parentId!)
        : null;
  }

  @override
  State<CategoryForm> createState() => CategoryFormState();

  String getTitle() {
    return editItem == null
        ? "Vytvoriť novú kategóriu"
        : "Editovať kategóriu : ${editItem!.name}";
  }

  @override
  StatefulWidget getContent() {
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
          child: Flexible(
            child: Column(
              children: [
                if (widget.parent != null)
                  Text("Hlavná kategória: " + widget.parent!.name),
                TextFormField(
                  onSaved: (value) {
                    name = value!;
                  },
                  initialValue:
                      widget.editItem == null ? "" : widget.editItem!.name,
                  decoration: InputDecoration(labelText: 'názov'),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? "pridať názov"
                        : null;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Zrušiť")),
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
                              assetTypes.createNewType(widget.parent?.id, true,
                                  [], name, description);
                            }
                          }
                        },
                        child: Text("Vytvoriť")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
