import 'package:flutter/material.dart';

abstract class AssetTypeListView {
  Widget toListItem();
}

class AssetType implements AssetTypeListView {
  late String id;
  late String name;
  late String text;
  late String assetBaseTypeId;
  late int inStorage;

  AssetType(this.id, this.assetBaseTypeId,
      [this.name = "name", this.text = "text", this.inStorage = 0]);

  @override
  Widget toListItem() {
    return Card(
      child: ListTile(
        onTap: () {
          // Get.toNamed("/Assets/${list[index].id}");
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

class AssetBaseType implements AssetTypeListView {
  late String id;
  late String name;
  late String text;
  late String? assetBaseTypeId;

  AssetBaseType(this.id,
      [this.name = "name", this.text = "text", this.assetBaseTypeId]);

  @override
  Widget toListItem() {
    return Card(
      child: ListTile(
        onTap: () {
          // Get.toNamed("/Assets/${list[index].id}");
        },
        hoverColor: Colors.blue.shade200,
        title: assetBaseTypeId == null
            ? Center(child: Text('Category: $name'))
            : Center(child: Text('Sub Category: $name')),
        subtitle: assetBaseTypeId == null
            ? null
            : Center(
                child: Text(
                    'Main Category: ${getAssetBaseTypeById(assetBaseTypeId!)!.name}')),
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
  AssetType("1", '1', "ROSA", 'text', 10),
  AssetType("1", '3', "teplomer 2000Digi", 'text', 2),
  AssetType("2", '4', "teplomer 2000Analog", 'text', 0)
];
//
// AssetType? getAssetTypeById(String id) {
//   var i = dummyAssets.where((element) => element.id == id);
//   if (i.isEmpty) {
//     return null;
//   }
//   return i.first;
// }

List<AssetBaseType> getMainAssetBaseTypes() {
  Iterable<AssetBaseType> i =
      dummyAssetBaseType.where((element) => element.assetBaseTypeId == null);
  if (i.isEmpty) {
    return [];
  }
  return i.toList();
}

AssetBaseType? getAssetBaseTypeById(String id) {
  return dummyAssetBaseType.firstWhere((element) => element.id == id);
}

List<AssetBaseType> getAssetBaseTypeByParentId(String id) {
  Iterable<AssetBaseType> i =
      dummyAssetBaseType.where((element) => element.assetBaseTypeId == id);
  if (i.isEmpty) {
    return [];
  }
  return i.toList();
}

List<AssetType> getAssetTypeByParentId(String id) {
  Iterable<AssetType> i =
      dummyAssetType.where((element) => element.assetBaseTypeId == id);
  if (i.isEmpty) {
    return [];
  }
  return i.toList();
}

// List<AssetType> getDummyAssetByIds(List<String> ids) {
//   var i = dummyAssets.where((element) => ids.contains(element.id));
//   if (i.isEmpty) {
//     return [];
//   }
//   return i.toList();
// }
