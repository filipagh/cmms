import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_model.dart';
import 'package:open_cmms/widgets/assets_list.dart';
import 'package:open_cmms/widgets/create_form.dart';
import 'package:open_cmms/widgets/items_list.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class Storage extends StatefulWidget {
  const Storage({
    Key? key,
  }) : super(key: key);

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
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
                Text(
                  "Storage",
                  textScaleFactor: 5,
                ),
                Row(
                  children: [
                    Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {showdialog();},
                      child: Text("add asset"),
                    ),
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

