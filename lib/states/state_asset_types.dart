// Create controller class and extends GetxController
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/models/asset_type.dart';

//
// class StateAssetTypes extends GetxController {
//   var counter = 0.obs;
//   void increment() {
//     counter++;
//     // update(); // use update() to update counter variable on UI when increment be called
//   }
//
//   dynamic getll() {
//     return counter;
//   }
// }
//
// class StateAssetTypes2 extends GetxController {
//   var counter = 0.obs;
//   void increment() {
//     final StateAssetTypes c = Get.find();
//     c.increment();
//     counter++;
//     // update(); // use update() to update counter variable on UI when increment be called
//   }
//
//   dynamic getll() {
//     return counter;
//   }
// }

class StateAssetTypes extends GetxController {
  List<AssetBaseType> _baseT = dummyAssetBaseType.obs;
  List<AssetType> _type = dummyAssetType.obs;

  // List<AbstractAssetType> types = [...dummyAssetBaseType, ...dummyAssetType];


  void addMainType() {
    _baseT.add(AssetBaseType("10"));
    print(_baseT);
  }

  List<AssetBaseType> getMainAssetBaseTypes() {
    Iterable<AssetBaseType> i =
    _baseT.where((element) => element.assetBaseTypeId == null);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }


  AssetBaseType? getAssetBaseTypeById(String id) {
    return _baseT.firstWhere((element) => element.id == id);
  }

  AssetType? getAssetTypeById(String id) {
    return _type.firstWhere((element) => element.id == id);
  }

  List<AssetBaseType> getAssetBaseTypeByParentId(String id) {
    Iterable<AssetBaseType> i =
    _baseT.where((element) => element.assetBaseTypeId == id);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  List<AssetType> getAssetTypeByParentId(String id) {
    Iterable<AssetType> i =
    _type.where((element) => element.assetBaseTypeId == id);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  AssetBaseType? getMainAssetBaseTypeByItem(AbstractAssetType item) {
    if (item.assetBaseTypeId == null) {
      return null;
    }
    dynamic parent = item.isCategory
        ? getAssetBaseTypeById(item.id)
        : getAssetTypeById(item.id);
    while (parent.assetBaseTypeId != null) {
      parent = getAssetBaseTypeById(parent!.assetBaseTypeId!);
    }
    return getAssetBaseTypeById(parent!.id);
  }

  List<AssetTypeListView> getData() {
    final StateAssetTypes assetTypes = Get.find();
    List<AssetTypeListView> listItems = [];

    assetTypes.getMainAssetBaseTypes().forEach((element) {
      listItems.add(element);
      assetTypes.getAssetTypeByParentId(element.id).forEach((element) {
        listItems.add(element);
      });
      assetTypes.getAssetBaseTypeByParentId(element.id).forEach((element) {
        listItems.add(element);
        assetTypes.getAssetTypeByParentId(element.id).forEach((element) {
          listItems.add(element);
        });
      });

    });
    return listItems;
  }

  void addBaseType(AssetBaseType type) {
    print(type);
    _baseT.add(type);
  }

  void addType(AssetType assetType) {
    _type.add(assetType);
  }

}
