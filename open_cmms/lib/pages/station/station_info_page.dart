import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';

import '../../models/station.dart';



class StationInfoPage extends StatelessWidget implements StationBaseContextPage {
  static const String ENDPOINT = '/Info';
  final StationSchema station;
  const StationInfoPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Meno: " + station.name),
        Text("ID: " + station.id),
      ],
    );
  }

}
