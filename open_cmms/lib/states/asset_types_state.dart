import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assetManager.dart';
import 'package:open_cmms/snacbars.dart';

class AssetTypesState extends GetxController {
  final Map<String, AssetCategorySchema> _categoriesTypes =
      <String, AssetCategorySchema>{}.obs;
  final Map<String, AssetSchema> _products = <String, AssetSchema>{}.obs;

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
        refresh();
      });
    });
    AssetManagerService().getAssetsAssetManagerAssetsGet().then((value) {
      value?.forEach((element) {
        _products[element.id] = element;
        refresh();
      });
    });
  }

  void editType(String id, String name, String description) {
    showInfo("nie je implementované");
    // todo
    // _categoriesTypes[id]!.name = name;
    // _categoriesTypes[id]!.text = description;
  }

  // todo rozdelit asety a categorie
  void createNewType(
      String? parentId, bool isCategory, List<AssetTelemetry> telemetry,
      [String name = "name", String text = "text"]) {
    if (isCategory) {
      AssetCategoryNewSchema model;
      if (parentId == null) {
        model = AssetCategoryNewSchema(name: name, description: text);
      } else {
        model = AssetCategoryNewSchema(
            parentId: parentId, name: name, description: text);
      }
      AssetManagerService()
          .createNewCategoryAssetManagerNewCategoryPost(model)
          .then((value) {
        reloadData();
        showOk("nová kategória vytvorená");
      });
    } else {
      AssetManagerService()
          .createNewAssetAssetManagerNewAssetPost(AssetNewSchema(
              categoryId: parentId!,
              name: name,
              description: text,
              telemetry: telemetry))
          .then((value) {
        reloadData();
        showOk("komponent vytvorený");
      });
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

  AssetSchema? getAssetById(String id) {
    return _products[id];
  }

  List<AssetCategorySchema> getSubCategoriesOfType(String typeId) {
    Iterable<AssetCategorySchema> i =
        _categoriesTypes.values.where((element) => element.parentId == typeId);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

  List<AssetSchema> getProductOfType(String categoryId) {
    Iterable<AssetSchema> i =
        _products.values.where((element) => element.categoryId == categoryId);
    if (i.isEmpty) {
      return [];
    }
    return i.toList();
  }

//
  List getData(List<AssetSchema>? filterAssets) {
    List listItems = [];

    getMainCategories().forEach((element) {
      listItems.add(element);
      getProductOfType(element.id).forEach((element) {
        if (filterAssets != null) {
          if (filterAssets.firstWhereOrNull((e) {
                return e.id == element.id;
              }) ==
              null) {
            return;
          }
        }
        listItems.add(element);
      });
      getSubCategoriesOfType(element.id).forEach((element) {
        listItems.add(element);
        getProductOfType(element.id).forEach((element) {
          if (filterAssets != null) {
            if (filterAssets.firstWhereOrNull((e) {
                  return e.id == element.id;
                }) ==
                null) {
              return;
            }
          }
          listItems.add(element);
        });
      });
    });
    return listItems;
  }

  AssetCategorySchema? getMainCategoryOfType(AssetCategorySchema assetType) {
    var i = assetType;
    while (i.parentId != null) {
      i = getAssetTypeById(i.parentId!)!;
    }
    return i;
  }

  List<AssetSchema> getAllProducts() {
    return _products.values.toList();
  }
}
