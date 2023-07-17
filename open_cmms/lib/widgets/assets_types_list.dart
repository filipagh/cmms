import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assetManager.dart';
import 'package:open_cmms/widgets/forms/asset_management/product_read_only.dart';

import '../states/asset_types_state.dart';
import 'dialog_form.dart';
import 'forms/asset_management/category_form.dart';
import 'forms/asset_management/product_form_new.dart';

class AssetsTypeList extends StatelessWidget {
  AssetsTypeList({
    Key? key,
  }) : super(key: key);

  final AssetTypesState _assetTypes = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<AssetTypesState>(builder: (_) {
      var list = _assetTypes.getData();
      return list.isEmpty
          ? const Expanded(
              child: Center(
                  child: Text(
              "Žiadne komponenty",
              textScaleFactor: 3,
            )))
          : Expanded(
              child: Container(
                constraints: BoxConstraints(maxWidth: 900),
                child: ListView.builder(
                    addRepaintBoundaries: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return toListItem(list[index]);
                    }),
              ),
            );
    });
  }

  Widget toListItem(element) {
    if (element is AssetCategorySchema) {
      return Card(child: buildCategoryTile(element));
    } else {
      return Card(
        child: buildProductTile(element),
      );
    }
  }

  ListTile buildCategoryTile(AssetCategorySchema element) {
    return ListTile(
      onTap: () {
        showFormDialog(CategoryForm.editItem(
          editItem: element,
        ));
      },
      hoverColor: Colors.blue.shade200,
      title: getBody(element),
      // subtitle:
      // Center(child: Text('station Id: ${list[index].id}')),
    );
  }

  Row getBody(AssetCategorySchema element) {
    return Row(
      children: [
        Text(
          element.name,
          textScaleFactor: element.parentId == null ? 2 : 1,
        ),
        Spacer(),
        if (element.parentId == null)
          ElevatedButton(
              onPressed: () {
                showFormDialog(CategoryForm.createNewSub(parent: element));
              },
              child: Text("Pridať kategóriu")),
        ElevatedButton(
            onPressed: () {
              showFormDialog(ProductFormNew(
                parent: element,
              ));
            },
            child: Text("Pridať produkt"))
      ],
    );
  }

  ListTile buildProductTile(AssetSchema element) {
    return ListTile(
        onTap: () {
          showFormDialog(ProductFormReadOnly(
            item: element,
          ));
        },
        hoverColor: Colors.blue.shade200,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(element.name +
                (element.isArchived == true ? " (archivovaný)" : "")),
          ],
        ),
        subtitle: Center(child: Text(element.description ?? "")),
        trailing: element.isArchived == false
            ? ElevatedButton.icon(
                icon: Icon(Icons.archive_outlined),
                label: Text("archivovat"),
                onPressed: () {
                  AssetManagerService()
                      .archiveAssetAssetManagerAssetAssetIdDelete(element.id)
                      .then((value) => _assetTypes.reloadData());
                },
              )
            : null);
  }
}
