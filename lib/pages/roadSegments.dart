import 'package:flutter/material.dart';
import 'package:open_cmms/models/road_segment_model.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class RoadSegments extends StatefulWidget {
  const RoadSegments({
    Key? key,
  }) : super(key: key);

  @override
  State<RoadSegments> createState() => _RoadSegmentsState();
}

class _RoadSegmentsState extends State<RoadSegments> {
  List<DataRow> getRows() {
    List<DataRow> list = [];
    for (var i in dummyRoadSegments) {
      list.add(DataRow(
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
                SizedBox(
                  width: double.infinity,
                  child: DataTable(columns: [
                    DataColumn(label: Text("Road segment name")),
                    DataColumn(label: Text("text")),
                    DataColumn(label: Text("ssud")),
                  ], rows: getRows()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
