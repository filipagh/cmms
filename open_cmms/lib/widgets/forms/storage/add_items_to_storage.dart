import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/task_component.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/component_picker.dart';

import '../../../states/asset_types_state.dart';
import '../../../states/items_state.dart';

class _Item {
  late StorageItemSchema storageItem;
  late AssetSchema item;
  int count = 0;

  _Item(this.storageItem, this.item);
}

class AddItemsToStorage extends StatelessWidget
    implements FormWithLoadingIndicator {
  final ItemsStorageState _itemsState = Get.find();
  final AssetTypesState _typeState = Get.find();

  final List<_Item> _items = <_Item>[].obs;

  AddItemsToStorage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              var item =
                  _buildItem(await showFormDialog(ComponentPickerForm()));
              if (item != null) {
                _items.add(item);
              }
            },
            child: const Text("Pridať komponent")),
        SizedBox(
            width: 500,
            height: Get.height - 400,
            child: Obx(() {
              return ListView(children: _buildList());
            })),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Zrušiť")),
            ElevatedButton(
                onPressed: () async {
                  var valid = true;
                  List<AssetItemToAdd> items = [];
                  for (var e in _items) {
                    if (e.count <= 0) {
                      showError("Nesprávne množstvo komponentu " + e.item.name);
                      valid = false;
                      break;
                    }

                    items.add(AssetItemToAdd(
                        storageItemId: e.storageItem.id, countToAdd: e.count));
                  }
                  if (!valid) {
                    return;
                  }
                  isProcessing.value = true;
                  await _itemsState.addToStorage(items).then((value) {
                    _itemsState.reloadData();
                    Get.back();
                    showOk("Komponenty boli naskladnené");
                  });
                },
                child: const Text("Potvrdiť")),
          ],
        )
      ],
    );
  }

  @override
  Widget getContent() {
    return this;
  }

  @override
  RxBool isProcessing = false.obs;

  @override
  String getTitle() {
    return "Naskladniť komponenty";
  }

  buildComponentsString(List<TaskComponent>? taskComponent) {
    var string = '';
    taskComponent?.forEach((element) {
      string =
          string + ' ' + _typeState.getAssetTypeById(element.productId)!.name;
    });
    return string.trim();
  }

  _Item? _buildItem(AssetSchema product) {
    var exist =
        _items.firstWhereOrNull((element) => element.item.id == product.id);
    if (exist == null) {
      return _Item(_itemsState.getByAssetId(product.id)!, product);
    }
    return null;
  }

  List<Widget> _buildList() {
    List<Widget> list = [];
    _items.forEach((element) {
      list.add(Card(
        child: ListTile(
          title: Row(
            children: [
              Text(element.item.name),
              const Spacer(),
              Flexible(
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Množstvo',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {
                    element.count = int.tryParse(value) ?? 0;
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    _items.remove(element);
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ),
      ));
    });
    return list;
  }
}
