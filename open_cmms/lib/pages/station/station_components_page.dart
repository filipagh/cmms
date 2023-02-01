import 'package:BackendAPI/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/tasks/task_page_factory.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/station/components_state.dart';
import 'package:open_cmms/widgets/forms/components/set_components_instation_form.dart';

import '../../widgets/dialog_form.dart';
import '../../widgets/forms/components/edit_station_components_form.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                components.reload();
              },
              icon: Icon(Icons.refresh),
              label: Text("Nacitat komponenty"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      showFormDialog(
                          SetStationComponentsForm.editComponentsInStation(
                              station: station));
                    },
                    child: Text('Nastavit komponenty')),
                VerticalDivider(),
                ElevatedButton(
                    onPressed: () {
                      showFormDialog(
                          EditStationComponentsForm(station: station));
                    },
                    child: Text('Editovat komponenty')),
              ],
            ),
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
    components.removeWhere(
        (element) => element.status == AssignedComponentState.removed);
    return components.isEmpty
        ? const Expanded(
            child: Center(
                child: Text(
            "Ziadne komponenty",
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
        return RichText(
            text: TextSpan(
          text: "Bude nainstalovane v ",
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => TaskPageFactory().openTaskPage(component.taskId!),
                text: "Ulohe",
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline))
          ],
        ));
      case AssignedComponentState.installed:
        return Text('instalovane dna: ${component.installedAt}');
      // return Text('installed on: ' + component.installed.toString());
      case AssignedComponentState.willBeRemoved:
        return Column(
          children: [
            RichText(
                text: TextSpan(
              text: "Bude odstranene v ",
              children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          TaskPageFactory().openTaskPage(component.taskId!),
                    text: "Ulohe",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline))
              ],
            )),
            Text('instalovane dna: ${component.installedAt}'),
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
