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
  final RxnString _query = RxnString();

  RxBool _show_deleted = false.obs;

  load() {
    if (_query.value != null) {
      RoadSegmentService()
          .searchRoadSegmentManagerSegmentsSearchGet(_query.value!,
              onlyActive: !_show_deleted.value)
          .then((value) => roadSegments.value = (value ?? []));
    } else {
      RoadSegmentService()
          .getAllRoadSegmentManagerSegmentsGet(onlyActive: !_show_deleted.value)
          .then((value) => roadSegments.value = (value ?? []));
    }
  }

  List<DataRow> getRows(List<RoadSegmentSchema> roadSegments) {
    List<DataRow> list = [];

    for (var i in roadSegments) {
      list.add(DataRow(
        onSelectChanged: (dd) {
          Get.toNamed("/RoadSegment/" + i.id);
          // Get.to(RoadSegment(
          //   segmentId: i.id,
          // ));
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
    load();
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
                      "Cestný úsek",
                      textScaleFactor: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          load();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextField(
                        onChanged: (v) {
                          if (v.length >= 3) {
                            _query.value = v;
                            load();
                          }
                          if (v.length < 3 && _query.value != null) {
                            _query.value = null;
                            load();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Hľadať",
                        ),
                      ),
                    ),
                    Text("zobraziť zmazané"),
                    Obx(() => Checkbox(
                        value: _show_deleted.value,
                        onChanged: (v) {
                          _show_deleted.value = v!;
                          load();
                        })),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showFormDialog(RoadSegmentForm.createNew())
                            .then((value) => load());
                      },
                      child: const Text("vytvoriť cestný úsek"),
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
                            DataColumn(label: Text("Cestný úsek názov")),
                            DataColumn(label: Text("text")),
                            DataColumn(
                                label: Text("Stredisko správy a údržby")),
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
    return widget;
  }
}
