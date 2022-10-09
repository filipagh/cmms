import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';
import 'package:open_cmms/states/items_state.dart';

// abstract class AssetTypeListView {
//   Widget toListItem();
// }

// class Item implements AssetTypeListView {
class Item {
  AssetTypesStateDummy _typeState = Get.find();
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
      title: GetBuilder<ItemsState>(
        id: productId,
        builder: (_) {var item= _.getById(productId); return IntrinsicHeight(
        child: Row(
          children: [
            Text(product!.name),
            Spacer(),
            Text("in storage: " + item.inStorage.toString()),
            VerticalDivider(),
            Text("used: " + item.used.toString()),
            VerticalDivider(),
            Text("allocated: " + item.allocated.toString()),
            VerticalDivider(),
            ElevatedButton(onPressed: (){_.addToStorage(productId);}, child: Text("add 1 to storage"))

          ],
        ),
      );},
      // subtitle:
      // Center(child: Text('station Id: ${list[index].id}')),
    ));
  }
}
