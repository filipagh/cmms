import 'package:flutter/material.dart';

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
