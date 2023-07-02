import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/asset_types_state.dart';

class ProductFormReadOnly extends StatefulWidget implements hasFormTitle {
  final AssetTypesState assetTypes = Get.find();
  late final AssetSchema? item;
  late final AssetCategorySchema parent;
  final List<AssetTelemetry> telemetry = <AssetTelemetry>[].obs;

  ProductFormReadOnly({Key? key, this.item}) : super(key: key) {
    parent = assetTypes.getAssetTypeById(item!.categoryId)!;
  }

  @override
  State<ProductFormReadOnly> createState() => ProductFormReadOnlyState();

  String getTitle() {
    return "Produkt : ${item!.name}";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class ProductFormReadOnlyState extends State<ProductFormReadOnly> {
  final AssetTypesState assetTypes = Get.find();

  late AssetCategorySchema _mainCat;
  AssetCategorySchema? _subCat;

  @override
  void initState() {
    _mainCat = widget.parent.parentId == null
        ? widget.parent
        : assetTypes.getAssetTypeById(widget.parent.parentId!)!;
    if (_mainCat != widget.parent) {
      _subCat = widget.parent;
    }
    widget.telemetry.addAll(widget.item?.telemetry ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              readOnly: true,
              initialValue: widget.item == null ? "" : widget.item!.name,
              decoration: InputDecoration(labelText: 'názov'),
            ),
            TextFormField(
              readOnly: true,
              initialValue: widget.item == null ? "" : widget.item!.name,
              decoration: InputDecoration(labelText: 'popis'),
            ),
            Divider(),
            Text("Hlavna kategoria: " + _mainCat.name),
            Text("Vedlajsia kategoria: " + (_subCat?.name ?? "---")),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Telemetria: "),
              ],
            ),
            Obx(() {
              return SizedBox(
                width: 500,
                height: Get.height - 400,
                child: ListView.builder(
                  itemCount: widget.telemetry.length,
                  itemBuilder: (BuildContext context, int index) {
                    var t = widget.telemetry[index];
                    return Card(
                      child: ListTile(
                        title: Center(
                            child:
                                Text(t.type.value + "  |  " + t.value.value)),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Zavrieť")),
          ],
        )
      ],
    );
  }
}
