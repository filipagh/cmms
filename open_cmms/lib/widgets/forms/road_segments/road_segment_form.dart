import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/road_segment_model.dart';
import 'package:open_cmms/states/road_segment_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

const EMPTY_CATEGORY = "NEW_CATEGORY";

class RoadSegmentForm extends StatefulWidget implements hasFormTitle {
  final RoadSegmentState _roadSegmentState = Get.find();
  late final RoadSegmentModel? editItem;

  RoadSegmentForm.createNew({Key? key}) : super(key: key) {
    this.editItem = null;
  }

  RoadSegmentForm.editItem({Key? key, required RoadSegmentModel editItem})
      : super(key: key) {
    this.editItem = editItem;

  }

  @override
  State<RoadSegmentForm> createState() => RoadSegmentFormState();

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
      constraints: BoxConstraints(maxWidth: 500),
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
              decoration: InputDecoration(labelText: 'name'),
              validator: (value) {
                return value == null || value.isEmpty ? "add name" : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                description = value!;
              },
              initialValue:
                  widget.editItem == null ? "" : widget.editItem!.text,
              decoration: InputDecoration(labelText: 'description'),
            ),
            TextFormField(
              onSaved: (value) {
                ssud = value!;
              },
              initialValue:
                  widget.editItem == null ? "" : widget.editItem!.ssud,
              decoration: InputDecoration(labelText: 'ssud'),
            ),

            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    if (widget.editItem != null) {
                      widget._roadSegmentState.editRoadSegment(widget.editItem!.id, name, description,ssud);
                    } else {
                      widget._roadSegmentState.createNewRoadSegment( name, description,ssud);
                    }
                    Get.back();
                  }
                },
                child: Text("submit")),
          ],
        ),
      ),
    );
  }
}
