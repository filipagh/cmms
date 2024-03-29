import 'package:BackendAPI/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/assigned_asset_component.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/tasks/task_page_factory.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/states/auth_state.dart';
import 'package:open_cmms/states/station/components_state.dart';
import 'package:open_cmms/widgets/forms/components/add_component_to_station_form.dart';
import 'package:open_cmms/widgets/forms/components/component_picker.dart';
import 'package:open_cmms/widgets/forms/components/remove_component_from_station_form.dart';
import 'package:open_cmms/widgets/forms/components/replace_station_components_form.dart';
import 'package:open_cmms/widgets/forms/components/set_component_warranty_form.dart';

import '../../service/backend_api/investment_contract_service.dart';
import '../../widgets/dialog_form.dart';
import '../../widgets/forms/components/edit_station_components_form.dart';

class StationComponentsPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Components';
  final StationSchema station;

  Rxn<List<InvestmentContractSchema>> investmentContracts =
      Rxn<List<InvestmentContractSchema>>();

  StationComponentsPage({Key? key, required this.station}) : super(key: key) {
    InvestmentContractService()
        .getContractsInvestmentContractContractsGet(onlyActive: false)
        .then((value) => investmentContracts.value = value);
    authState = Get.find();
    try {
      components = Get.find(tag: station.id);
    } catch (e) {
      components =
          Get.put(AssignedComponentsState(station.id), tag: station.id);
      components.load();
    }
  }

  late AssignedComponentsState components;
  late AuthState authState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (station.isActive)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  components?.load();
                },
                icon: Icon(Icons.refresh),
                label: Text("Načítať komponenty"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (authState.isAdmin.isTrue) ...[
                    ElevatedButton(
                        onPressed: () async {
                          await showFormDialog(ComponentPickerForm(
                            hideArchivedAssets: false,
                          )).then((value) async {
                            if (value != null) {
                              await showFormDialog(AddComponentToStationForm(
                                station: station,
                                asset: value,
                              )).then((value) {
                                if (value != null) {
                                  components.load();
                                  showOk("Komponenty boli nastavené");
                                }
                              });
                            }
                          });
                        },
                        child: Text('Pridat nainstalovany komponent'))
                  ],
                  // if (authState.isAdmin.isTrue) ...[
                  //   ElevatedButton(
                  //       onPressed: () async {
                  //         if (await showFormDialog(
                  //             SetStationComponentsForm.editComponentsInStation(
                  //                 station: station))) {
                  //           components.load();
                  //           showOk("Komponenty boli nastavené");
                  //         }
                  //       },
                  //       child: Text('Nastaviť komponenty'))
                  // ],
                  VerticalDivider(),
                  ElevatedButton(
                      onPressed: () async {
                        if (await showFormDialog(
                            ReplaceStationComponentsForm(station: station))) {
                          components.load();
                          showOk("Úloha bola vytvorená");
                        }
                      },
                      child: Text('Vymeniť komponenty')),
                  VerticalDivider(),
                  ElevatedButton(
                      onPressed: () async {
                        if (await showFormDialog(
                            EditStationComponentsForm(station: station))) {
                          components.load();
                          showOk("Úloha bola vytvorená");
                        }
                      },
                      child: Text('Editovať komponenty')),
                ],
              ),
            ],
          ),
        Divider(),
        GetBuilder<AssignedComponentsState>(
            tag: station.id, builder: (_) => buildComponentList(_.components)),
      ],
    );
  }

  Widget buildComponentList(List<AssignedComponentSchema> components) {
    AssetTypesState stateAssetTypes = Get.find();
    components.removeWhere(
        (element) => element.status == AssignedComponentState.removed);
    List<AssignedAssetComponent> componentsWithAssets = [];
    components.forEach((element) {
      componentsWithAssets.add(AssignedAssetComponent(element));
    });
    componentsWithAssets.sort((a, b) => a.asset.name.compareTo(b.asset.name));
    return componentsWithAssets.isEmpty
        ? Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (station.isActive == true) ...[
                const Text(
                  "Ziadne komponenty",
                  textScaleFactor: 3,
                ),
                ElevatedButton(
                    onPressed: () {
                      StationService().removeStationStationRemoveStationDelete(
                          StationIdSchema(id: station.id));
                    },
                    child: Text("Vymazať stanicu")),
              ] else ...[
                const Text(
                  "Stanica je zmazaná",
                  textScaleFactor: 3,
                ),
              ],
            ],
          ))
        : Expanded(
            child: ListView.builder(
                addRepaintBoundaries: true,
                padding: const EdgeInsets.all(8),
                itemCount: components.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = componentsWithAssets[index];
                  var content = buildComponentRow(item);
                  if (content == null) {
                    return null;
                  }
                  return Card(
                      child: ListTile(
                          tileColor: getColor(item.assignedComponent),
                          hoverColor: Colors.blue.shade200,
                          title: content));
                }),
          );
  }

  Row? buildComponentRow(AssignedAssetComponent item) {
    switch (item.assignedComponent.status) {
      case AssignedComponentState.awaiting:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.asset.name),
                ],
              ),
            ),
            Container(
              width: 100,
            ),
            RichText(
                text: TextSpan(
              text: "Bude nainštalované v ",
              children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => TaskPageFactory()
                          .openTaskFromId(item.assignedComponent.taskId!),
                    text: "Úlohe",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline))
              ],
            )),
            Spacer(),
          ],
        );

      case AssignedComponentState.installed:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              child: Text(item.asset.name),
            ),
            Container(
              width: 100,
              child: Column(
                children: [
                  Text("seriove cislo:"),
                  Text((item.assignedComponent.serialNumber ?? "nezname")),
                ],
              ),
            ),
            if (authState.isAdmin.isTrue) ...[
              IconButton(
                  color: Colors.red,
                  onPressed: () async {
                    await showFormDialog(RemoveComponentToStationForm(
                            station: station,
                            component: item.assignedComponent))
                        .then((value) {
                      if (value) {
                        components.load();
                        showOk("Komponent bol odinštalovaný");
                      }
                    });
                  },
                  icon: Icon(Icons.delete_forever)),
            ],
            Spacer(),
            Text(
                'inštalované dňa: ${item.assignedComponent.installedAt.toString().substring(0, 10)}'),
            Spacer(),
            buildWarrantycontent(item)
          ],
        );

      case AssignedComponentState.removed:
        return null;

      case AssignedComponentState.willBeRemoved:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              child: Text(item.asset.name),
            ),
            Container(
              width: 100,
              child: Column(
                children: [
                  Text("seriove cislo:"),
                  Text((item.assignedComponent.serialNumber ?? "nezname")),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                RichText(
                    text: TextSpan(
                  text: "Bude odstránené v ",
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => TaskPageFactory()
                              .openTaskFromId(item.assignedComponent.taskId!),
                        text: "Úlohe",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline))
                  ],
                )),
                Text(
                    'inštalované dňa: ${item.assignedComponent.installedAt.toString().substring(0, 10)}'),
              ],
            ),
            Spacer(),
            buildWarrantycontent(item)
          ],
        );
    }
    return null;
  }

  Column buildWarrantycontent(AssignedAssetComponent item) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text("Záruka na komponent"),
                Text((item.assignedComponent.componentWarrantyUntil
                        ?.toIso8601String()
                        .substring(0, 10) ??
                    '-')),
                Obx(() {
                  return Text("zmluva: " +
                      (investmentContracts.value
                              ?.firstWhereOrNull((element) =>
                                  element.id ==
                                  item.assignedComponent.componentWarrantyId)
                              ?.identifier ??
                          '-'));
                })
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Text("Predplateny servis "),
                Text((item.assignedComponent.prepaidServiceUntil
                        ?.toIso8601String()
                        .substring(0, 10) ??
                    '-')),
              ],
            ),
            VerticalDivider(),
            Column(
              children: [
                Text("Technicky servis "),
                Text((item.assignedComponent.serviceContractUntil
                        ?.toIso8601String()
                        .substring(0, 10) ??
                    '-')),
              ],
            ),
            if (authState.isAdmin.isTrue) ...[
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await showFormDialog(SetComponentWarrantyForm(
                              component: item.assignedComponent))
                          .then((value) {
                        if (value) {
                          components.load();
                          showOk("zaruky boly zmenene");
                        }
                      });
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              )
            ],
          ],
        ),
      ],
    );
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
