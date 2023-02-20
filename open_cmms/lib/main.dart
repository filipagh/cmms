import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/assets_management.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/road_segment.dart';
import 'package:open_cmms/pages/road_segments.dart';
import 'package:open_cmms/pages/service_contracts.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/station/station_components_page.dart';
import 'package:open_cmms/pages/station/station_history_page.dart';
import 'package:open_cmms/pages/station/station_info_page.dart';
import 'package:open_cmms/pages/station/station_tasks_page.dart';
import 'package:open_cmms/pages/stations.dart';
import 'package:open_cmms/pages/storage.dart';
import 'package:open_cmms/pages/task.dart';
import 'package:open_cmms/pages/tasks.dart';
import 'package:open_cmms/pages/tasks/task_change_component.dart';
import 'package:open_cmms/pages/tasks/task_on_site_service.dart';
import 'package:open_cmms/pages/tasks/task_remote_service.dart';
import 'package:open_cmms/pages/unknownPage.dart';
import 'package:open_cmms/service/secrets_manager_service.dart';
import 'package:open_cmms/states/action_state.dart';
import 'package:open_cmms/states/asset_telemetry_state.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/states/items_state_dummy.dart';
import 'package:open_cmms/states/road_segment_state.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:open_cmms/states/task_component_state.dart';
import 'package:open_cmms/states/tasks_state.dart';

void main() async {
  await checkOrLoadEnv();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RoadSegmentState());
    Get.put(StationsState());
    Get.put(AssetTypesStateDummy());
    Get.put(AssetTypesState());
    Get.put(ItemsState_dummy());
    Get.put(ItemsStorageState());
    Get.put(TasksState());
    Get.put(ActionState());
    Get.put(TaskComponentState());
    Get.put(AssetTelemetryState());
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
          name: ServiceContracts.ENDPOINT,
          page: () {
            return ServiceContracts();
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
            return TaskPage(
              taskId: Get.parameters["id"]!,
            );
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id',
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.info,
            );
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id' + StationInfoPage.ENDPOINT,
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.info,
            );
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT +
              '/:id' +
              StationComponentsPage.ENDPOINT,
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.components,
            );
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id' + StationHistoryPage.ENDPOINT,
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.history,
            );
          },
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id' + StationTasksPage.ENDPOINT,
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.tasks,
            );
          },
        ),
        GetPage(
          name: TaskChangeComponentsPage.ENDPOINT + '/:id',
          page: () {
            return TaskChangeComponentsPage(taskId: Get.parameters["id"]!);
          },
        ),
        GetPage(
          name: TaskOnSiteServicePage.ENDPOINT + '/:id',
          page: () {
            return TaskOnSiteServicePage(taskId: Get.parameters["id"]!);
          },
        ),
        GetPage(
          name: TaskRemoteServicePage.ENDPOINT + '/:id',
          page: () {
            return TaskRemoteServicePage(taskId: Get.parameters["id"]!);
          },
        ),
        GetPage(
          name: '/',
          page: () {
            return const Dashboard();
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
