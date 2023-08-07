import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class ServiceContractForm extends StatefulWidget implements hasFormTitle {
  ServiceContractForm(
      {Key? key,
      ServiceContractSchema? contract,
      this.isNew = false,
      this.stationsWithoutContract = const []})
      : super(key: key) {
    RoadSegmentService().getAllRoadSegmentManagerSegmentsGet().then((value) {
      segments.addAll(value ?? []);
      for (var element in segments) {
        loadStationOfSegment(element.id);
      }
      segments.refresh();
    });
    if (contract != null) {
      this.contract = contract;
    }
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
      });
    }
  }

  RxList<RoadSegmentSchema> segments = <RoadSegmentSchema>[].obs;
  RxMap<String, List<StationSchema>> stations =
      <String, List<StationSchema>>{}.obs;
  RxList<String> selectedStations = <String>[].obs;
  List<StationIdSchema> stationsWithoutContract;

  @override
  State<ServiceContractForm> createState() => _ServiceContractFormState();

  @override
  String getTitle() {
    return "Nova servisna zmluva";
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
      widget.selectedStations.value = widget.contract!.stationIdList.toList();
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
            decoration: const InputDecoration(label: Text("nazov zmluvy")),
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
                                    () => CheckboxListTile(
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
                                      value: widget.selectedStations
                                          .contains(station.id),
                                      onChanged: widget.isNew
                                          ? (bool? value) {
                                              if (value!) {
                                                widget.selectedStations
                                                    .add(station.id);
                                                widget.segments.refresh();
                                              } else {
                                                widget.selectedStations
                                                    .remove(station.id);
                                                widget.segments.refresh();
                                              }
                                            }
                                          : null,
                                    ),
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
                          if (widget.selectedStations.isEmpty) {
                            showError("zvolte aspon jednu stanicu");
                            return;
                          }
                          ServiceContractService()
                              .createContractServiceContractCreateContractPost(
                                  ServiceContractNewSchema(
                                      name: name.value.text,
                                      validFrom: dateFromDT!,
                                      validUntil: dateDueDT!,
                                      stationIdList: widget.selectedStations))
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
    var missingStations = stationList
        .where((element) => !widget.selectedStations.contains(element));
    if (missingStations.length == stationList.length) {
      return false;
    } else if (missingStations.isEmpty) {
      return true;
    }
    return null;
  }

  changeAllInSegment(String id, bool addAll) {
    var stationList = widget.stations[id]!.map((e) => e.id).toList();
    if (addAll) {
      stationList.forEach((element) {
        widget.selectedStations
            .addIf(!widget.selectedStations.contains(element), element);
      });
    } else {
      stationList.forEach((element) {
        widget.selectedStations.remove(element);
      });
    }
    widget.segments.refresh();
  }
}
