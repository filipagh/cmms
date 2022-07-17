import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/road_segment_asset_connector_model.dart';
import 'package:open_cmms/models/road_segment_model.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:open_cmms/widgets/assets_list.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class RoadSegment extends StatefulWidget {
  final String segmentId;

  const RoadSegment({
    Key? key,
    required this.segmentId,
  }) : super(key: key);

  @override
  State<RoadSegment> createState() => _RoadSegmentState();
}

class _RoadSegmentState extends State<RoadSegment> {
  StationsState stationsState = Get.find();
  RoadSegmentModel? roadSegmentModel;
  List<Station> stationsList = [];
  bool isModelLoaded = false;

  @override
  void initState() {
    roadSegmentModel = getDummyRoadSegmentsById(widget.segmentId);

    stationsList = [];
    var ids = getAssetsIdsByRoadSegmentId(roadSegmentModel!.id);
    stationsState.station.forEach((key, value) {
      if (ids.contains(value.id)) {
        stationsList.add(value);
      }
    });
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

  Column buildRoadSegment() {
    return Column(
      children: [
        Text(
          "Road Segment " + roadSegmentModel!.name,
          textScaleFactor: 5,
        ),
        Divider(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("Stations", textScaleFactor: 3),
                    Divider(),
                    AssetsList(list: stationsList),
                  ],
                ),
              ),
              VerticalDivider(),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    Text("road segment detail"),
                    Expanded(child: Placeholder()),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildMissingRoadSegment() {
    return Center(
        child: Text(
      "Missing data for Road Segment ID: " + widget.segmentId,
      textScaleFactor: 2,
    ));
  }
}
