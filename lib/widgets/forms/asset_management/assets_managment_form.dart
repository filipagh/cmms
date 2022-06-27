import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../models/asset_type.dart';
import '../../../states/state_asset_types.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class AssetManagementForm extends StatefulWidget implements hasFormTitle {
  final AbstractAssetType? item;

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
  final StateAssetTypes assetTypes = Get.find();
  final _formKey = GlobalKey<FormState>();
  AssetBaseType? _mainCategoryAssetType;
  AssetBaseType? _subCategoryAssetType;
  String? _subCategory;
  List<AssetBaseType> _subCategoryList = [];
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
    if (widget.item?.assetBaseTypeId != null) {
      _mainCategoryAssetType =
          assetTypes.getMainAssetBaseTypeByItem(widget.item!);
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
            assetTypes.getAssetBaseTypeByParentId(_mainCategoryAssetType!.id);
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
                        assetTypes.getAssetBaseTypeById(value!);
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
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    if (_mainCategoryAssetType == null) {
                      assetTypes.addBaseType(AssetBaseType('99', name, description));
                    }
                    else if (_subCategory == EMPTY_CATEGORY || _subCategory == null) {
                      assetTypes.addBaseType(AssetBaseType('9', name, description,
                          _mainCategoryAssetType?.id));
                    } else if (_subCategory != EMPTY_CATEGORY || _subCategory != null) {
                      assetTypes.addType(AssetType('98',_mainCategoryAssetType?.id, name, description,
                          ));
                    }

                    // assetTypes.addType(AssetType('99',_subCategory, name, description,
                    //     _mainCategoryAssetType?.assetBaseTypeId));

                    Get.back();
                  }
                },
                child: Text("dwddd")),
            Text("custom fields"),
            Placeholder(),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getMainCat() {
    final StateAssetTypes assetTypes = Get.find();
    List<DropdownMenuItem<String>> list = [];

    list.add(DropdownMenuItem(
      child: Text("New main category"),
      value: EMPTY_CATEGORY,
    ));
    assetTypes.getMainAssetBaseTypes().forEach((element) {
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
