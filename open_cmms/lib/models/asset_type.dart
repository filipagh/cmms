import 'package:flutter/material.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/assets_managment_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/category_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/product_form.dart';

abstract class AssetTypeListView {
  Widget toListItem();
}

class AssetType {
  late String id;
  late String name;
  late String text;
  late String? parent;
  late bool isCategory;

  AssetType(this.id, this.parent, this.isCategory,
      [this.name = "name", this.text = "text"]);
}
