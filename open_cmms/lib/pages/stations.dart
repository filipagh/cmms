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
  RxBool _include_deleted_stations = false.obs;

  Stations({
    Key? key,
  }) : super(key: key) {
    loadStations();
  }

  void loadStations() {
    StationService()
        .getAllStationStationsGet(onlyActive: !_include_deleted_stations.value)
        .then((value) {
      _stations.clear();
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
                  "Stanica",
                  textScaleFactor: 5,
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Hľadať (WIP)",
                          enabled: false,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    const Text("Zobraziť zmazané"),
                    Obx(() => Checkbox(
                        value: _include_deleted_stations.value,
                        onChanged: (v) {
                          _include_deleted_stations.value = v!;
                          loadStations();
                        })),
                    const Spacer(),
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
