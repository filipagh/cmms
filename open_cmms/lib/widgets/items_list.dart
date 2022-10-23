import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';
import 'package:open_cmms/states/items_state_dummy.dart';

import '../states/asset_types_state.dart';
import '../states/items_state.dart';

class ItemsList extends StatelessWidget {

  final AssetTypesState assets = Get.find();
  ItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GetX<ItemsStorageState>(
        builder: (_) { var list =  _.getItems();
        return list.isEmpty
            ? const Expanded(
            child: Center(
                child: Text(
                  "Žiadne komponenty",
                  textScaleFactor: 3,
                )))
            : Expanded(
          child: ListView.builder(
              addRepaintBoundaries: true,
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return buildStorageRow(list[index]);
              }),
        );});
  }

  Widget buildStorageRow(StorageItemSchema item) {
    return Card(
      child: ListTile(
          hoverColor: Colors.blue.shade200,
          title: GetBuilder<ItemsStorageState>(
            id: item.id,
            builder: (_) {var itemActual= _.getById(item.id);
              return IntrinsicHeight(
              child: Row(
                children: [
                  Text(assets.getAssetById(item.assetId)!.name),
                  Spacer(),
                  Text("Na sklade: " + itemActual!.inStorage.toString()),
                  VerticalDivider(),
                  Text("Rezervovane: " + itemActual.allocated.toString()),
                  // VerticalDivider(),
                  // ElevatedButton(onPressed: (){_.addToStorage(productId);}, child: Text("add 1 to storage"))
                ],
              ),
            );},
          )),
    );
  }



}
