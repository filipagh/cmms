import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
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
        pageText: Text("Nahlásené chyby"),
      ),
      body: Row(children: [
        MainMenuWidget(),
        VerticalDivider(),
        Obx(() {
          return Expanded(
            child: ListView(
                children: (issueId.value?.map<ExpansionTile>((element) {
                      return ExpansionTile(
                          leading: element.stationId != null
                              ? Icon(Icons.bug_report)
                              : Icon(Icons.person),
                          title: Text(element.subject),
                          subtitle: Text(
                              element.createdOn.toString().substring(0, 19)),
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SelectableText(
                                            "popis : ${element.description}"),
                                        Text("autor : ${element.user}"),
                                        Text("stanica : ${element.stationId}"),
                                        Text(
                                            "komponent : ${element.componentId}"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          IssuesService()
                                              .resolveIssueIssuesResolveTaskIdPost(
                                                  element.id)
                                              .then((value) {
                                            showOk("Chyba bola vyriešená");
                                            loadIssues();
                                          });
                                        },
                                        child: Text("zrušiť"),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                      ),
                                      Padding(padding: EdgeInsets.all(5)),
                                      ElevatedButton(
                                          onPressed: () async {
                                            StationSchema station =
                                                await showFormDialog(
                                                    StationPickerForm());
                                            showFormDialog(CreateTaskForm(
                                                station: station));
                                          },
                                          child: Text("vytvoriť ulohu"))
                                    ],
                                  ),
                                ])
                          ]);
                    }).toList() ??
                    [])),
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
