import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/states/asset_types_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/station/components_state.dart';

class CreateChangeComponentsTaskForm extends StatefulWidget
    implements FormWithLoadingIndicator {
  StationSchema station;
  List<TaskComponentAddNewSchema> add;
  List<TaskComponentRemoveNewSchema> remove;
  final AssetTypesState _typeState = Get.find();
  late AssignedComponentsState components;

  // todo deduplikacia warranty

  CreateChangeComponentsTaskForm(
      {Key? key,
      required this.station,
      required this.add,
      required this.remove})
      : super(key: key) {
    try {
      components = Get.find(tag: station.id);
    } catch (e) {
      components =
          Get.put(AssignedComponentsState(station.id), tag: station.id);
    }
  }

  @override
  State<CreateChangeComponentsTaskForm> createState() =>
      _CreateChangeComponentsTaskFormState();

  @override
  Widget getContent() {
    return this;
  }

  @override
  String getTitle() {
    return "Zmena komponentov pre stanicu: ${station.name}";
  }

  @override
  RxBool isProcessing = false.obs;
}

class _CreateChangeComponentsTaskFormState
    extends State<CreateChangeComponentsTaskForm> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDescription = TextEditingController();
  final TextEditingController warrantyDate = TextEditingController();
  final TextEditingController warrantyDays = TextEditingController();
  int? warrantyPeriodDays;

  final _formKey = GlobalKey<FormState>();

  updateWarranty(DateTime newDate, {bool updateDays = true}) {
    warrantyDate.text = newDate.toIso8601String().split("T").first;
    var now = DateTime.now();
    var delta =
        newDate.difference(DateTime(now.year, now.month, now.day)).inDays;
    if (updateDays) {
      warrantyDays.text = delta.toString();
    }
    warrantyPeriodDays = delta;
    _formKey.currentState!.validate();
  }

  updateWarrantyDays(int days) {
    updateWarranty(DateTime.now().add(Duration(days: days)), updateDays: false);
  }

  @override
  Widget build(BuildContext context) {
    taskName.text = widget.station.name + ": Zmena komponentov";
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
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

          Container(height: 400, width: 500, child: buildComponentsEditList()),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Zrusit")),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.isProcessing.value = true;
                        TasksService()
                            .createComponentTaskTaskManagerCreateChangeComponentTaskPost(
                                TaskChangeComponentsNewSchema(
                                    stationId: widget.station.id,
                                    name: taskName.text,
                                    description: taskDescription.text,
                                    add: widget.add,
                                    remove: widget.remove,
                            ))
                            .then((value) => Get.back(result: true));
                      }
                    },
                    child: Text("Vytvorit ulohu")),
              ],
            ),
          )
        ],
      ),
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
