import 'package:BackendAPI/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/station/station_info_page.dart';
import 'package:open_cmms/service/backend_api/issues_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/tasks/create_task.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/forms/station/station_picker.dart';
import '../widgets/main_menu_widget.dart';

class IssuesPage extends StatelessWidget {
  static const ENDPOINT = "/issues";

  IssuesPage({Key? key}) : super(key: key);
  final Rxn<List<IssueSchema>> issueId = Rxn<List<IssueSchema>>();

  @override
  Widget build(BuildContext context) {
    loadIssues();

    return Scaffold(
      appBar: CustomAppBar(
        pageText: const Text("Nahlásené chyby"),
      ),
      body: Row(children: [
        MainMenuWidget(),
        const VerticalDivider(),
        Obx(() {
          return Expanded(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          IssuesService()
                              .resolveAutoReportedIssuesResolveAllAutoReportedGet()
                              .then((value) {
                            loadIssues();
                            showOk(
                                "Všetky automaticky nahlasené chyby boli vyriešené");
                          });
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text(
                            "zmazať všetky automaticky nahlasené chyby")),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                      children: (issueId.value?.map<ExpansionTile>((element) {
                            return ExpansionTile(
                                leading: element.isExternal
                                    ? const Icon(Icons.person)
                                    : const Icon(Icons.bug_report),
                                title: Text(element.subject +
                                    " - " +
                                    element.stationName +
                                    " - " +
                                    element.roadSegmentName),
                                subtitle: Text(element.createdOn
                                    .toString()
                                    .substring(0, 19)),
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                  "popis : ${element.description}"),
                                              Text(
                                                  "autor : ${element.username}"),
                                              RichText(
                                                  text: TextSpan(
                                                text: "stanica : ",
                                                children: [
                                                  TextSpan(
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () => Get.toNamed(
                                                            StationBasePage
                                                                    .ENDPOINT +
                                                                "/${element.stationId}" +
                                                                StationInfoPage
                                                                    .ENDPOINT),
                                                      text: element
                                                              .stationName +
                                                          " - " +
                                                          element
                                                              .roadSegmentName,
                                                      style: const TextStyle(
                                                          color: Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline))
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                IssuesService()
                                                    .resolveIssueIssuesResolveTaskIdPost(
                                                        element.id)
                                                    .then((value) {
                                                  showOk(
                                                      "Chyba bola vyriešená");
                                                  loadIssues();
                                                });
                                              },
                                              child: const Text("zrušiť"),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.all(5)),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  StationSchema station =
                                                      await showFormDialog(
                                                          StationPickerForm());
                                                  showFormDialog(CreateTaskForm(
                                                      station: station));
                                                },
                                                child: const Text(
                                                    "vytvoriť ulohu"))
                                          ],
                                        ),
                                      ])
                                ]);
                          }).toList() ??
                          [])),
                ),
              ],
            ),
          );
        }),
      ]),
    );
  }

  loadIssues() {
    IssuesService()
        .getActiveIssuesIssuesActiveGet()
        .then((value) => issueId.value = value);
  }
}
