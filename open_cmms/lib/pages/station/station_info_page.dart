import 'package:flutter/material.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';

import '../../models/station.dart';



class StationInfoPage extends StatelessWidget implements StationBaseContextPage {
  static const String ENDPOINT = '/Info';
  final Station station;
  const StationInfoPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("name: " + station.name),
        Text("description: " + station.text),
      ],
    );
  }

}
