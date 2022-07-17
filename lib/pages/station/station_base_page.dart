import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/pages/station/station_components_page.dart';
import 'package:open_cmms/pages/station/station_info_page.dart';
import 'package:open_cmms/pages/station/station_tab_menu.dart';
import 'package:open_cmms/states/stations_state.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu_widget.dart';

class StationBasePage extends StatefulWidget {
  static const String ENDPOINT = '/Assets';
  final String assetId;
  final StationBaseContextPageEnum contextPageEnum;

  const StationBasePage(
      {Key? key, required this.contextPageEnum, required this.assetId})
      : super(key: key);

  @override
  State<StationBasePage> createState() => _StationBasePageState();
}

class _StationBasePageState extends State<StationBasePage> {
  StationsState stationsState = Get.find();
  Station? roadSegmentModel;
  bool isModelLoaded = false;

  @override
  void initState() {
    roadSegmentModel = stationsState.station[widget.assetId];
    super.initState();
  }

  Widget buildContent() {
    if (roadSegmentModel != null) {
      return buildRoadSegment();
    }
    return buildMissingRoadSegment();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: buildContent(),
          )
        ],
      ),
    );
  }

  Widget buildRoadSegment() {
    Widget? contextWidget;
    switch (widget.contextPageEnum) {
      case StationBaseContextPageEnum.info:
        {
          contextWidget = StationInfoPage(station: roadSegmentModel!);
        }
        break;
      case StationBaseContextPageEnum.components:
        {
          contextWidget = StationComponentsPage(station: roadSegmentModel!);
        }
    }
    return Column(
      children: [
        Text(
          "Asset " + roadSegmentModel!.id,
          textScaleFactor: 5,
        ),
        Divider(),
        Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 200,
                child: StationTabMenu(stationId: widget.assetId),
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
      "Missing data for Asset ID: " + widget.assetId,
      textScaleFactor: 2,
    ));
  }
}

abstract class StationBaseContextPage extends Widget {
  final Station station;

  const StationBaseContextPage({Key? key, required this.station})
      : super(key: key);
}

enum StationBaseContextPageEnum {
  info,
  components,
}
