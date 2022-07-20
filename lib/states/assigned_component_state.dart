import 'package:get/get.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/assigned_component.dart';
import 'package:open_cmms/states/asset_types_state.dart';

class AssignedComponentState extends GetxController {
  int _stationSequence = 0;
  StateAssetTypes _stateAssetTypes = Get.find();

  // <stationId<AssignedComponentId, AssignedComponent>>
  Map<String, Map<String, AssignedComponent>> components =
      <String, Map<String, AssignedComponent>>{}.obs;

  @override
  void onInit() {
    addAlreadyInstalledComponent(
        HelpStation.station0,
        HelpProduct.productROSAID,
        DateTime.now().subtract(Duration(days: 10)),AssignedComponentStateEnum.installed); // instaled
    addAlreadyInstalledComponent(
        HelpStation.station0,
        HelpProduct.productTEPLOANALOGID,
        DateTime.now().subtract(Duration(days: 10)),AssignedComponentStateEnum.willBeRemoved); //instaled tobeuninstaled
    addAlreadyInstalledComponent(HelpStation.station0,
        HelpProduct.productTEPLODIGIID, DateTime.now(),AssignedComponentStateEnum.awaiting); // awaiting
    super.onInit();
  }

  String _getNewId() {
    var id = _stationSequence.toString();
    _stationSequence++;
    return id;
  }

  List<AssignedComponent> getInstalledComponentsByStationId(String stationId) {
    var list = <AssignedComponent>[];
    components[stationId]?.values.forEach((element) {
      if (element.actualState != AssignedComponentStateEnum.removed) {
        list.add(element);
      }
    });
    return list;
  }

  void editType(
    stationId,
    assignedComponentId,
    productId,
  ) {
    var i = components[stationId]![assignedComponentId];
    i!.productId = productId;
    components[stationId]![assignedComponentId] = i;
    update([components[stationId]![assignedComponentId]!]);
  }

  void _addItem(AssignedComponent item) {
    if (!components.containsKey(item.stationId)) {
      components[item.stationId] = <String, AssignedComponent>{}.obs;
      components[item.stationId]![item.assignedComponentId] = item;
    } else {
      components[item.stationId]![item.assignedComponentId] = item;
    }

    // if (_isProductInState(item.productId)) {
    //   printError(info: "product duplicity insert to items");
    //   return;
    // }
    // _items.add(item);
  }

  void addAlreadyInstalledComponent(
      String stationId, productId, DateTime installed, AssignedComponentStateEnum state,
      [DateTime? removed]) {
    var id = _getNewId();
    _addItem(AssignedComponent(
        id,
        productId,
        stationId,
        DateTime.now(),
        installed,
        removed,
        state));
    _stateAssetTypes.addUsedComponent(productId);
  }
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
