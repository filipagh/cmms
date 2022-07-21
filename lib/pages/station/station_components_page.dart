import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/assigned_component.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/states/asset_types_state.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('add components')),
            ElevatedButton(onPressed: () {}, child: Text('remove components')),
            ElevatedButton(
                onPressed: () {},
                child: Text('add already installed component')),
          ],
        ),
        Divider(),
        buildComponentList(),
      ],
    );
  }

  Widget buildComponentList() {
    StateAssetTypes stateAssetTypes = Get.find();
    return GetX<AssignedComponentState>(builder: (_) {
      var components = _.getInstalledComponentsByStationId(station.id);
      return components.isEmpty
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
                  itemCount: components.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                            tileColor: getColor(components[index]),
                            hoverColor: Colors.blue.shade200,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(stateAssetTypes
                                      .getAssetTypeById(
                                          components[index].productId)!
                                      .name),
                                ),
                                Spacer(),
                                buildContextOfComponent(components[index])!,
                                Spacer(),
                                Text('ACTIONS')
                                // Text(components[index].assignedComponentId),
                              ],

                              // subtitle:
                              // Center(child: Text('station Id: ${list[index].id}')),
                            )));
                  }),
            );
    });
  }

  Widget? buildContextOfComponent(AssignedComponent component) {
    switch (component.actualState) {
      case AssignedComponentStateEnum.awaiting:
        //todo add task link
        return Text("will be instaled in TASK");
      case AssignedComponentStateEnum.installed:
        return Text('installed on: ' + component.installed.toString());
      case AssignedComponentStateEnum.willBeRemoved:
        return Column(
          children: [
            //todo task
            Text('will be removed in TASK'),
            Text('installed on: ' + component.installed.toString()),
          ],
        );
      case AssignedComponentStateEnum.removed:
        return null;
    }
  }

  Color? getColor(AssignedComponent component) {
    switch (component.actualState) {
      case AssignedComponentStateEnum.awaiting:
        return Colors.green[200];
      case AssignedComponentStateEnum.installed:
        return Colors.white;
      case AssignedComponentStateEnum.willBeRemoved:
        return Colors.red[200];
      case AssignedComponentStateEnum.removed:
        return null;
    }
  }
}
