import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/models/item.dart';
import 'package:open_cmms/states/items_state.dart';

import '../helper.dart';

class StateAssetTypes extends GetxController {
  int _assetTypeSequence = 0;
  Map<String, AssetType> _typesMap = <String, AssetType>{}.obs;

  @override
  void onInit() {

    HelpAsset.assetRJId =  _initType(null, true, "riadiaca jednotka", 'text');
    HelpProduct.productRAID =_initType(HelpAsset.assetRJId, false, "RA 40", 'text');
    HelpProduct.productROSAID =_initType(HelpAsset.assetRJId, false, "ROSA", 'text');
    HelpAsset.assetTEPLOMERId = _initType(null, true, "teplomer", 'text');
    HelpProduct.productTEPLOULTID = _initType(HelpAsset.assetTEPLOMERId, false, "teplomer ULTIMATE", 'text');
    HelpAsset.assetTEPLOMERDIGId = _initType(HelpAsset.assetTEPLOMERId, true, "digitalny teplomer", 'text');
    HelpProduct.productTEPLODIGIID = _initType(HelpAsset.assetTEPLOMERDIGId, false, "teplomer 2000Digi", 'text');
    HelpAsset.assetTEPLOMERANALOGId = _initType(HelpAsset.assetTEPLOMERId, true, "analogovy teplomer", 'text');
    HelpProduct.productTEPLOANALOGID = _initType(HelpAsset.assetTEPLOMERANALOGId, false, "teplomer 2000Analog", 'text');

    super.onInit();
  }

  void editType(String id, String name, String description) {
    _typesMap[id]!.name = name;
    _typesMap[id]!.text = description;
  }

  String createNewType(String? parentId, bool isCategory,
      [String name = "name", String text = "text"]) {
    ItemsState itemsState = Get.find();
    String newId = _getNewId();
    _typesMap[newId] = AssetType(newId, parentId, isCategory, name, text);
    if (!isCategory) {
      itemsState.addItem(Item(newId, 0, 0, 0));
    }
    return newId;
  }

  String _initType(String? parentId, bool isCategory,
      [String name = "name", String text = "text"]) {
    String newId = _getNewId();
    _typesMap[newId] = AssetType(newId, parentId, isCategory, name, text);
    return newId;
  }

  String _getNewId() {
    var id = _assetTypeSequence;
    _assetTypeSequence++;
    return id.toString();
  }

  List<AssetType> getMainCategories() {
    Iterable<AssetType> i = _typesMap.values.where((element) => element.parent == null);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  AssetType? getAssetTypeById(String id) {
    return _typesMap[id];
  }

  List<AssetType> getSubCategoriesOfType(String typeId) {
    Iterable<AssetType> i = _typesMap.values.where(
        (element) => element.parent == typeId && element.isCategory == true);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  List<AssetType> getProductOfType(String typeId) {
    Iterable<AssetType> i = _typesMap.values.where(
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
