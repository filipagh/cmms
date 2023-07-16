import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/issues_service.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/snacbars.dart';

import '../service/backend_api/RoadSegmentManager.dart';

class IssueReportPage extends StatelessWidget {
  static const ENDPOINT = "/issue_report";

  IssueReportPage({Key? key}) : super(key: key);
  final Rxn<String> issueId = Rxn<String>();
  var subject = "";
  var description = "";
  var username = "";
  final Rxn<String> selectedStation = Rxn<String>();
  final Rxn<String> selectedSegment = Rxn<String>();
  var _key = GlobalKey<FormState>();

  RxList<RoadSegmentSchema> roadSegments = <RoadSegmentSchema>[].obs;
  RxList<StationPublicSchema> stations = <StationPublicSchema>[].obs;

  @override
  Widget build(BuildContext context) {
    RoadSegmentService()
        .getAllPublicRoadSegmentManagerSegmentsPublicGet()
        .then((value) {
      roadSegments.value = value ?? [];
      roadSegments.refresh();
    });

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Ohlasovanie porúch meteostaníc",
                    style: TextStyle(fontSize: 30))
              ],
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              width: 600,
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                if (issueId.value != null) {
                  return buildSuccesSendIssue();
                }
                return buildIssueForm();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Column buildSuccesSendIssue() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
            "Váš problém ${issueId.value!} bol úspešne odoslaný, ďakujeme za pomoc"),
      ],
    );
  }

  Form buildIssueForm() {
    return Form(
      key: _key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
              "Formulár na nahlásenie problému meteorologických staníc Spinet"),
          const Divider(),
          Obx(
            () {
              return DropdownButtonFormField<String>(
                value: selectedSegment.value,
                decoration: InputDecoration(labelText: 'Vyberte cestný úsek'),
                onChanged: (value) {
                  if (selectedSegment.value == value) {
                    return;
                  }
                  selectedSegment.value = value;
                  selectedStation.value = null;
                  StationService()
                      .getAllPublicStationStationsPublicGet(
                          selectedSegment.value!)
                      .then((value) => stations.value = value ?? []);
                },
                items: roadSegments.map((element) {
                  return DropdownMenuItem(
                      value: element.id,
                      child: Text(element.name + " - ssud: " + element.ssud));
                }).toList(),
              );
            },
          ),
          Obx(
            () {
              return DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Vyberte stanicu'),
                value: selectedStation.value,
                // hintText: "Vyberte cestny usek",
                onChanged: (value) {
                  selectedStation.value = value;
                },
                items: stations.map((element) {
                  return DropdownMenuItem(
                      value: element.id,
                      child: Text(element.name +
                          " - " +
                          element.kmOfRoad.toString() +
                          " km"));
                }).toList(),
              );
            },
          ),
          TextFormField(
            onSaved: (value) {
              subject = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Prosím vyplňte názov';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Predmet problému",
            ),
          ),
          TextFormField(
            onSaved: (value) {
              description = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Prosím vyplňte popis';
              }
              return null;
            },
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: "Popis problému",
            ),
          ),
          TextFormField(
            onSaved: (value) {
              username = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Prosím vyplňte meno";
              }

              return null;
            },
            decoration: const InputDecoration(
              labelText: "Meno a priezvisko nahlasovateľa",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: () {
                if (!_key.currentState!.validate()) {
                  return;
                }
                if (selectedStation.value == null ||
                    selectedSegment.value == null) {
                  showError("Prosím vyberte cestný úsek a stanicu");
                  return;
                }
                _key.currentState!.save();
                IssuesService()
                    .createIssuesPost(IssueNewSchema(
                        username: username,
                        subject: subject,
                        description: description,
                        stationId: selectedStation.value!,
                        roadSegmentId: selectedSegment.value!))
                    .then((value) => issueId.value = value);
              },
              child: const Text("Odoslať"),
            ),
          ),
        ],
      ),
    );
  }
}
