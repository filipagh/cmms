import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/asset_type.dart';

import '../models/item.dart';

class ItemsState extends GetxController {
  List<Item> _items = <Item>[].obs;

  @override
  void onInit() {
    addItem(new Item(HelpProduct.productRAID, 2, 0, 0));
    addItem(new Item(HelpProduct.productROSAID, 2, 0, 0));
    addItem(new Item(HelpProduct.productTEPLOULTID, 0, 0, 0));
    addItem(new Item(HelpProduct.productTEPLOANALOGID, 2, 0, 0));
    addItem(new Item(HelpProduct.productTEPLODIGIID, 2, 0, 0));
    super.onInit();
  }

  // void editType(String id, String name, String description) {
  //   var i = _types.singleWhere((element) => element.id == id);
  //   _types.remove(i);
  //   i.name = name;
  //   i.text = description;
  //   _types.add(i);
  // }

  void addItem(Item item) {
    if (_isProductInState(item.productId)) {
      printError(info: "product duplicity insert to items");
      return;
    }
    _items.add(item);
  }

  void addNewItems(Item item, int newItemsCount) {
    if (_isProductInState(item.productId)) {
      printError(info: "product duplicity insert to items");
      return;
    }
    _items.add(item);
  }

  List<Item> getItems() {
    return _items;
  }


  bool _isProductInState(String productId) {
    return _items.indexWhere((element) => element.productId == productId) >= 0;
  }

  Item getById(String id) {
    return _items.firstWhere((element) => element.productId == id);

  }
  //
  // List<AssetType> getMainCategories() {
  //   Iterable<AssetType> i = _items.where((element) => element.parent == null);
  //   if (i.isEmpty) {
  //     return [];
  //   }
  //   return i.toList();
  // }
  //
  // AssetType? getAssetTypeById(String id) {
  //   return _items.firstWhere((element) => element.id == id);
  // }
  //
  // List<AssetType> getSubCategoriesOfType(String typeId) {
  //   Iterable<AssetType> i = _items.where(
  //       (element) => element.parent == typeId && element.isCategory == true);
  //   if (i.isEmpty) {
  //     return [];
  //   }
  //   return i.toList();
  // }
  //
  // List<AssetType> getProductOfType(String typeId) {
  //   Iterable<AssetType> i = _items.where(
  //       (element) => element.parent == typeId && element.isCategory == false);
  //   if (i.isEmpty) {
  //     return [];
  //   }
  //   return i.toList();
  // }
  //
  // List<AssetTypeListView> getData() {
  //   final ItemsState assetTypes = Get.find();
  //   List<AssetTypeListView> listItems = [];
  //
  //   assetTypes.getMainCategories().forEach((element) {
  //     listItems.add(element);
  //     assetTypes.getProductOfType(element.id).forEach((element) {
  //       listItems.add(element);
  //     });
  //     assetTypes.getSubCategoriesOfType(element.id).forEach((element) {
  //       listItems.add(element);
  //       assetTypes.getProductOfType(element.id).forEach((element) {
  //         listItems.add(element);
  //       });
  //     });
  //   });
  //   return listItems;
  // }
  //
  // AssetType? getMainCategoryOfType(AssetType assetType) {
  //   var i = assetType;
  //   while (i.parent != null) {
  //     i = getAssetTypeById(i.parent!)!;
  //   }
  //   return i;
  // }
}
