import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/service/backend_api/storageManager.dart';

import '../models/item.dart';

class ItemsStorageState extends GetxController {
  Map<String, StorageItemSchema> _itemsMap = <String, StorageItemSchema>{}.obs;

  @override
  void onInit() {
    reloadData();
    super.onInit();
  }

  void reloadData() {
    _itemsMap.clear();
    StorageManagerService()
        .getAllStorageItemsStorageManagerAllStorageDataGet()
        .then((value) {
      value?.forEach((element) {
        _itemsMap[element.id] = element;
      });
    });
  }

  List<StorageItemSchema> getItems() {
    return _itemsMap.values.toList();
  }

  StorageItemSchema? getById(String itemId ) {
    return _itemsMap[itemId];
  }

  StorageItemSchema? getByAssetId(String assetId) {
    return _itemsMap.values.singleWhere((element) => element.assetId==assetId);
  }

  Future<List<AssetItemToAdd>?> addToStorage(List<AssetItemToAdd> list) async {
   return await StorageManagerService().storeNewAssetsStorageManagerStoreNewAssetsPost(list);
  }


  //
  // Item getById(String id) {
  //   return _itemsMap[id]!;
  //
  // }
  //
  // void addUsedComponent(productId) {
  //   _itemsMap[productId]!.used++;
  // }
  // void addAllocatedComponent(productId) {
  //   _itemsMap[productId]!.allocated++;
  // }
  //
  // void removeAllocated(String productId) {
  //   _itemsMap[productId]!.allocated--;
  // }
  //
  // void removeUsed(String productId) {
  //   _itemsMap[productId]!.used--;
  // }
  //
  // void addToStorage(String productId) {
  //   _itemsMap[productId]!.inStorage++;
  //   update([productId]);
  // }
  // //
}
