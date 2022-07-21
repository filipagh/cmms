import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:open_cmms/pages/assets_management.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/road_segment.dart';
import 'package:open_cmms/pages/road_segments.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/station/station_components_page.dart';
import 'package:open_cmms/pages/stations.dart';
import 'package:open_cmms/pages/storage.dart';
import 'package:open_cmms/pages/task.dart';
import 'package:open_cmms/pages/tasks.dart';
import 'package:open_cmms/pages/unknownPage.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/assigned_component_state.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.put(StateAssetTypes());
    Get.put(ItemsState());
    Get.put(StationsState());
    Get.put(AssignedComponentState());
    return GetMaterialApp(
      defaultTransition: Transition.noTransition,
      getPages: [
        GetPage(
          name: '/RoadSegments/:id',
          page: () {
            return RoadSegment(segmentId: Get.parameters["id"]!);
          },
        ),
        GetPage(
          name: '/AssetManagement',
          page: () {
            return AssetsManagement();
          },
        ),
        GetPage(
          name: '/RoadSegments',
          page: () {
            return RoadSegments();
          },
        ),
        GetPage(
          name: '/Storage',
          page: () {
            return const Storage();
          },
        ),
        GetPage(
          name: Stations.ENDPOINT,
          page: () {
            return Stations();
          },
        ),
        GetPage(
          name: '/Tasks/',
          page: () {
            return Tasks();
          },
        ),
        GetPage(
          name: '/Tasks/:id',
          page: () {
            return Task(taskId: Get.parameters["id"]!,);
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT+'/:id',
          page: () {
            return StationBasePage(assetId: Get.parameters["id"]!, contextPageEnum: StationBaseContextPageEnum.info,);
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT+'/:id/Info/',
          page: () {
            return StationBasePage(assetId: Get.parameters["id"]!, contextPageEnum: StationBaseContextPageEnum.info,);
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT+'/:id'+StationComponentsPage.ENDPOINT,
          page: () {
            return StationBasePage(assetId: Get.parameters["id"]!, contextPageEnum: StationBaseContextPageEnum.components,);
          },
        ),

        GetPage(
          name: '/',
          page: () {
            return Dashboard();
          },
        ),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      unknownRoute: GetPage(
          transition: Transition.noTransition,
          name: '/badpage/',
          page: () {
            return const UnknownPage();
          }),
    );
  }
}

