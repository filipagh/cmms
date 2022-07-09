import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/models/asset_type.dart';

class StateAssetTypes extends GetxController {
  List<AssetType> _types = <AssetType>[].obs;

  @override
  void onInit() {
    var rj = createNewType(null, true, "riadiaca jednotka", 'text');
    createNewType(rj, false, "RA 40", 'text');
    createNewType(rj, false, "ROSA", 'text');
    var tep = createNewType(null, true, "teplomer", 'text');
    createNewType(tep, false, "teplomer ULTIMATE", 'text');
    var dtep = createNewType(tep, true, "digitalny teplomer", 'text');
    createNewType(dtep, false, "teplomer 2000Digi", 'text');
    var atep = createNewType(tep, true, "analogovy teplomer", 'text');
    createNewType(atep, false, "teplomer 2000Analog", 'text');

    // TODO: implement onInit
    super.onInit();
  }

  String createNewType(String? parentId, bool isCategory,
      [String name = "name", String text = "text"]) {
    String newId = _getMaxId();
    _types.add(AssetType(newId, parentId, isCategory, name, text));
    return newId;
  }

  String _getMaxId() {
    if (_types.length == 0) {
      return "0";
    }
    dynamic max = _types.first.id;
    _types.forEach((e) {
      if (int.parse(e.id) > int.parse(max)) max = e.id;
    });
    return (int.parse(max)+1).toString();
  }

  List<AssetType> getMainCategories() {
    Iterable<AssetType> i = _types.where((element) => element.parent == null);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  AssetType? getAssetTypeById(String id) {
    return _types.firstWhere((element) => element.id == id);
  }

  List<AssetType> getSubCategoriesOfType(String typeId) {
    Iterable<AssetType> i = _types.where(
        (element) => element.parent == typeId && element.isCategory == true);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  List<AssetType> getProductOfType(String typeId) {
    Iterable<AssetType> i = _types.where(
        (element) => element.parent == typeId && element.isCategory == false);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  List<AssetTypeListView> getData() {
    final StateAssetTypes assetTypes = Get.find();
    List<AssetTypeListView> listItems = [];

    assetTypes.getMainCategories().forEach((element) {
      listItems.add(element);
      assetTypes.getProductOfType(element.id).forEach((element) {
        listItems.add(element);
      });
      assetTypes.getSubCategoriesOfType(element.id).forEach((element) {
        listItems.add(element);
        assetTypes.getProductOfType(element.id).forEach((element) {
          listItems.add(element);
        });
      });
    });
    return listItems;
  }

  AssetType? getMainCategoryOfType(AssetType assetType) {
    var i = assetType;
    while (i.parent != null) {
      i = getAssetTypeById(i.parent!)!;
    }
    return i;
  }
}
