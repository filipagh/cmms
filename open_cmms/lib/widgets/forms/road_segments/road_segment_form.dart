import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/road_segment_model.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class RoadSegmentForm extends StatefulWidget implements hasFormTitle {
  late final RoadSegmentModel? editItem;

  RoadSegmentForm.createNew({Key? key}) : super(key: key) {
    editItem = null;
  }

  RoadSegmentForm.editItem({Key? key, required RoadSegmentModel editItem})
      : super(key: key) {
    editItem = editItem;
  }

  @override
  State<RoadSegmentForm> createState() => RoadSegmentFormState();

  @override
  String getTitle() {
    return editItem == null
        ? "Create new Road Segment"
        : "Edit Road Segment : ${editItem!.name}";
  }

  @override
  StatefulWidget getInstance() {
    return this;
  }
}

class RoadSegmentFormState extends State<RoadSegmentForm> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String description = "";
  String ssud = "";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (value) {
                name = value!;
              },
              initialValue:
                  widget.editItem == null ? "" : widget.editItem!.name,
              decoration: const InputDecoration(labelText: 'name'),
              validator: (value) {
                return value == null || value.isEmpty ? "add name" : null;
              },
            ),
            //todo
            // TextFormField(
            //   onSaved: (value) {
            //     description = value!;
            //   },
            //   initialValue:
            //       widget.editItem == null ? "" : widget.editItem!.text,
            //   decoration: InputDecoration(labelText: 'description'),
            // ),
            TextFormField(
              onSaved: (value) {
                ssud = value!;
              },
              initialValue:
                  widget.editItem == null ? "" : widget.editItem!.ssud,
              decoration: const InputDecoration(labelText: 'ssud'),
            ),

            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    if (widget.editItem != null) {
                      //todo edit
                      // widget._roadSegmentState.editRoadSegment(widget.editItem!.id, name, description,ssud);
                    } else {
                      RoadSegmentService()
                          .createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost(
                              RoadSegmentNewSchema(name: name, ssud: ssud));
                    }
                    Get.back();
                  }
                },
                child: const Text("submit")),
          ],
        ),
      ),
    );
  }
}
