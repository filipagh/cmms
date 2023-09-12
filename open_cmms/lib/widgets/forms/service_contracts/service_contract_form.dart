import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../util/date_utils.dart';

class ServiceContractForm extends StatefulWidget implements hasFormTitle {
  ServiceContractForm(
      {Key? key,
      ServiceContractSchema? contract,
      this.isNew = false,
      this.stationsWithoutContract = const []})
      : super(key: key) {
    RoadSegmentService().getAllRoadSegmentManagerSegmentsGet().then((value) {
      if (contract != null) {
        this.contract = contract;
      }
      segments.addAll(value ?? []);
      for (var element in segments) {
        loadStationOfSegment(element.id);
      }
      segments.refresh();
    });
  }

  ServiceContractSchema? contract;

  bool isNew;

  loadStationOfSegment(String id) async {
    if (!stations.containsKey(id)) {
      await StationService()
          .getRoadSegmentStationsStationStationsOfRoadSegmentGet(id,
              onlyActive: false)
          .then((value) {
        stations[id] = (value ?? []);
        segments.refresh();
        for (var station in stations[id]!) {
          AssignedComponentService()
              .getAllAssignedComponentsComponentsGet(stationId: station.id)
              .then((value) {
            if (isNew) {
              value = value
                  ?.where((element) =>
                      element.status != AssignedComponentState.removed)
                  .toList();
            }
            stationsComponents[station.id] = value ?? [];
            if (contract != null) {
              var componentsFilteredList = contract!.stationsList
                  .firstWhere((contractStation) =>
                      contractStation.stationId == station.id)
                  .componentIdList;
              componentsFilteredList = componentsFilteredList
                  .where((componentId) => stationsComponents[station.id]!
                      .any((element) => element.id == componentId))
                  .toList();
              selectedStationsWithComponents[station.id] =
                  componentsFilteredList;
            }
            segments.refresh();
          });
        }
      });
    }
  }

  RxList<RoadSegmentSchema> segments = <RoadSegmentSchema>[].obs;
  RxMap<String, List<StationSchema>> stations =
      <String, List<StationSchema>>{}.obs;
  RxMap<String, List<AssignedComponentSchema>> stationsComponents =
      <String, List<AssignedComponentSchema>>{}.obs;
  RxMap<String, List<String>> selectedStationsWithComponents =
      <String, List<String>>{}.obs;
  List<StationIdSchema> stationsWithoutContract;
  AssetTypesState _assetTypes = Get.find();

  @override
  State<ServiceContractForm> createState() => _ServiceContractFormState();

  @override
  String getTitle() {
    return "Nova servisná zmluva";
  }

  @override
  Widget getInstance() {
    return this;
  }
}

class _ServiceContractFormState extends State<ServiceContractForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateDue = TextEditingController();
  final TextEditingController dateFrom = TextEditingController();
  final TextEditingController name = TextEditingController();
  DateTime? dateDueDT;
  DateTime? dateFromDT;

  @override
  Widget build(BuildContext context) {
    if (widget.contract != null) {
      dateFrom.text = widget.contract!.validFrom.toString().substring(0, 10);
      dateDue.text = widget.contract!.validUntil.toString().substring(0, 10);
      dateFromDT = widget.contract!.validFrom;
      dateDueDT = widget.contract!.validUntil;
      name.text = widget.contract!.name;
      widget.contract = null;
      widget.segments.refresh();
    }
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            readOnly: widget.isNew ? false : true,
            controller: name,
            decoration: const InputDecoration(label: Text("názov zmluvy")),
            validator: (v) {
              return (v == null || v.isEmpty) ? "zvolte nazov" : null;
            },
          ),
          TextFormField(
              readOnly: widget.isNew ? false : true,
              controller: dateFrom,
              validator: (v) {
                return (v == null || v.isEmpty) ? "zvolte datum" : null;
              },
              decoration:
                  const InputDecoration(labelText: "Datum platnosti od"),
              onTap: () {
                widget.isNew
                    ? showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            initialDate: DateTime.now())
                        .then((value) {
                        dateFrom.text = value.toString().substring(0, 10) ?? '';
                        dateFromDT = value;
                      })
                    : null;
              }),
          TextFormField(
              readOnly: widget.isNew ? false : true,
              controller: dateDue,
              validator: (v) {
                return (v == null || v.isEmpty) ? "zvolte datum" : null;
              },
              decoration:
                  const InputDecoration(labelText: "Datum platnosti do"),
              onTap: () {
                widget.isNew
                    ? showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            initialDate: DateTime.now())
                        .then((value) {
                        dateDue.text = value.toString().substring(0, 10) ?? '';
                        dateDueDT = value;
                      })
                    : null;
              }),
          SizedBox(
              width: 600,
              height: Get.height - 300,
              child: Obx(
                () => ListView.builder(
                  itemCount: widget.segments.length,
                  itemBuilder: (context, index) {
                    var segment = widget.segments[index];
                    return ExpansionTile(
                      title: Text('Usek: ' + segment.name),
                      children: [
                        (widget.stations[segment.id]?.length ?? 0) == 0
                            ? const ListTile(
                                title: Text("ziadne stanice"),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.stations[segment.id]!.length,
                                itemBuilder: (context, index) {
                                  var station =
                                      widget.stations[segment.id]![index];
                                  return Obx(
                                    () => ExpansionTile(
                                        children: [
                                          if ((widget
                                                      .stationsComponents[
                                                          station.id]
                                                      ?.length ??
                                                  0) ==
                                              0)
                                            const ListTile(
                                              title: Text("ziadne komponenty"),
                                            )
                                          else
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: widget
                                                    .stationsComponents[
                                                        station.id]!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  var component =
                                                      widget.stationsComponents[
                                                          station.id]![index];
                                                  return CheckboxListTile(
                                                    title: Text(widget
                                                        ._assetTypes
                                                        .getAssetById(
                                                            component.assetId)!
                                                        .name),
                                                    subtitle: Text(
                                                        "instalovane dna: " +
                                                            component
                                                                .installedAt
                                                                .toString()
                                                                .substring(
                                                                    0, 10) +
                                                            " seriove cislo: " +
                                                            (component
                                                                    .serialNumber ??
                                                                "")),
                                                    value: widget
                                                            .selectedStationsWithComponents[
                                                                station.id]
                                                            ?.contains(
                                                                component.id) ??
                                                        false,
                                                    onChanged: widget.isNew
                                                        ? (bool? value) {
                                                            selectComponent(
                                                                station.id,
                                                                component.id,
                                                                value ?? false);
                                                          }
                                                        : null,
                                                  );
                                                })
                                        ],
                                        title: Row(
                                          children: [
                                            Text(station.name),
                                            if (!station.isActive) ...[
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Tooltip(
                                                message: "stanica je zmazaná",
                                                child: Icon(
                                                  Icons.remove_circle_outline,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ]
                                          ],
                                        ),
                                        subtitle: widget.stationsWithoutContract
                                                .contains(StationIdSchema(
                                                    id: station.id))
                                            ? const Text(
                                                "stanica nemá servisnú zmluvu")
                                            : null,
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.arrow_drop_down),
                                            (widget
                                                        .stationsComponents[
                                                            station.id]
                                                        ?.isEmpty ??
                                                    false)
                                                ? const Icon(Icons.close)
                                                : Checkbox(
                                                    tristate: true,
                                                    value:
                                                        getStationCheckBoxValue(
                                                            station.id),
                                                    onChanged: widget.isNew
                                                        ? (bool? value) {
                                                            changeAllInStation(
                                                                station.id,
                                                                value ?? false);
                                                          }
                                                        : null,
                                                  ),
                                          ],
                                        )),
                                  );
                                })
                      ],
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_drop_down),
                          (widget.stations[segment.id]?.isEmpty ?? false)
                              ? const Icon(Icons.close)
                              : Checkbox(
                                  tristate: true,
                                  value: getSectionCheckBoxValue(segment.id),
                                  onChanged: widget.isNew
                                      ? (bool? value) {
                                          changeAllInSegment(
                                              segment.id, value ?? false);
                                        }
                                      : null,
                                ),
                        ],
                      ),
                    );
                  },
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Zrusit")),
              widget.isNew
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.selectedStationsWithComponents.isEmpty) {
                            showError("zvolte aspon jednu stanicu");
                            return;
                          }
                          List<ServiceContractStationComponentsSchema> list =
                              [];
                          widget.selectedStationsWithComponents.forEach(
                              (element, values) => list.add(
                                  ServiceContractStationComponentsSchema(
                                      stationId: element,
                                      componentIdList: values)));
                          ServiceContractService()
                              .createContractServiceContractCreateContractPost(
                                  ServiceContractNewSchema(
                                      name: name.value.text,
                                      validFrom:
                                          convertDatetimeToUtc(dateFromDT!),
                                      validUntil:
                                          convertDatetimeToUtc(dateDueDT!),
                                      stationsList: list))
                              .then((value) {
                            Get.back();
                            showOk("Servisna zmluva bola pridana");
                          });
                        }
                      },
                      child: const Text("Vytvorit zmluvu"))
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  bool? getSectionCheckBoxValue(String id) {
    if (widget.stations[id] == null || widget.stations[id] == []) return false;

    var stationList = widget.stations[id]!.map((e) => e.id).toList();
    var missingStations = stationList.where(
        (element) => !(widget.selectedStationsWithComponents[element] != null));
    if (missingStations.length == stationList.length) {
      return false;
    } else if (missingStations.isEmpty) {
      return true;
    }
    return null;
  }

  bool? getStationCheckBoxValue(String id) {
    if (widget.selectedStationsWithComponents[id] == null ||
        widget.selectedStationsWithComponents[id]!.isEmpty) {
      return false;
    }
    if (widget.selectedStationsWithComponents[id]!.length ==
        widget.stationsComponents[id]!.length) {
      return true;
    }

    return null;
  }

  changeAllInSegment(String id, bool addAll) {
    var stationList = widget.stations[id]!.map((e) => e.id).toList();
    if (addAll) {
      stationList.forEach((element) {
        widget.selectedStationsWithComponents.addIf(
            !(widget.selectedStationsWithComponents[element] != null),
            element,
            widget.stationsComponents[element]!.map((e) => e.id).toList());
      });
    } else {
      stationList.forEach((element) {
        widget.selectedStationsWithComponents.remove(element);
      });
    }
    widget.segments.refresh();
  }

  changeAllInStation(String id, bool addAll) {
    if (addAll) {
      widget.selectedStationsWithComponents[id] =
          widget.stationsComponents[id]!.map((e) => e.id).toList();
    } else {
      widget.selectedStationsWithComponents.remove(id);
    }

    widget.segments.refresh();
  }

  selectComponent(String stationId, String componentId, bool add) {
    if (add) {
      if (widget.selectedStationsWithComponents[stationId] == null) {
        widget.selectedStationsWithComponents[stationId] = [componentId];
      } else {
        widget.selectedStationsWithComponents[stationId]!.add(componentId);
      }
    } else {
      widget.selectedStationsWithComponents[stationId]!.remove(componentId);
      if (widget.selectedStationsWithComponents[stationId]!.isEmpty) {
        widget.selectedStationsWithComponents.remove(stationId);
      }
    }
    widget.segments.refresh();
  }
}
