import 'dart:js_util';

import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/asset_types_state.dart';
import '../states/asset_types_state_dummy.dart';
import 'dialog_form.dart';
import 'forms/asset_management/category_form.dart';
import 'forms/asset_management/product_form.dart';

class AssetsTypeList extends StatelessWidget {

  const AssetsTypeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssetTypesState _assetTypes = Get.find();
    return GetX<AssetTypesState>(
        builder: (_) { var list =  _assetTypes.getData();
          return list.isEmpty
            ? const Expanded(
                child: Center(
                    child: Text(
                "No Asset Types",
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
              );});
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
              child: Text("add category")),
        ElevatedButton(
            onPressed: () {
              showFormDialog(ProductForm.createNew(
                parent: element,
              ));
            },
            child: Text("add product"))
      ],
    );
  }

  ListTile buildProductTile(AssetSchema element) {
    return ListTile(
      onTap: () {
        showFormDialog(ProductForm.editItem(
          editItem: element,
        ));
      },
      hoverColor: Colors.blue.shade200,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(element.name),
        ],
      ),
      // subtitle:
      // Center(child: Text('station Id: ${list[index].id}')),
    );
  }
}
