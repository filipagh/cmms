import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:open_cmms/pages/asset.dart';
import 'package:open_cmms/pages/assets.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/roadSegments.dart';
import 'package:open_cmms/pages/task.dart';
import 'package:open_cmms/pages/tasks.dart';
import 'package:open_cmms/pages/roadSegment.dart';
import 'package:open_cmms/pages/unknownPage.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.noTransition,
      // initialRoute: '/',
      getPages: [
        GetPage(
          name: '/RoadSegments/:id',
          page: () {
            return RoadSegment(segmentId: Get.parameters["id"]!);
          },
        ),
        GetPage(
          name: '/RoadSegments/',
          page: () {
            return const RoadSegments();
          },
        ),
        GetPage(
          name: '/Assets',
          page: () {
            return Assets();
          },
        ),
        GetPage(
          name: '/Tasks',
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
            return Asset(assetId: Get.parameters["id"]!);
          },
        ),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
      unknownRoute: GetPage(
          transition: Transition.noTransition,
          name: '/badpage',
          page: () {
            return const UnknownPage();
          }),
    );
  }
}
