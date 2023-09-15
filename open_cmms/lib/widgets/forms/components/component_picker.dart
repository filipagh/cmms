import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assetManager.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state.dart';

class ComponentPickerForm extends StatelessWidget implements PopupForm {
  final bool hideArchivedAssets;

  ComponentPickerForm({Key? key, this.hideArchivedAssets = true})
      : super(key: key);

  @override
  String getTitle() {
    return "Vybrať komponent";
  }

  @override
  Widget getContent() {
    return this;
  }

  final AssetTypesState _assetTypes = Get.find();
  final Rxn<String> searchText = Rxn<String>();
  final RxList<AssetSchema> searchResults = <AssetSchema>[].obs;

  @override
  Widget build(BuildContext context) {
    _loadFilteredAssets();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            autofocus: true,
            onChanged: (value) {
              searchText.value = value;
              _loadFilteredAssets();
            },
            decoration: const InputDecoration(
              hintText: "Hľadať komponent",
            ),
          ),
        ),
        // const Text("searchbar"),
        // const SizedBox(height: 50, child: Placeholder()),
        SizedBox(
          width: 500,
          height: Get.height - 300,
          child: Obx(
            () => ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                var i = searchResults[index];
                return Card(
                  color: i.isArchived ? Colors.red.shade50 : null,
                  child: ListTile(
                    onTap: () => Get.back(result: i),
                    title: Center(
                        child: Text(i.name +
                            (i.isArchived == true ? " (archivované)" : ""))),
                    subtitle:
                        Center(child: Text(i.description ?? "bez popisu")),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Future<void> _loadFilteredAssets() async {
    List<AssetSchema> items = [];

    if (searchText.value != null && searchText.value!.length > 2) {
      items = await AssetManagerService()
              .getAssetsSearchAssetManagerAssetsSearchGet(searchText.value!) ??
          [];
    } else {
      items = _assetTypes.getAllProducts();
    }
    if (hideArchivedAssets) {
      items = items.where((element) => element.isArchived == false).toList();
    }
    searchResults.value = items;
  }
}
