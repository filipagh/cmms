import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/road_segment_state.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/dialog_form.dart';
import '../widgets/forms/road_segments/road_segment_form.dart';
import '../widgets/main_menu_widget.dart';

class RoadSegments extends StatefulWidget {
  const RoadSegments({
    Key? key,
  }) : super(key: key);

  @override
  State<RoadSegments> createState() => _RoadSegmentsState();
}

class _RoadSegmentsState extends State<RoadSegments> {
  RoadSegmentState _roadSegmentState = Get.find();

  List<DataRow> getRows(RoadSegmentState roadSegmentState) {
    List<DataRow> list = [];
    for (var i in roadSegmentState.segments.values) {
      list.add(DataRow(
        onSelectChanged: (dd) {
          Get.toNamed("/RoadSegments/" + i.id);
        },
        cells: [
          DataCell(Text(i.name)),
          DataCell(Text(i.text)),
          DataCell(Text(i.ssud)),
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Road Segments",
                  textScaleFactor: 5,
                ),
                Divider(),
                Row(
                  children: [
                    Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showFormDialog(RoadSegmentForm.createNew());
                      },
                      child: Text("create road segment"),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                    width: double.infinity,
                    child: GetX<RoadSegmentState>(builder: (_) {
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
                          columns: [
                            DataColumn(label: Text("Road segment name")),
                            DataColumn(label: Text("text")),
                            DataColumn(label: Text("ssud")),
                          ],
                          rows: getRows(_));
                    }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
