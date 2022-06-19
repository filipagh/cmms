import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_type.dart';

class AssetsTypeList extends StatelessWidget {
  // final List<AssetTypeListView> list;

  const AssetsTypeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AssetTypeListView> list = getData();
    print(list.length);
    return list.isEmpty
        ? const Expanded(
            child: Center(
                child: Text(
            "No Asset Types",
            textScaleFactor: 3,
          )))
        : Expanded(
            child: ListView.builder(
                addRepaintBoundaries: true,
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return list[index].toListItem();
                }),
          );
  }

  List<AssetTypeListView> getData() {
    List<AssetTypeListView> listItems = [];

    getMainAssetBaseTypes().forEach((element) {
      listItems.add(element);
      getAssetBaseTypeByParentId(element.id).forEach((element) {
        listItems.add(element);
        getAssetTypeByParentId(element.id).forEach((element) {
          listItems.add(element);
        });
      });
      getAssetTypeByParentId(element.id).forEach((element) {
        listItems.add(element);
      });
    });
    return listItems;
  }
}
