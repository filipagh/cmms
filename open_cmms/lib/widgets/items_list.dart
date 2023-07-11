import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/storage/override_storage_item.dart';

import '../states/asset_types_state.dart';
import '../states/auth_state.dart';
import '../states/items_state.dart';

class ItemsList extends StatelessWidget {
  final AssetTypesState assets = Get.find();

  ItemsList({
    required this.itemsList,
    Key? key,
  }) : super(key: key);

  final List<StorageItemSchema> itemsList;
  final authService = Get.find<AuthState>();
  final items = Get.find<ItemsStorageState>();

  @override
  Widget build(BuildContext context) {
    List<_StorageItemList> list = [];
    for (var element in itemsList) {
      var asset = assets.getAssetById(element.assetId);
      if (asset != null) {
        list.add(_StorageItemList(asset, element));
      }
    }

    list.sort((a, b) =>
        a.asset.name.toLowerCase().compareTo(b.asset.name.toLowerCase()));

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
          );
  }

  Widget buildStorageRow(_StorageItemList item) {
    return Card(
      child: ListTile(
          hoverColor: Colors.blue.shade200,
          title: GetBuilder<ItemsStorageState>(
            id: item.item.id,
            builder: (_) {
              var itemActual = _.getById(item.item.id);
              var assetSchema = assets.getAssetById(item.asset.id);
              return IntrinsicHeight(
                child: Row(
                  children: [
                    Text(assetSchema!.name),
                    const Spacer(),
                    if (authService.isAdmin.isTrue) ...[
                      ElevatedButton(
                          onPressed: () {
                            showFormDialog(
                                    OverrideStorageItem(item.item, assetSchema))
                                .then((value) {
                              items.reloadData();
                            });
                          },
                          child: const Text("prepísať stav skladu")),
                      const VerticalDivider()
                    ],
                    Text("Na sklade: " + itemActual!.inStorage.toString()),
                    const VerticalDivider(),
                    Text("Rezervované: " + itemActual.allocated.toString()),
                    // VerticalDivider(),
                    // ElevatedButton(onPressed: (){_.addToStorage(productId);}, child: Text("add 1 to storage"))
                  ],
                ),
              );
            },
          )),
    );
  }
}

class _StorageItemList {
  final AssetSchema asset;
  final StorageItemSchema item;

  _StorageItemList(this.asset, this.item);
}
