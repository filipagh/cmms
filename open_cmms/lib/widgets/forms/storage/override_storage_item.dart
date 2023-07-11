import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/storageManager.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../snacbars.dart';

class OverrideStorageItem extends StatefulWidget implements hasFormTitle {
  final StorageItemSchema item;
  final AssetSchema asset;

  const OverrideStorageItem(this.item, this.asset, {Key? key})
      : super(key: key);

  @override
  String getTitle() {
    return "Prepísať stav skladu : " + asset.name;
  }

  @override
  OverrideStorageItem getInstance() {
    return this;
  }

  @override
  State<OverrideStorageItem> createState() => _OverrideStorageItemState();
}

class _OverrideStorageItemState extends State<OverrideStorageItem> {
  final _formKey = GlobalKey<FormState>();

  String? reason;
  int? newCount;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (value) {
                reason = value!;
              },
              decoration: const InputDecoration(labelText: 'Dôvod zmeny'),
              validator: (value) {
                return value == null || value.isEmpty
                    ? "zvolete dôvod zmeny"
                    : null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (value) {
                newCount = int.tryParse(value!);
              },
              decoration: const InputDecoration(labelText: 'Nový počet kusov'),
              validator: (value) {
                return value != '' && int.tryParse(value ?? "") == null ||
                        int.tryParse(value ?? "")! < 0
                    ? "zadali ste zly format, zadajte cele kladne cislo"
                    : null;
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("spat")),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        StorageManagerService()
                            .storeItemOverrideStorageManagerStoreItemOverridePost(
                                StorageItemOverrideSchema(
                                    reason: reason!,
                                    id: widget.item.id,
                                    newCount: newCount!))
                            .then((value) {
                          print("done");
                          Get.back();
                          showOk("uspesne prepisany stav skladu");
                        });
                      }
                    },
                    child: const Text("prepisať")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
