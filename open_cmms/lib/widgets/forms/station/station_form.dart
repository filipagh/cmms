import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class StationForm extends StatefulWidget implements hasFormTitle {
  final RoadSegmentSchema roadSegment;

  const StationForm(this.roadSegment, {Key? key}) : super(key: key);

  @override
  String getTitle() {
    return "Create new Station";
  }

  @override
  StationForm getInstance() {
    return this;
  }

  @override
  State<StationForm> createState() => _StationFormState();
}

class _StationFormState extends State<StationForm> {
  final _formKey = GlobalKey<FormState>();
  String name = "";

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
              decoration: const InputDecoration(labelText: 'name'),
              validator: (value) {
                return value == null || value.isEmpty ? "add name" : null;
              },
            ),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    StationService().createStationStationCreateStationPost(
                        StationNewSchema(
                            name: name, roadSegmentId: widget.roadSegment.id));
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
