import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/edit_station_components_form.dart';
import 'package:open_cmms/widgets/forms/tasks/create_service_task.dart';


class CreateTaskForm extends StatelessWidget implements PopupForm {
  final StationSchema station;

  CreateTaskForm({Key? key, required this.station})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () async {
                  Get.back(
                      result: await showFormDialog(
                          EditStationComponentsForm(station: station)));
                },
                child: Text("Zmena komponentov")),
            ElevatedButton(
                onPressed: () async {
                  Get.back(
                      result: await showFormDialog(CreateServiceTaskForm(
                    station: station,
                    taskType: TaskType.onSiteService,
                  )));
                },
                child: Text("Osobny servis")),
            ElevatedButton(
                onPressed: () async {
                  Get.back(
                      result: await showFormDialog(CreateServiceTaskForm(
                    station: station,
                    taskType: TaskType.remoteService,
                  )));
                },
                child: Text("Vzdialeny servis")),
          ],
        ),
      ],
    );
  }

  @override
  Widget getContent() {
    return this;
  }

  @override
  String getTitle() {
    return "Vytvoriť novu úlohu pre ${station.name}";
  }
}
