import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_model.dart';
import 'package:open_cmms/widgets/assets_list.dart';
import 'package:open_cmms/widgets/create_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/assets_managment_form.dart';
import 'package:open_cmms/widgets/forms/asset_management/category_form.dart';

import '../widgets/assets_types_list.dart';
import '../widgets/customAppBar.dart';
import '../widgets/dialog_form.dart';
import '../widgets/mainMenuWidget.dart';

class AssetsManagement extends StatefulWidget {
  const AssetsManagement({
    Key? key,
  }) : super(key: key);

  @override
  State<AssetsManagement> createState() => _AssetsManagementState();
}

class _AssetsManagementState extends State<AssetsManagement> {
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
                  "Assets Management",
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
                      onPressed: () {showFormDialog(CategoryForm.createNewMain());},
                      child: Text("add Main category"),
                    ),
                  ],
                ),
                Divider(),
                AssetsTypeList()
              ],
            ),
          )
        ],
      ),
    );
  }
}

