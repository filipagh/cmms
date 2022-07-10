import 'package:flutter/material.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/assets_managment_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/category_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/product_form.dart';

abstract class AssetTypeListView {
  Widget toListItem();
}

class AssetType implements AssetTypeListView {
  late String id;
  late String name;
  late String text;
  late String? parent;
  late bool isCategory;

  AssetType(this.id, this.parent, this.isCategory,
      [this.name = "name", this.text = "text"]);

  @override
  Widget toListItem() {
    return Card(
      child: isCategory ? buildCategoryTile() : buildProductTile(),
    );
  }

  ListTile buildCategoryTile() {
    return ListTile(
      onTap: () {
        showFormDialog(CategoryForm.editItem(
          editItem: this,
        ));
      },
      hoverColor: Colors.blue.shade200,
      title: getBody(),
      // subtitle:
      // Center(child: Text('station Id: ${list[index].id}')),
    );
  }

  Row getBody() {
    return Row(
      children: [
        Text(
          name,
          textScaleFactor: this.parent == null ? 2 : 1,
        ),
        Spacer(),
        if (this.parent == null)
          ElevatedButton(
              onPressed: () {
                showFormDialog(CategoryForm.createNewSub(parent: this));
              },
              child: Text("add category")),
        ElevatedButton(
            onPressed: () {
              showFormDialog(ProductForm.createNew(
                parent: this,
              ));
            },
            child: Text("add product"))
      ],
    );
  }

  ListTile buildProductTile() {
    return ListTile(
      onTap: () {
        showFormDialog(ProductForm.editItem(
          editItem: this,
        ));
      },
      hoverColor: Colors.blue.shade200,
      title: Row(
        children: [
          Spacer(),
          Text(name),
          Spacer(),
          Text("in storage: "),
          Spacer(),
        ],
      ),
      // subtitle:
      // Center(child: Text('station Id: ${list[index].id}')),
    );
  }
}
