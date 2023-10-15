import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../snacbars.dart';

class RoadSegmentForm extends StatefulWidget
    implements FormWithLoadingIndicator {

  RoadSegmentForm.createNew({Key? key}) : super(key: key);

  @override
  RxBool isProcessing = false.obs;

  @override
  State<RoadSegmentForm> createState() => RoadSegmentFormState();

  @override
  String getTitle() {
    return "Vytvoriť cestný segment";
  }

  @override
  StatefulWidget getContent() {
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
              decoration: const InputDecoration(labelText: 'názov'),
              validator: (value) {
                return value == null || value.isEmpty ? "pridať názov" : null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                ssud = value!;
              },
              decoration: const InputDecoration(labelText: 'SSUD / SSUR'),
            ),
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();

                    widget.isProcessing.value = true;
                    RoadSegmentService()
                        .createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost(
                            RoadSegmentNewSchema(name: name, ssud: ssud))
                        .then((value) {
                      Get.back();
                      showOk("Cestný segment vytvorený");
                    });
                  }
                },
                child: const Text("vytvorit")),
          ],
        ),
      ),
    );
  }
}
