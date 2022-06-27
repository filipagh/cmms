import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/state_asset_types.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/assets_managment_form.dart';

abstract class AssetTypeListView {
  Widget toListItem();
}

abstract class AbstractAssetType {
  late String id;
  late String name;
  late String text;
  late String? assetBaseTypeId;
  late bool isCategory;
}

class AssetType implements AssetTypeListView, AbstractAssetType {
  late String id;
  late String name;
  late String text;
  late String? assetBaseTypeId;
  late int inStorage;

  bool isCategory = false;

  AssetType(this.id, this.assetBaseTypeId,
      [this.name = "name", this.text = "text", this.inStorage = 0]);

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
        title: Row(
          children: [
            Spacer(),
            Text(name),
            Spacer(),
            Text("in storage: " + inStorage.toString()),
            Spacer(),
          ],
        ),
        // subtitle:
        // Center(child: Text('station Id: ${list[index].id}')),
      ),
    );
  }


}

class AssetBaseType implements AssetTypeListView, AbstractAssetType {
  late String id;
  late String name;
  late String text;
  late String? assetBaseTypeId;
  bool isCategory = true;

  AssetBaseType(this.id,
      [this.name = "name", this.text = "text", this.assetBaseTypeId]);

  @override
  Widget toListItem() {
    final StateAssetTypes assetTypes = Get.find();
    return Card(
      child: ListTile(
        onTap: () {
          showFormDialog(AssetManagementForm(
            item: this,
          ));
        },
        hoverColor: Colors.blue.shade200,
        title: assetBaseTypeId == null
            ? Center(child: Text('Category: $name'))
            : Center(child: Text('Sub Category: $name')),
        subtitle: assetBaseTypeId == null
            ? null
            : Center(
                child: Text(
                    'Main Category: ${assetTypes.getAssetBaseTypeById(assetBaseTypeId!)!.name}')),
      ),
    );
  }
}

List<AssetBaseType> dummyAssetBaseType = [
  AssetBaseType("1", "riadiaca jednotka", 'text'),
  AssetBaseType("2", "teplomer", 'text'),
  AssetBaseType("3", "digitalny teplomer", 'text', '2'),
  AssetBaseType("4", "analogovy teplomer", 'text', '2'),
];

List<AssetType> dummyAssetType = [
  AssetType("1", '1', "RA 40", 'text', 0),
  AssetType("2", '1', "ROSA", 'text', 10),
  AssetType("3", '3', "teplomer 2000Digi", 'text', 2),
  AssetType("4", '4', "teplomer 2000Analog", 'text', 0)
];

