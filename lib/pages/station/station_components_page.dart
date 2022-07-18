import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/states/assigned_component_state.dart';

import '../../models/station.dart';

class StationComponentsPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Components';
  final Station station;

  const StationComponentsPage({Key? key, required this.station})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetX<AssignedComponentState>(builder: (_) {
          var list = _.components[station.id]?.values.toList();
          return list == null || list.isEmpty
              ? const Expanded(
                  child: Center(
                      child: Text(
                  "No Components",
                  textScaleFactor: 3,
                )))
              : Expanded(
                  child: ListView.builder(
                      addRepaintBoundaries: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            child: ListTile(
                                hoverColor: Colors.blue.shade200,
                                title: Row(
                                  children: [
                                    Text(list[index].assignedComponentId),
                                  ],

                                  // subtitle:
                                  // Center(child: Text('station Id: ${list[index].id}')),
                                )));
                      }),
                );
        })
      ],
    );
  }
}
