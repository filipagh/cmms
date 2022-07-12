import 'package:flutter/material.dart';
import 'package:open_cmms/pages/station/station_tab_menu.dart';

class StationBasePage extends StatelessWidget {
  const StationBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: [
        SizedBox(
          width: 200,
          child: StationTabMenu(),
        ),
        VerticalDivider(),
        Expanded(
          child: Column(
            children: [Text("tab context"), Expanded(child: Placeholder())],
          ),
        ),
      ],
    ));
  }
}
