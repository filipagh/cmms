import 'package:BackendAPI/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/station/components_state.dart';

class CreateServiceTaskForm extends StatefulWidget
    implements hasFormTitle {
  StationSchema station;
  TaskType taskType;


  CreateServiceTaskForm({Key? key,
    required this.station, required this.taskType})
      : super(key: key);

  @override
  State<CreateServiceTaskForm> createState() =>
      _CreateServiceTaskFormState();

  @override
  Widget getInstance() {
    return this;
  }

  String getTitleString() {
    switch (taskType) {
      case TaskType.componentChange:
        throw UnimplementedError("wrong task form for {$taskType}");
        break;
      case TaskType.localInspection:
        return ""
        break;
      case TaskType.onSiteInspection:
      // TODO: Handle this case.
        break;
    }
  }

  @override
  String getTitle() {
    return ": ${station.name}";
  }
}

class _CreateServiceTaskFormState extends State<CreateServiceTaskForm> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                },
                decoration: InputDecoration(label: Text("Nazov ulohy")),
              ),
              TextFormField(
                controller: taskDescription,
                decoration: InputDecoration(label: Text("Popis ulohy")),
              ),

              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        ),

        // Row(
        //   children: [
        //     ElevatedButton(onPressed: () {}, child: Text("edit components")),
        //     ElevatedButton(onPressed: () {}, child: Text("manual service")),
        //     ElevatedButton(onPressed: () {}, child: Text("remote service")),
        //   ],
        // ),
        Container(height: 600, width: 500, child: buildComponentsEditList()),
        // Spacer(),
        Row(
          children: [
            ElevatedButton(onPressed: () {
              Get.back();
            }, child: Text("Zrusit")),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                TasksService()
                    .createComponentTaskTaskManagerCreateChangeComponentTaskPost(
                    TaskChangeComponentsNewSchema(stationId: widget.station.id,
                        name: taskName.text,
                        description: taskDescription.text,
                        add: widget.add,
                        remove: widget.remove));
                Get.back();
              }
            }, child: Text("Vytvorit ulohu")),
          ],
        )
      ],
    );
  }

  Widget buildComponentsEditList() {
    return ListView(children: buildActionsTiles());
  }

  List<Widget> buildActionsTiles() {
    List<Widget> tiles = [];
    tiles.add(ListTile(
      title: Text("Pridat komponenty:"),
      subtitle: Text(buildComponentsString(widget.add.map<String>((e) {
        return e.newAssetId;
      }))),
    ));
    tiles.add(ListTile(
      title: Text("Odobrat komponenty:"),
      subtitle: Text(buildComponentsString(widget.remove.map((e) {
        return widget.components.components.firstWhereOrNull((element) {
          return e.assignedComponentId == element.id;
        })!.assetId;
      }))),
    ));

    return tiles;
  }

  buildComponentsString(Iterable<String> assetsIds) {
    List<String> string = [];
    if (assetsIds.isEmpty) {
      return "Nic";
    }
    assetsIds.forEach((element) {
      string.add(widget._typeState.getAssetById(element)!.name);
    });
    return string.join(", ");
  }
}
