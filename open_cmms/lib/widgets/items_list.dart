import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';
import 'package:open_cmms/states/items_state_dummy.dart';

class ItemsList extends StatelessWidget {

  const ItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemsState_dummy items = Get.find();

    return GetX<AssetTypesStateDummy>(
        builder: (_) { var list =  items.getItems();
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
                return list[index].toListItem();
              }),
        );});
  }
}
