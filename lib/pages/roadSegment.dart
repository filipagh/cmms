import 'package:flutter/material.dart';
import 'package:open_cmms/models/road_segment_model.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class RoadSegment extends StatefulWidget {
  final String segmentId;
  const RoadSegment({
    Key? key,
    required this.segmentId,
  }) : super(key: key);

  @override
  State<RoadSegment> createState() => _RoadSegmentState();
}

class _RoadSegmentState extends State<RoadSegment> {
  RoadSegmentModel? roadSegmentModel;
  bool isModelLoaded = false;
  @override

  void initState() {
     roadSegmentModel = getDummyRoadSegmentsById(widget.segmentId);
    super.initState();
  }

  Widget buildContent() {
    if (roadSegmentModel != null) {
      return buildRoadSegment();
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
            child: buildContent(),
          )
        ],
      ),
    );
  }

  Column buildRoadSegment() {
    return Column(
            children: [
              Text(
                "Road Segment "+ roadSegmentModel!.id,
                textScaleFactor: 5,
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
                ], rows: []),
              )
            ],
          );
  }

  Widget buildMissingRoadSegment() {
    return Text("missing data for Road Segment ID: "+ widget.segmentId);
  }
}
