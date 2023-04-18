import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class StationsMissingServiceContractForm extends StatelessWidget
    implements hasFormTitle {
  StationsMissingServiceContractForm({Key? key, required this.station_list})
      : super(key: key) {
    RoadSegmentService().getAllRoadSegmentManagerSegmentsGet().then((value) {
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
          .getAllStationStationsGet(roadSegmentId: id)
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
      ],
    );
  }

  @override
  String getTitle() {
    return "Stanice bez servisnej zmluvy";
  }

  @override
  Widget getInstance() {
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
