import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/storage/add_items_to_storage.dart';
import 'package:open_cmms/widgets/items_list.dart';

import '../states/asset_types_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Storage extends StatefulWidget {
  Storage({
    Key? key,
  }) : super(key: key);

  final AssetTypesState assets = Get.find();

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final ItemsStorageState items = Get.find();
  final RxBool inStorageOnly = false.obs;
  final RxBool showArchived = false.obs;

  @override
  Widget build(BuildContext context) {
    items.reloadData();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sklad",
                      textScaleFactor: 5,
                    ),
                    IconButton(
                      onPressed: () {
                        items.reloadData();
                      },
                      icon: const Icon(Icons.refresh),
                      iconSize: 50,
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 200,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Hľadať (WIP)",
                          enabled: false,
                        ),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: 200,
                        child: CheckboxListTile(
                            title: const Text("filtrovať naskladnené"),
                            value: inStorageOnly.value,
                            onChanged: (v) {
                              inStorageOnly.value = v!;
                            }),
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        width: 200,
                        child: CheckboxListTile(
                            title: const Text("zobraziť archivované"),
                            value: showArchived.value,
                            onChanged: (v) {
                              showArchived.value = v!;
                            }),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          showFormDialog(AddItemsToStorage());
                        },
                        child: const Text("Pridať do skladu"))
                  ],
                ),
                const Divider(),
                GetX<ItemsStorageState>(
                  builder: (_) {
                    var list = _.getItems();
                    return Obx(() {
                      List<StorageItemList> filteredList = [];
                      for (var element in list) {
                        var asset = widget.assets.getAssetById(element.assetId);
                        if (asset != null) {
                          filteredList.add(StorageItemList(asset, element));
                        }
                      }
                      if (inStorageOnly.isTrue) {
                        filteredList = filteredList
                            .where((element) => element.item.inStorage > 0)
                            .toList();
                      }
                      if (showArchived.isFalse) {
                        filteredList = filteredList
                            .where(
                                (element) => element.asset.isArchived == false)
                            .toList();
                      }
                      return ItemsList(
                        list: filteredList,
                      );
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StorageItemList {
  final AssetSchema asset;
  final StorageItemSchema item;

  StorageItemList(this.asset, this.item);
}
