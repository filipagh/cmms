import 'package:flutter/material.dart';
import 'package:open_cmms/models/asset_model.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class Asset extends StatefulWidget {
  final String assetId;

  const Asset({
    Key? key,
    required this.assetId,
  }) : super(key: key);

  @override
  State<Asset> createState() => _AssetState();
}

class _AssetState extends State<Asset> {
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
    return Column(
      children: [
        Text(
          "Asset " + roadSegmentModel!.id,
          textScaleFactor: 5,
        ),
        Divider(),
        StationBasePage(),
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
