import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/items_types_state.dart';
import 'package:open_cmms/states/state_asset_types.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/assets_managment_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/category_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/product_form.dart';

// abstract class AssetTypeListView {
//   Widget toListItem();
// }

// class Item implements AssetTypeListView {
class Item {
  StateAssetTypes _typeState = Get.find();
  late String productId;
  late int inStorage;
  late int allocated;
  late int used;

  Item(this.productId, this.inStorage, this.allocated, this.used);



  @override
  Widget toListItem() {
    return Card(
      child: buildTile(),
    );
  }



  ListTile buildTile() {
    var product = _typeState.getAssetTypeById(productId);
    return ListTile(

      hoverColor: Colors.blue.shade200,
      title: Row(
        children: [
          Text(product!.name),
          Spacer(),
          Text("in storage: " + inStorage.toString()),
          VerticalDivider(),
          Text("used: " + used.toString()),
          VerticalDivider(),
          Text("allocated: " + allocated.toString()),
        ],
      ),
      // subtitle:
      // Center(child: Text('station Id: ${list[index].id}')),
    );
  }
}
