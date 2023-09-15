import 'package:BackendAPI/api.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class StationsMissingServiceContractForm extends StatelessWidget
    implements PopupForm {
  StationsMissingServiceContractForm({Key? key, required this.station_list})
      : super(key: key) {
    RoadSegmentService()
        .getAllRoadSegmentManagerSegmentsGet(onlyActive: true)
        .then((value) {
      segments.addAll(value ?? []);
      for (var element in segments) {
        loadStationOfSegment(element.id);
      }
      segments.refresh();
    });
  }

  List<StationIdSchema> station_list;

  loadStationOfSegment(String id) async {
    if (!stations.containsKey(id)) {
      await StationService()
          .getRoadSegmentStationsStationStationsOfRoadSegmentGet(id,
              onlyActive: true)
          .then((value) {
        stations[id] = (value ?? []);
        segments.refresh();
      });
    }
  }

  RxList<RoadSegmentSchema> segments = <RoadSegmentSchema>[].obs;
  RxMap<String, List<StationSchema>> stations =
      <String, List<StationSchema>>{}.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 600,
            height: Get.height - 200,
            child: Obx(
              () => ListView.builder(
                itemCount: segments.length,
                itemBuilder: (context, index) {
                  var segment = segments[index];
                  return ExpansionTile(
                    title: Text('Usek: ' + segment.name),
                    children: [
                      (stations[segment.id]?.length ?? 0) == 0
                          ? const ListTile(
                              title: Text("ziadne stanice"),
                            )
                          : ListView(
                              shrinkWrap: true,
                              children: getStationsWithoutContract(segment.id),
                            ),
                    ],
                  );
                },
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  ServiceContractService()
                      .getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGetWithHttpInfo()
                      .then((value) async => await FileSaver.instance.saveFile(
                            name: "stanice_bez_servisnej_zmluvy.xlsx",
                            bytes: value.bodyBytes,
                          ));
                },
                child: Text("Export")),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Zatvorit"),
            ),
          ],
        ),
      ],
    );
  }

  @override
  String getTitle() {
    return "Stanice bez servisnej zmluvy";
  }

  @override
  Widget getContent() {
    return this;
  }

  List<ListTile> getStationsWithoutContract(String segmentId) {
    var stationList = stations[segmentId] ?? [];
    var list = stationList
        .where(
            (element) => station_list.contains(StationIdSchema(id: element.id)))
        .map(
          (e) => ListTile(
            title: Text(e.name),
          ),
        )
        .toList();
    if (list.isEmpty) {
      return [
        const ListTile(
          title: Text("Vsetky stanice majú servisnú zmluvu"),
        )
      ];
    }

    return list;
  }
}
