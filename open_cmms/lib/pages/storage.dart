import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/widgets/create_form.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/storage/add_items_to_storage.dart';
import 'package:open_cmms/widgets/items_list.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Storage extends StatefulWidget {
  const Storage({
    Key? key,
  }) : super(key: key);

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final ItemsState items = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sklad",
                      textScaleFactor: 5,
                    ),
                    IconButton(onPressed: () {items.reloadData();}, icon: const Icon(Icons.refresh), iconSize: 50,)
                  ],
                ),
                Row(
                  children: [
                    Placeholder(
                      child: SizedBox(width: 300, child: Text("Vyhľadávač")),
                    ),
                    Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    Spacer(),
                    ElevatedButton(onPressed: () {showFormDialog(AddItemsToStorage());}, child: Text("Pridat do skladu"))
                  ],
                ),
                Divider(),
                ItemsList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

