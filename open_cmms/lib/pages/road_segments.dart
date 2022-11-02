import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/dialog_form.dart';
import '../widgets/forms/road_segments/road_segment_form.dart';
import '../widgets/main_menu_widget.dart';

class RoadSegments extends StatelessWidget {
  RoadSegments({
    Key? key,
  }) : super(key: key);

  final RxList<RoadSegmentSchema> roadSegments = <RoadSegmentSchema>[].obs;

  reloadRoadSegments() {
    RoadSegmentService().getAllRoadSegmentManagerSegmentsGet().then((value) {
      roadSegments.clear();
      roadSegments.addAll(value ?? []);
      roadSegments.refresh();
    });
  }

  List<DataRow> getRows(List<RoadSegmentSchema> roadSegments) {
    List<DataRow> list = [];

    for (var i in roadSegments) {
      list.add(DataRow(
        onSelectChanged: (dd) {
          Get.toNamed("/RoadSegments/" + i.id);
        },
        cells: [
          DataCell(Text(i.name)),
          const DataCell(Text("")),
          DataCell(Text(i.ssud)),
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var widget = Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Road Segments",
                      textScaleFactor: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          reloadRoadSegments();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    const Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showFormDialog(RoadSegmentForm.createNew());
                      },
                      child: const Text("create road segment"),
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      return DataTable(
                          showCheckboxColumn: false,
                          dataRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.blue.shade200;
                            }
                            return Colors.transparent; // Use the default value.
                          }),
                          columns: const [
                            DataColumn(label: Text("Road segment name")),
                            DataColumn(label: Text("text")),
                            DataColumn(label: Text("ssud")),
                          ],
                          rows: getRows(roadSegments));
                    }))

                // child: GetX<RoadSegmentState>(builder: (_) {
                //   return DataTable(
                //       showCheckboxColumn: false,
                //       dataRowColor:
                //           MaterialStateProperty.resolveWith<Color?>(
                //               (Set<MaterialState> states) {
                //         if (states.contains(MaterialState.hovered)) {
                //           return Colors.blue.shade200;
                //         }
                //         return Colors.transparent; // Use the default value.
                //       }),
                //       columns: [
                //         DataColumn(label: Text("Road segment name")),
                //         DataColumn(label: Text("text")),
                //         DataColumn(label: Text("ssud")),
                //       ],
                //       rows: getRows(_));
                // }))
              ],
            ),
          )
        ],
      ),
    );
    reloadRoadSegments();
    return widget;
  }
}
