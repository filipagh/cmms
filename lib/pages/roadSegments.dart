import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:open_cmms/pages/roadSegment.dart';
import 'package:open_cmms/widgets/create_form.dart';
import '../models/road_segment_model.dart';
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
        onSelectChanged: (dd) {Get.toNamed("/RoadSegments/"+i.id);},
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
                      onPressed: () {showdialog();},
                      child: Text("create road segment"),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    showCheckboxColumn: false,
                    dataRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {

                      if (states.contains(MaterialState.hovered)) {
                        return Colors.blue.shade200;
                      }
                      return Colors.transparent;  // Use the default value.
                    }),
                      columns: [
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
