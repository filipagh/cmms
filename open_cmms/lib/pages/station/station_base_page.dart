import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_components_page.dart';
import 'package:open_cmms/pages/station/station_info_page.dart';
import 'package:open_cmms/pages/station/station_tab_menu.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:open_cmms/states/test_state.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu_widget.dart';

class StationBasePage extends StatelessWidget {
  static const String ENDPOINT = '/Station';
  final String assetId;
  final StationBaseContextPageEnum contextPageEnum;

  StationBasePage(
      {Key? key, required this.contextPageEnum, required this.assetId})
      : super(key: key) {

    // Get.lazyPut(() => TestState());


  }

  StationsState stationsState = Get.find();
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
    StationService().getByIdStationStationGet(assetId).then((stationschema) {station.value = stationschema; isModelLoaded.value=true; station.refresh();});
    TestState ts;
    try { ts = Get.find(); }catch (e) {
      print("put");
       ts = Get.put(TestState());
    }
    print(ts.getAndInc());
    print("build");
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: Obx(() {return buildContent();}),
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
    }
    return Column(
      children: [
        Text(
          "Station: " + station.value!.id,
          textScaleFactor: 5,
        ),
        Divider(),
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
      "Missing data for Asset ID: " + assetId,
      textScaleFactor: 2,
    ));
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
}
