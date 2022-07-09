import 'package:flutter/material.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/assets_managment_form.dart';

abstract class AssetTypeListView {
  Widget toListItem();
}

class AssetType implements AssetTypeListView {
  late String id;
  late String name;
  late String text;
  late String? parent;
  late bool isCategory;

  AssetType(this.id, this.parent, this.isCategory, [this.name = "name", this.text = "text"]);

  @override
  Widget toListItem() {
    return Card(
      child: ListTile(
        onTap: () {
          showFormDialog(AssetManagementForm(
            item: this,
          ));
        },
        hoverColor: Colors.blue.shade200,
        title: getBody(),
        // subtitle:
        // Center(child: Text('station Id: ${list[index].id}')),
      ),
    );
  }

  Row getBody() {
    if (!this.isCategory) {
      return Row(
        children: [
          Spacer(),
          Text(name),
          Spacer(),
          Text("in storage: "),
          Spacer(),
        ],
      );
    } else {
      return Row(
        children: [
          Text(name,textScaleFactor: this.parent == null ? 2:1,),
        ],
      );
    }
  }
}
