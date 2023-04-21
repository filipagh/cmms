import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_components_page.dart';
import 'package:open_cmms/pages/station/station_history_page.dart';
import 'package:open_cmms/pages/station/station_info_page.dart';
import 'package:open_cmms/pages/station/station_tab_menu.dart';
import 'package:open_cmms/pages/station/station_tasks_page.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/states/station/station_state.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu_widget.dart';

class StationBasePage extends StatelessWidget {
  static const String ENDPOINT = '/Station';
  final String assetId;
  final StationBaseContextPageEnum contextPageEnum;

  StationBasePage(
      {Key? key, required this.contextPageEnum, required this.assetId})
      : super(key: key) {}

  Rxn<StationSchema> station = Rxn<StationSchema>();
  RxBool isModelLoaded = false.obs;

  Widget buildContent() {
    if (!isModelLoaded.value) {
      return buildMissingRoadSegment();
    }
    if (station.value != null) {
      return buildRoadSegment();
    }
    return buildMissingRoadSegment();
  }

  Widget build(BuildContext context) {
    StationService().getByIdStationStationGet(assetId).then((stationschema) {
      station.value = stationschema;
      isModelLoaded.value = true;
      station.refresh();
    });
    StationState ts;
    try {
      ts = Get.find();
    } catch (e) {
      print("put");
      ts = Get.put(StationState(assetId));
    }
    print(ts.station?.id ?? "null");
    return Scaffold(
      appBar: CustomAppBar(pageText: Obx(() => Text(getTitle()))),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: Obx(() {
              return buildContent();
            }),
          )
        ],
      ),
    );
  }

  Widget buildRoadSegment() {
    Widget? contextWidget;
    switch (contextPageEnum) {
      case StationBaseContextPageEnum.info:
        {
          contextWidget = StationInfoPage(station: station.value!);
        }
        break;
      case StationBaseContextPageEnum.components:
        {
          contextWidget = StationComponentsPage(station: station.value!);
        }
        break;
      case StationBaseContextPageEnum.history:
        {
          contextWidget = StationHistoryPage(station: station.value!);
        }
        break;
      case StationBaseContextPageEnum.tasks:
        contextWidget = StationTasksPage(station: station.value!);
        break;
    }
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 10)),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: StationTabMenu(stationId: assetId),
              ),
              VerticalDivider(),
              Expanded(
                child: contextWidget,
              ),
            ],
          ),
        )
        // StationBasePage(contextPage:  widget.contextPage(roadSegmentModel),contextPageEnum: widget.contextPageEnum,),
      ],
    );
  }

  Widget buildMissingRoadSegment() {
    return Center(
        child: Text(
      "Stanica s ID: " + assetId + " neexistuje",
      textScaleFactor: 2,
    ));
  }

  getTitle() {
    var station = this.station.value;
    if (station == null) {
      return "Stanica: ";
    }
    var title = "";
    if (!station.isActive) {
      title += "Zrušená ";
    }
    title += "Stanica: " + station.name;
    return title;
  }
}

abstract class StationBaseContextPage extends Widget {
  final StationSchema station;

  const StationBaseContextPage({Key? key, required this.station})
      : super(key: key);
}

enum StationBaseContextPageEnum {
  info,
  components,
  history,
  tasks,
}
