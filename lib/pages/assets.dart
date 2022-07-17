import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:open_cmms/widgets/assets_list.dart';
import 'package:open_cmms/widgets/create_form.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class Assets extends StatefulWidget {
  const Assets({
    Key? key,
  }) : super(key: key);

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  @override
  Widget build(BuildContext context) {
    StationsState stationsState = Get.find();
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
                  "Assets",
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
                AssetsList(list: stationsState.station.values.toList(),),
              ],
            ),
          )
        ],
      ),
    );
  }
}

