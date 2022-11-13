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
                                    .getAssetTypeById(
                                        components[index].assetId)!
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
    return Text("komponent");
    // switch (component.actualState) {
    //   case AssignedComponentStateEnum.awaiting:
    //     //todo add task link
    //     return Text("will be instaled in TASK");
    //   case AssignedComponentStateEnum.installed:
    //     return Text('installed on: ' + component.installed.toString());
    //   case AssignedComponentStateEnum.willBeRemoved:
    //     return Column(
    //       children: [
    //         //todo task
    //         Text('will be removed in TASK'),
    //         Text('installed on: ' + component.installed.toString()),
    //       ],
    //     );
    //   case AssignedComponentStateEnum.removed:
    //     return null;
    // }
  }

  Color? getColor(AssignedComponentSchema component) {
    return Colors.green;
    // switch (component.actualState) {
    //   case AssignedComponentStateEnum.awaiting:
    //     return Colors.green[200];
    //   case AssignedComponentStateEnum.installed:
    //     return Colors.white;
    //   case AssignedComponentStateEnum.willBeRemoved:
    //     return Colors.red[200];
    //   case AssignedComponentStateEnum.removed:
    //     return null;
    // }
  }
}
