import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:open_cmms/widgets/assets_list.dart';
import 'package:open_cmms/widgets/create_form.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Stations extends StatefulWidget {
  static const ENDPOINT = '/Stations';

  const Stations({
    Key? key,
  }) : super(key: key);

  @override
  State<Stations> createState() => _StationsState();
}

class _StationsState extends State<Stations> {
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
                  "Statios",
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
                      child: Text("add station"),
                    ),
                  ],
                ),
                Divider(),
                AssetsList(list: stationsState.getAllStations(),),
              ],
            ),
          )
        ],
      ),
    );
  }
}

