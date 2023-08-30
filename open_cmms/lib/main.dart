import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/auth_guard.dart';
import 'package:open_cmms/pages/assets_management.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/forbidden.dart';
import 'package:open_cmms/pages/investment_contracts.dart';
import 'package:open_cmms/pages/issue_report.dart';
import 'package:open_cmms/pages/issues.dart';
import 'package:open_cmms/pages/login.dart';
import 'package:open_cmms/pages/news.dart';
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
import 'package:open_cmms/pages/unverified.dart';
import 'package:open_cmms/pages/users.dart';
import 'package:open_cmms/service/secrets_manager_service.dart';
import 'package:open_cmms/states/action_state.dart';
import 'package:open_cmms/states/asset_telemetry_state.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';
import 'package:open_cmms/states/auth_state.dart';
import 'package:open_cmms/states/items_state.dart';
import 'package:open_cmms/states/items_state_dummy.dart';
import 'package:open_cmms/states/road_segment_state.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:open_cmms/states/task_component_state.dart';
import 'package:open_cmms/states/tasks_state.dart';

import 'pages/config/config.dart';

void main() async {
  await checkOrLoadEnv();

  // var a = await BackEndService().getUserLoginGetWithHttpInfo();

  runApp(const MyApp());
}

void loadPostLoginStates() {
  Get.put(AssetTypesState(), permanent: true); //api
  Get.put(ItemsStorageState(), permanent: true); // api
  Get.put(AssetTelemetryState(), permanent: true); //api
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AuthState());
    Get.put(RoadSegmentState());
    Get.put(StationsState());
    Get.put(AssetTypesStateDummy());
    Get.put(ItemsState_dummy());
    Get.put(TasksState());
    Get.put(ActionState());
    Get.put(TaskComponentState());

    return GetMaterialApp(
      defaultTransition: Transition.noTransition,
      getPages: [
        GetPage(
            name: '/RoadSegment/:id',
            page: () {
              return RoadSegment(segmentId: Get.parameters["id"]!);
            },
            middlewares: [AuthGuard()]),
        GetPage(
            name: '/AssetManagement',
            page: () {
              return AssetsManagement();
            },
            middlewares: [AuthGuard()]),
        GetPage(
            name: ServiceContracts.ENDPOINT,
            page: () {
              return ServiceContracts();
            },
            middlewares: [AuthGuard()]),
        GetPage(
            name: InvestmentContracts.ENDPOINT,
            page: () {
              return InvestmentContracts();
            },
            middlewares: [AuthGuard()]),
        GetPage(
            name: '/RoadSegments',
            page: () {
              return RoadSegments();
            },
            middlewares: [AuthGuard()]),
        GetPage(
          name: '/Storage',
          page: () {
            return Storage();
          },
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: Stations.ENDPOINT,
          page: () {
            return Stations();
          },
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: '/Tasks/',
          page: () {
            return Tasks();
          },
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: TaskChangeComponentsPage.ENDPOINT + '/:id',
          page: () {
            return TaskChangeComponentsPage(taskId: Get.parameters["id"]!);
          },
          middlewares: [AuthGuard()],
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
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: TaskPage.ENDPOINT + '/:id',
          page: () {
            return TaskPage(
              taskId: Get.parameters["id"]!,
            );
          },
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id',
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.info,
            );
          },
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id' + StationInfoPage.ENDPOINT,
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.info,
            );
          },
          middlewares: [AuthGuard()],
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
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id' + StationHistoryPage.ENDPOINT,
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.history,
            );
          },
          middlewares: [AuthGuard()],
        ),
        GetPage(
          name: StationBasePage.ENDPOINT + '/:id' + StationTasksPage.ENDPOINT,
          page: () {
            return StationBasePage(
              assetId: Get.parameters["id"]!,
              contextPageEnum: StationBaseContextPageEnum.tasks,
            );
          },
          middlewares: [AuthGuard()],
        ),

        GetPage(
            name: '/',
            page: () {
              return Dashboard();
            },
            middlewares: [AuthGuard()]),
        GetPage(
            name: IssuesPage.ENDPOINT,
            page: () {
              return IssuesPage();
            },
            middlewares: [AuthGuard()]),

        // +++++++++++++++++++++++++++++++++++++++++++++++++++   ADMIN

        GetPage(
            name: Users.ENDPOINT,
            page: () {
              return Users();
            },
            middlewares: [AuthGuard(), AdminGuard()]),
        GetPage(
            name: Config.ENDPOINT,
            page: () {
              return Config();
            },
            middlewares: [AuthGuard(), AdminGuard()]),

        // +++++++++++++++++++++++++++++++++++++++++++++++++++   PUBLIC
        GetPage(
            name: IssueReportPage.ENDPOINT,
            page: () {
              return IssueReportPage();
            }),
        GetPage(
            name: Forbidden.ENDPOINT,
            page: () {
              return Forbidden();
            }),
        GetPage(
            name: Unverified.ENDPOINT,
            page: () {
              return Unverified();
            }),
        GetPage(
            name: News.ENDPOINT,
            page: () {
              return News();
            }),
        GetPage(
            name: Login.ENDPOINT,
            page: () {
              return Login();
            })
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
