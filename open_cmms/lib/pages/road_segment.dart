import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/station/station_form.dart';

import '../service/backend_api/tasks/tasks_on_site_service.dart';
import '../snacbars.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';
import '../widgets/stations_list.dart';

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
        .getRoadSegmentStationsStationStationsOfRoadSegmentGet(
      segmentId,
      onlyActive: !_show_deleted.value,
    )
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "Profylaxia",
                                    content: Text(
                                        "Chcete zadať profylaxiu cestneho useku? (Nová úloha pre každú stanicu)"),
                                    confirm: ElevatedButton(
                                      onPressed: () {
                                        TasksOnSiteService()
                                            .createTaskServiceOnSiteCreateServiceOnSideTaskPost(_station
                                                .where((element) =>
                                                    element.isActive)
                                                .map((e) =>
                                                    TaskServiceOnSiteNewSchema(
                                                        stationId: e.id,
                                                        name: "Profylaxia " +
                                                            e.name,
                                                        description:
                                                            "Hromadna profylaxia cestného useku: " +
                                                                _roadSegment!
                                                                    .name))
                                                .toList())
                                            .then((value) {
                                          Get.back();
                                          showOk("Profylaxia bola zadaná");
                                        }, onError: (e) {
                                          showError(
                                              "Chyba pri zadávaní profylaxie: $e");
                                        });
                                      },
                                      child: Text("Ano"),
                                    ),
                                    cancel: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("Nie"),
                                    ),
                                  );
                                },
                                child: Text("Zadať profylaxiu cestného úseku")),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            ElevatedButton(
                                onPressed: () {
                                  showFormDialog(StationForm(_roadSegment!))
                                      .then((value) => reloadStations());
                                },
                                child: Text("Pridat stanicu")),
                          ],
                        )),
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
                  : Expanded(
                      child: ListView.builder(
                          addRepaintBoundaries: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: _station.length,
                          itemBuilder: (BuildContext context, int index) {
                            return getStationCard(_station[index]);
                          }),
                    ),
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
      "Zadné údaje pre cestný úsek ID: " + segmentId,
      textScaleFactor: 2,
    ));
  }
}
