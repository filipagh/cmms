import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks/tasks_on_site_service.dart';
import 'package:open_cmms/service/backend_api/tasks/tasks_remote_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class CreateServiceTaskForm extends StatefulWidget
    implements FormWithLoadingIndicator {
  final StationSchema station;
  final TaskType taskType;

  CreateServiceTaskForm(
      {Key? key, required this.station, required this.taskType})
      : super(key: key);

  @override
  State<CreateServiceTaskForm> createState() => _CreateServiceTaskFormState();

  @override
  Widget getContent() {
    return this;
  }

  @override
  RxBool isProcessing = false.obs;

  String getTitleString() {
    switch (taskType) {
      case TaskType.componentChange:
        throw UnimplementedError("zlý formular pre úlohu: {$taskType}");
      case TaskType.onSiteService:
        return "Kontrola stanice na mieste";
      case TaskType.remoteService:
        return "Vzdialena kontrola stanice";
    }
    throw UnimplementedError("zlý formular pre úlohu: {$taskType}");
  }

  @override
  String getTitle() {
    return getTitleString() + ": ${station.name}";
  }
}

class _CreateServiceTaskFormState extends State<CreateServiceTaskForm> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    taskName.text = _getTaskName();
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskName,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Zadaj nazov ulohy";
                  }
                  return null;
                },
                decoration: const InputDecoration(label: Text("Nazov ulohy")),
              ),
              TextFormField(
                controller: taskDescription,
                decoration: const InputDecoration(label: Text("Popis ulohy")),
              ),
            ],
          ),
        ),
        // Spacer(),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Zrusit")),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.isProcessing.value = true;
                    if (widget.taskType == TaskType.onSiteService) {
                      TasksOnSiteService()
                          .createTaskServiceOnSiteCreateServiceOnSideTaskPost([
                        TaskServiceOnSiteNewSchema(
                            stationId: widget.station.id,
                            name: taskName.text,
                            description: taskDescription.text)
                      ]).then((value) => Get.back(result: true));
                    } else {
                      TasksRemoteService()
                          .createTaskServiceRemoteCreateServiceRemoteTaskPost(
                              TaskServiceRemoteNewSchema(
                                  stationId: widget.station.id,
                                  name: taskName.text,
                                  description: taskDescription.text))
                          .then((value) => Get.back(result: true));
                    }
                  }
                },
                child: const Text("Vytvorit ulohu")),
          ],
        )
      ],
    );
  }

  String _getTaskName() {
    switch (widget.taskType) {
      case TaskType.componentChange:
        throw UnimplementedError("zlý formular pre úlohu: {$widget.taskType}");
      case TaskType.onSiteService:
        return "Profylaktika: ${widget.station.name}";
      case TaskType.remoteService:
        return "Vzdialená kontrola stanice: ${widget.station.name}";
    }
    throw UnimplementedError("zlý formular pre úlohu: {$widget.taskType}");
  }
}
