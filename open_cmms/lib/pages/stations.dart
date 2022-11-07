import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/assets_list.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Stations extends StatelessWidget {
  static const ENDPOINT = '/Stations';

  final RxList<StationSchema> _stations = <StationSchema>[].obs;

  Stations({
    Key? key,
  }) : super(key: key) {
    StationService().getAllStationStationsGet().then((value) {
      _stations.addAll(value ?? []);
      _stations.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Statios",
                  textScaleFactor: 5,
                ),
                Row(
                  children: const [
                    Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    Spacer(),
                    // ElevatedButton(
                    //   onPressed: () {showdialog();},
                    //   child: Text("add station"),
                    // ),
                  ],
                ),
                const Divider(),
                // AssetsList(list: stationsState.getAllStations(),),
                Obx(
                  () {
                    return AssetsList(
                      list: _stations.value,
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
