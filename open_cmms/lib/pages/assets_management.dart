import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/forms/asset_management/category_form.dart';

import '../service/backend_api/assetManager.dart';
import '../states/asset_types_state.dart';
import '../widgets/assets_types_list.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/dialog_form.dart';
import '../widgets/main_menu_widget.dart';

class AssetsManagement extends StatefulWidget {
  final AssetTypesState _assetTypes = Get.find();

  AssetsManagement({
    Key? key,
  }) : super(key: key);

  @override
  State<AssetsManagement> createState() => _AssetsManagementState();
}

final Rxn<String> searchText = Rxn<String>();
final RxList<AssetSchema> filterAssets = <AssetSchema>[].obs;

class _AssetsManagementState extends State<AssetsManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Manažment komponentov",
                      textScaleFactor: 5,
                    ),
                    IconButton(
                      onPressed: () {
                        widget._assetTypes.reloadData();
                      },
                      icon: const Icon(Icons.refresh),
                      iconSize: 50,
                    )
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        onChanged: (value) {
                          searchText.value = value;
                        },
                        decoration:
                            const InputDecoration(hintText: "Hľadať komponent"),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showFormDialog(CategoryForm.createNewMain());
                      },
                      child: const Text("Pridať hlavnú kategóriu"),
                    ),
                  ],
                ),
                const Divider(),
                GetBuilder<AssetTypesState>(builder: (_) {
                  return Obx(() {
                    return FutureBuilder<List<AssetSchema>?>(
                      future: _filterAssets(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AssetsTypeList(snapshot.data);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    );
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<List<AssetSchema>?> _filterAssets() async {
    List<AssetSchema>? items;

    if (searchText.value != null && searchText.value!.length > 2) {
      items = await AssetManagerService()
              .getAssetsSearchAssetManagerAssetsSearchGet(searchText.value!) ??
          [];
    }
    return items;
  }
}
