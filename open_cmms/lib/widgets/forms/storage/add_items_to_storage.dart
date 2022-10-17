
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/task_component.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/add_component.dart';

import '../../../states/asset_types_state.dart';
import '../../../states/items_state.dart';

class _Item {
  late StorageItemSchema storageItem;
  late AssetSchema item;
  int count = 0;

  _Item(this.storageItem, this.item);
}

class AddItemsToStorage extends StatelessWidget implements hasFormTitle {
  final ItemsState _itemsState = Get.find();
  final AssetTypesState _typeState = Get.find();

  final List<_Item> _items = <_Item>[].obs;

  AddItemsToStorage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              var item = _buildItem(await showFormDialog(AddComponentForm()));
              if (item != null) {
                _items.add(item);
              }
            },
            child: const Text("Pridať komponent")),
        SizedBox(
            width: 500,
            height: 600,
            child: Obx(() {
              return ListView(children: _buildList());
            })),
      ],
    );
  }

  @override
  Widget getInstance() {
    return this;
  }

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
    var exist =_items.firstWhereOrNull((element) => element.item.id == product.id);
    if (exist==null) {
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
                  keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    element.count = int.tryParse(value)?? 0;
                  },
                ),
              ),
              IconButton(onPressed: () {_items.remove(element);}, icon: Icon(Icons.delete))
            ],
          ),
        ),
      ));
    });
    return list;
  }
}
