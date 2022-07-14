import 'package:flutter/material.dart';
import 'package:open_cmms/models/asset_type.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/station/station_tab_menu.dart';

import '../../models/asset_model.dart';



class StationComponentsPage extends StatelessWidget implements StationBaseContextPage {
  static const String ENDPOINT = '/Components';
  final AssetModel station;
  const StationComponentsPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("wip components"),
      ],
    );
  }

}
