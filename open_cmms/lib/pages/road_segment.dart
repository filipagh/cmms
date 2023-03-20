import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/assets_list.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/station/station_form.dart';

import '../snacbars.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class RoadSegment extends StatelessWidget {
  final String segmentId;
  RoadSegmentSchema? _roadSegment;
  final List<StationSchema> _station = <StationSchema>[].obs;
  RxBool loaded = false.obs;

  RoadSegment({
    Key? key,
    required this.segmentId,
  }) : super(key: key) {
    RoadSegmentService()
        .getByIdRoadSegmentManagerSegmentGet(segmentId)
        .then((value) {
      _roadSegment = value;
      loaded.value = true;
      reloadStations();
    });
  }

  reloadStations() {
    StationService()
        .getAllStationStationsGet(roadSegmentId: segmentId)
        .then((stations) {
      _station.clear();
      _station.addAll(stations!);
    });
  }

  Widget buildContent() {
    if (_roadSegment != null) {
      return buildRoadSegment();
    }
    if (loaded.value) {
      return CircularProgressIndicator();
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
            child: Obx(() {
              return buildContent();
            }),
          )
        ],
      ),
    );
  }

  Column buildRoadSegment() {
    return Column(
      children: [
        Text(
          "Road Segment " + _roadSegment!.name,
          textScaleFactor: 5,
        ),
        Divider(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                                onPressed: () {
                                  showFormDialog(StationForm(_roadSegment!));
                                },
                                child: Text("Pridat stanicu"))),
                        Align(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Stations", textScaleFactor: 3),
                            IconButton(
                                onPressed: () {
                                  reloadStations();
                                },
                                icon: Icon(Icons.refresh))
                          ],
                        )),
                      ],
                    ),
                    Divider(),
                    _station.isEmpty
                        ? buildEmptyStationList()
                        : AssetsList(list: _station),
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

  Widget buildEmptyStationList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("No Stations"),
        ElevatedButton(
          onPressed: () {
            showInfo("not implemented yet");
            // _roadSegment.remove(segmentId);
          },
          child: Text("remove this Road Segment"),
        ),
      ],
    ));
  }

  Widget buildMissingRoadSegment() {
    return Center(
        child: Text(
      "Missing data for Road Segment ID: " + segmentId,
      textScaleFactor: 2,
    ));
  }
}
