import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:open_cmms/pages/assets.dart';
import 'package:open_cmms/pages/assets_management.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/roadSegments.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/storage.dart';
import 'package:open_cmms/pages/task.dart';
import 'package:open_cmms/pages/tasks.dart';
import 'package:open_cmms/pages/roadSegment.dart';
import 'package:open_cmms/pages/unknownPage.dart';
import 'package:open_cmms/states/items_types_state.dart';
import 'package:open_cmms/states/state_asset_types.dart';
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
          name: '/Assets/',
          page: () {
            return Assets();
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
          name: '/Assets/:id',
          page: () {
            return StationBasePage(assetId: Get.parameters["id"]!, contextPageEnum: StationBaseContextPageEnum.info,);
          },
        ),
        GetPage(
          name: '/Assets/:id/Info/',
          page: () {
            return StationBasePage(assetId: Get.parameters["id"]!, contextPageEnum: StationBaseContextPageEnum.info,);
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

