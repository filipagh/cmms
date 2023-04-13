import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_cmms/service/backend_api/issues_service.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Dashboard extends StatelessWidget {
  Dashboard({
    Key? key,
  }) : super(key: key);

  RxList<StationSchema> stations = <StationSchema>[].obs;
  RxList<IssueSchema> issues = <IssueSchema>[].obs;

  @override
  Widget build(BuildContext context) {
    loadStation();
    loadIssues();
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
                  "DashBoard",
                  textScaleFactor: 5,
                ),
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(48.6, 19.67),
                      zoom: 9,
                    ),
                    children: [
                      TileLayer(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c']),
                      Obx(() {
                        return MarkerLayer(markers: [
                          ...(stations
                              .map((e) => Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: LatLng(e.longitude!.toDouble(),
                                        e.latitude!.toDouble()),
                                    builder: (ctx) => Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            e.name,
                                            style: TextStyle(
                                                backgroundColor: Colors.white),
                                          ),
                                          Icon(
                                            Icons.location_on,
                                            color: issues.value.firstWhereOrNull(
                                                        (element) =>
                                                            element.stationId ==
                                                            e.id) ==
                                                    null
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList())
                        ]);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void loadStation() {
    StationService().getAllStationStationsGet().then((value) {
      stations.assignAll(value!);
    });
  }

  void loadIssues() {
    IssuesService().getActiveIssuesIssuesActiveGet().then((value) {
      issues.assignAll(value!);
    });
  }
}
