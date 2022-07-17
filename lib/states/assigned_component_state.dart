import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/models/assigned_component.dart';

class AssignedComponentState extends GetxController {
  Map<String, Map<String ,AssignedComponent>> planets = <String, Map<String ,AssignedComponent>>{}.obs;

  @override
  void onInit() {
    addItem(new AssignedComponent('1','1', '1', DateTime.now()));
    addItem(new AssignedComponent('2','2', '1', DateTime.now()));
    // addItem(new Item(HelpProduct.productROSAID, 2, 0, 0));
    // addItem(new Item(HelpProduct.productTEPLOULTID, 0, 0, 0));
    // addItem(new Item(HelpProduct.productTEPLOANALOGID, 2, 0, 0));
    // addItem(new Item(HelpProduct.productTEPLODIGIID, 2, 0, 0));
    super.onInit();
  }

  void editType(stationId, assignedComponentId, productId,) {
    var i = planets[stationId]![assignedComponentId];
    i!.productId = productId;
    planets[stationId]![assignedComponentId] = i;
    update([planets[stationId]![assignedComponentId]!]);
  }

  void addItem(AssignedComponent item) {

    if (!planets.containsKey(item.stationId)) {
        planets[item.stationId] = <String,AssignedComponent>{}.obs;
        planets[item.stationId]![item.assignedComponentId] = item;
    } else {
      planets[item.stationId]![item.assignedComponentId] = item;
    }

    // if (_isProductInState(item.productId)) {
    //   printError(info: "product duplicity insert to items");
    //   return;
    // }
    // _items.add(item);
  }

  // void addNewItems(Item item, int newItemsCount) {
  //   if (_isProductInState(item.productId)) {
  //     printError(info: "product duplicity insert to items");
  //     return;
  //   }
  //   _items.add(item);
  // }
  //
  // List<Item> getItems() {
  //   return _items;
  // }
  //
  //
  // bool _isProductInState(String productId) {
  //   return _items.indexWhere((element) => element.productId == productId) >= 0;
  // }
  //
  // Item getById(String id) {
  //   return _items.firstWhere((element) => element.productId == id);
  //
  // }
  // //
  // // List<AssetType> getMainCategories() {
  // //   Iterable<AssetType> i = _items.where((element) => element.parent == null);
  // //   if (i.isEmpty) {
  // //     return [];
  // //   }
  // //   return i.toList();
  // // }
  // //
  // // AssetType? getAssetTypeById(String id) {
  // //   return _items.firstWhere((element) => element.id == id);
  // // }
  // //
  // // List<AssetType> getSubCategoriesOfType(String typeId) {
  // //   Iterable<AssetType> i = _items.where(
  // //       (element) => element.parent == typeId && element.isCategory == true);
  // //   if (i.isEmpty) {
  // //     return [];
  // //   }
  // //   return i.toList();
  // // }
  // //
  // // List<AssetType> getProductOfType(String typeId) {
  // //   Iterable<AssetType> i = _items.where(
  // //       (element) => element.parent == typeId && element.isCategory == false);
  // //   if (i.isEmpty) {
  // //     return [];
  // //   }
  // //   return i.toList();
  // // }
  // //
  // // List<AssetTypeListView> getData() {
  // //   final ItemsState assetTypes = Get.find();
  // //   List<AssetTypeListView> listItems = [];
  // //
  // //   assetTypes.getMainCategories().forEach((element) {
  // //     listItems.add(element);
  // //     assetTypes.getProductOfType(element.id).forEach((element) {
  // //       listItems.add(element);
  // //     });
  // //     assetTypes.getSubCategoriesOfType(element.id).forEach((element) {
  // //       listItems.add(element);
  // //       assetTypes.getProductOfType(element.id).forEach((element) {
  // //         listItems.add(element);
  // //       });
  // //     });
  // //   });
  // //   return listItems;
  // // }
  // //
  // // AssetType? getMainCategoryOfType(AssetType assetType) {
  // //   var i = assetType;
  // //   while (i.parent != null) {
  // //     i = getAssetTypeById(i.parent!)!;
  // //   }
  // //   return i;
  // // }
}
