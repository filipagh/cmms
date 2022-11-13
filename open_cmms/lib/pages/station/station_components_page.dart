import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/station/components_state.dart';

class StationComponentsPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Components';
  final StationSchema station;

  const StationComponentsPage({Key? key, required this.station})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssignedComponentsState components;
    try {
      components = Get.find();
    } catch (e) {
      print("put");
      components = Get.put(AssignedComponentsState(station.id));
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  // showFormDialog(StationComponentsForm.editComponentsInStation(editItem: station));
                },
                child: Text('edit components')),
          ],
        ),
        Divider(),
        GetBuilder<AssignedComponentsState>(
            builder: (_) => buildComponentList(_.components)),
      ],
    );
  }

  Widget buildComponentList(List<AssignedComponentSchema> components) {
    AssetTypesState stateAssetTypes = Get.find();
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
                                    .getAssetById(components[index].assetId)!
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
  }

  Widget? buildContextOfComponent(AssignedComponentSchema component) {
    switch (component.status) {
      case AssignedComponentState.awaiting:
        //todo add task link
        return Text("will be instaled in TASK");
      case AssignedComponentState.installed:
        return Text('installed on: DATE');
      // return Text('installed on: ' + component.installed.toString());
      case AssignedComponentState.willBeRemoved:
        return Column(
          children: [
            //todo task
            Text('will be removed in TASK'),
            Text('installed on: DATE'),
            // Text('installed on: ' + component.installed.toString()),
          ],
        );
      case AssignedComponentState.removed:
        return null;
    }
  }

  Color? getColor(AssignedComponentSchema component) {
    switch (component.status) {
      case AssignedComponentState.awaiting:
        return Colors.green[200];
      case AssignedComponentState.installed:
        return Colors.white;
      case AssignedComponentState.willBeRemoved:
        return Colors.red[200];
      case AssignedComponentState.removed:
        return null;
    }
  }
}
