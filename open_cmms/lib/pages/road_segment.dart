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
    loadSegment();
  }

  void loadSegment() {
    loaded.value = false;
    RoadSegmentService()
        .getByIdRoadSegmentManagerSegmentGet(segmentId)
        .then((value) {
      _roadSegment = value;
      loaded.value = true;
      if (!_roadSegment!.isActive) {
        _show_deleted.value = true;
      }
      reloadStations();
    });
  }

  RxBool _show_deleted = false.obs;

  reloadStations() {
    StationService()
        .getAllStationStationsGet(
            onlyActive: !_show_deleted.value, roadSegmentId: segmentId)
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
      appBar: CustomAppBar(
        pageText: getTitle(),
      ),
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

  Obx getTitle() {
    return Obx(() {
      if (loaded.isFalse) {
        return Text("Cestný úsek: ");
      }
      return Text(_roadSegment!.isActive
          ? ""
          : "Zrušený " +
              "Cestný úsek: " +
              _roadSegment!.name +
              " (ssud: " +
              _roadSegment!.ssud +
              ")");
    });
  }

  Column buildRoadSegment() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 10)),
        Expanded(
          child: Column(
            children: [
              Stack(
                children: [
                  if (_roadSegment!.isActive)
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                onPressed: () {
                                  RoadSegmentService()
                                      .removeSegmentRoadSegmentManagerRemoveSegmentDelete(
                                          RoadSegmentIdSchema(
                                              id: _roadSegment!.id))
                                      .then((value) {
                                    loadSegment();
                                    showOk("Cestný úsek bol zmazaný");
                                  }, onError: (e) {
                                    showError(
                                        "Chyba pri mazaní cestneho useku + $e");
                                  });
                                },
                                child: Text("Zmazat cestny usek")),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text("zobraziť zmazané"),
                            Obx(() => Checkbox(
                                value: _show_deleted.value,
                                onChanged: (v) {
                                  _show_deleted.value = v!;
                                  reloadStations();
                                }))
                          ],
                        )),
                  if (_roadSegment!.isActive)
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
                      Text("Stanice", textScaleFactor: 3),
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
        )
      ],
    );
  }

  Widget buildEmptyStationList() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
          children: const [
        Text("žiadne stanice"),
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
