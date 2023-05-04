import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state_dummy.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class AssetManagementForm extends StatefulWidget implements hasFormTitle {
  final AssetType? item;

  const AssetManagementForm({Key? key, this.item}) : super(key: key);

  @override
  State<AssetManagementForm> createState() => AssetManagementFormState();

  String getTitle() {
    return item == null
        ? "Create new Asset Type"
        : "Edit Asset type : ${item!.name}";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class AssetManagementFormState extends State<AssetManagementForm> {
  final AssetTypesStateDummy assetTypes = Get.find();
  final _formKey = GlobalKey<FormState>();
  AssetType? _mainCategoryAssetType;
  AssetType? _subCategoryAssetType;
  String? _subCategory;
  List<AssetType> _subCategoryList = [];
  bool _isSubCategoryEnabled = false;
  String name = "";
  String description = "";

  _changeSubCategory(value) {
    setState(() {
      _subCategory = value;
    });
  }

  @override
  void initState() {
    if (widget.item?.parent != null) {
      _mainCategoryAssetType =
          assetTypes.getMainCategoryOfType(widget.item!);
      _isSubCategoryEnabled = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSubCategoryEnabled) {
      setState(() {
        _subCategory = null;
      });
    } else {
      setState(() {
        _subCategoryList =
            assetTypes.getSubCategoriesOfType(_mainCategoryAssetType!.id);
      });
    }
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
              initialValue: widget.item == null ? "" : widget.item!.name,
              decoration: InputDecoration(labelText: 'name'),
              validator: (value) {
                return value == null || value.isEmpty ? "add name" : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                description = value!;
              },
              initialValue: widget.item == null ? "" : widget.item!.text,
              decoration: InputDecoration(labelText: 'description'),
            ),
            DropdownButtonFormField<String>(
              hint: Text('Main category'),
              items: getMainCat(),
              value: _mainCategoryAssetType != null
                  ? _mainCategoryAssetType?.id
                  : EMPTY_CATEGORY,
              onChanged: (value) {
                setState(() {
                  if (value == EMPTY_CATEGORY) {
                    _mainCategoryAssetType = null;
                    _isSubCategoryEnabled = false;
                  } else {
                    _mainCategoryAssetType =
                        assetTypes.getAssetTypeById(value!);
                    _subCategory = null;
                    _isSubCategoryEnabled = true;
                  }
                });
              },
            ),
            DropdownButtonFormField<String>(
              disabledHint: Text("please select main categoty"),
              hint: Text('Sub category'),
              items: getSubCat(),
              value: _subCategory,
              onChanged: _isSubCategoryEnabled ? _changeSubCategory : null,
            ),
            // Text("custom fields"),
            // Placeholder(),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    if (_mainCategoryAssetType == null) {
                      assetTypes.createNewType(null, true, name, description);
                    } else if (_subCategory == EMPTY_CATEGORY ||
                        _subCategory == null) {
                      assetTypes.createNewType(
                          _mainCategoryAssetType!.id, true, name, description);
                    } else if (_subCategory != EMPTY_CATEGORY ||
                        _subCategory != null) {
                      assetTypes.createNewType(
                          _mainCategoryAssetType!.id, false, name, description);
                    }

                    // assetTypes.addType(AssetType('99',_subCategory, name, description,
                    //     _mainCategoryAssetType?.assetBaseTypeId));

                    Get.back();
                  }
                },
                child: Text("submit")),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getMainCat() {
    final AssetTypesStateDummy assetTypes = Get.find();
    List<DropdownMenuItem<String>> list = [];

    list.add(DropdownMenuItem(
      child: Text("New main category"),
      value: EMPTY_CATEGORY,
    ));
    assetTypes.getMainCategories().forEach((element) {
      list.add(DropdownMenuItem(
        child: Text(element.name),
        value: element.id,
      ));
    });
    return list;
  }

  List<DropdownMenuItem<String>> getSubCat() {
    List<DropdownMenuItem<String>> list = [];

    list.add(DropdownMenuItem(
      child: Text("New sub category"),
      value: EMPTY_CATEGORY,
    ));
    _subCategoryList.forEach((element) {
      list.add(DropdownMenuItem(
        child: Text(element.name),
        value: element.name,
      ));
    });
    return list;
  }
}
