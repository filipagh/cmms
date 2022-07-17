import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/asset_types_state.dart';

class AssetsTypeList extends StatelessWidget {
  // final List<AssetTypeListView> list;

  const AssetsTypeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StateAssetTypes assetTypes = Get.find();
    return GetX<StateAssetTypes>(
        builder: (_) { var list =  assetTypes.getData();
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
              );});
  }
}
