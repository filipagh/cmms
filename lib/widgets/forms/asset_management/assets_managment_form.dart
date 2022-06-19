import 'package:flutter/material.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../models/asset_type.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class AssetManagementForm extends StatefulWidget implements hasFormTitle {
  final AbstractAssetType? item;

  const AssetManagementForm({Key? key, this.item}) : super(key: key);

  @override
  State<AssetManagementForm> createState() => _AssetManagementFormState();

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

class _AssetManagementFormState extends State<AssetManagementForm> {
  final _formKey = GlobalKey<FormState>();
  AssetBaseType? _mainCategoryAssetType;
  String? _subCategory;
  List<AssetBaseType> _subCategoryList = [];
  bool _isSubCategoryEnabled = false;

  _changeSubCategory(value) {
    setState(() {
      _subCategory = value;
    });
  }

  @override
  void initState() {
    if (widget.item?.assetBaseTypeId != null) {
      _mainCategoryAssetType = getMainAssetBaseTypeByItem(widget.item!);
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
            getAssetBaseTypeByParentId(_mainCategoryAssetType!.id);
      });
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.item == null ? "" : widget.item!.name,
              decoration: InputDecoration(labelText: 'name'),
            ),
            TextFormField(
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
                    _mainCategoryAssetType = getAssetBaseTypeById(value!);
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
            Text("custom fields"),
            Placeholder(),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getMainCat() {
    List<DropdownMenuItem<String>> list = [];

    list.add(DropdownMenuItem(
      child: Text("New main category"),
      value: EMPTY_CATEGORY,
    ));
    getMainAssetBaseTypes().forEach((element) {
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
