import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/models/item.dart';
import 'package:open_cmms/service/backend_api/assetManager.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:uuid/uuid.dart';

import '../helper.dart';

class AssetTypesState extends GetxController {
  Map<String, AssetCategorySchema> _categoriesTypes =
      <String, AssetCategorySchema>{}.obs;
  Map<String, AssetSchema> _products = <String, AssetSchema>{}.obs;

  @override
  void onInit() {
    reloadData();
    super.onInit();
  }

  void reloadData() {
    _categoriesTypes.clear();
    _products.clear();
    AssetManagerService()
        .getAssetCategoriesAssetManagerAssetCategoriesGet()
        .then((value) {
      value?.forEach((element) {
        _categoriesTypes[element.id] = element;
      });
    });
    AssetManagerService().getAssetsAssetManagerAssetsGet().then((value) {
      value?.forEach((element) {
        _products[element.id] = element;
      });
    });
  }

  void editType(String id, String name, String description) {
    // todo
    // _categoriesTypes[id]!.name = name;
    // _categoriesTypes[id]!.text = description;
  }

  void createNewType(String? parentId, bool isCategory,
      [String name = "name", String text = "text"]) {
    if (isCategory) {
      var model;
      if (parentId == null) {
        model = AssetCategoryNewSchema(name: name, description: text);
      } else {
        model = AssetCategoryNewSchema(
            parentId: parentId, name: name, description: text);
      }
      AssetManagerService()
          .createNewCategoryAssetManagerNewCategoryPost(model)
          .then((value) => reloadData());
    } else {
      AssetManagerService()
          .createNewAssetAssetManagerNewAssetPost(AssetNewSchema(
          categoryId: parentId!, name: name, description: text))
          .then((value) => reloadData());
    }
  }

  List<AssetCategorySchema> getMainCategories() {
    Iterable<AssetCategorySchema> i =
        _categoriesTypes.values.where((element) => element.parentId == null);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  AssetCategorySchema? getAssetTypeById(String id) {
    return _categoriesTypes[id];
  }

  List<AssetCategorySchema> getSubCategoriesOfType(String typeId) {
    Iterable<AssetCategorySchema> i = _categoriesTypes.values.where(
        (element) => element.parentId == typeId);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  List<AssetSchema> getProductOfType(String categoryId) {
    Iterable<AssetSchema> i = _products.values.where(
        (element) => element.categoryId == categoryId);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }
//
  List getData() {

    List listItems = [];

    getMainCategories().forEach((element) {
      listItems.add(element);
      getProductOfType(element.id).forEach((element) {
        listItems.add(element);
      });
      getSubCategoriesOfType(element.id).forEach((element) {
        listItems.add(element);
        getProductOfType(element.id).forEach((element) {
          listItems.add(element);
        });
      });
    });
    return listItems;
  }
//
  AssetCategorySchema? getMainCategoryOfType(AssetCategorySchema assetType) {
    var i = assetType;
    while (i.parentId != null) {
      i = getAssetTypeById(i.parentId!)!;
    }
    return i;
  }
}
