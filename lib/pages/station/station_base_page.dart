import 'package:flutter/material.dart';
import 'package:open_cmms/models/asset_model.dart';
import 'package:open_cmms/pages/station/station_info_page.dart';
import 'package:open_cmms/pages/station/station_tab_menu.dart';

import '../../widgets/customAppBar.dart';
import '../../widgets/mainMenuWidget.dart';

class StationBasePage extends StatefulWidget {
  final String assetId;
  final StationBaseContextPageEnum contextPageEnum;
  const StationBasePage({Key? key, required this.contextPageEnum, required this.assetId}) : super(key: key);

  @override
  State<StationBasePage> createState() => _StationBasePageState();
}

class _StationBasePageState extends State<StationBasePage> {
  AssetModel? roadSegmentModel;
  bool isModelLoaded = false;

  @override
  void initState() {
    roadSegmentModel = getDummyAssetById(widget.assetId);
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
    Widget? contextWidget;
    if (widget.contextPageEnum == StationBaseContextPageEnum.info) {
      contextWidget = StationInfoPage(station: roadSegmentModel!);
    }
    return Column(
      children: [
        Text(
          "Asset " + roadSegmentModel!.id,
          textScaleFactor: 5,
        ),
        Divider(),
        Row(
        children: [
        SizedBox(
    width: 200,
    child: StationTabMenu(),
    ),
    VerticalDivider(),
    Expanded(
    child: contextWidget!,
    ),
    ],
    )
        // StationBasePage(contextPage:  widget.contextPage(roadSegmentModel),contextPageEnum: widget.contextPageEnum,),
      ],
    );
  }

  Widget buildMissingRoadSegment() {
    return Center(
        child: Text(
          "Missing data for Asset ID: " + widget.assetId,
          textScaleFactor: 2,
        ));
  }


}

abstract class StationBaseContextPage extends Widget {
  final AssetModel station;

  const StationBaseContextPage({Key? key, required this.station}) : super(key: key);
}

enum StationBaseContextPageEnum {
  info,
}
