import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/redmine_service.dart';
import 'package:open_cmms/snacbars.dart';

import '../../dialog_form.dart';

class Redmine_setup_form extends StatefulWidget implements hasFormTitle {
  Redmine_setup_form({Key? key, required this.redmineAuthResponseSchema})
      : super(key: key);

  late RedmineAuthResponseSchema redmineAuthResponseSchema;

  @override
  State<Redmine_setup_form> createState() => _Redmine_setup_formState();

  @override
  Widget getInstance() {
    return this;
  }

  @override
  String getTitle() {
    return "Redmine setup";
  }
}

class _Redmine_setup_formState extends State<Redmine_setup_form> {
  final _formKey = GlobalKey<FormState>();

  String projectId = '';
  String trackerId = '';
  String superVisorId = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Redmine URL",
          ),
          readOnly: true,
          initialValue: widget.redmineAuthResponseSchema.redmineUrl,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Redmine API key",
          ),
          readOnly: true,
          initialValue: widget.redmineAuthResponseSchema.redmineApiKey,
        ),
        DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Prosím vyberte projekt';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Redmine project",
          ),
          items: widget.redmineAuthResponseSchema.projects
              .map((e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              projectId = value.toString();
            });
          },
        ),
        DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Prosím vyberte tracker';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Redmine tracker",
          ),
          items: widget.redmineAuthResponseSchema.trackers
              .map((e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              trackerId = value.toString();
            });
          },
        ),
        DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Prosím vyberte super Visora';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: "Redmine superVisor",
          ),
          items: widget.redmineAuthResponseSchema.users
              .map((e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              superVisorId = value.toString();
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              RedmineService()
                  .authRedmineSetupPost(RedmineSetupRequestSchema(
                redmineUrl: widget.redmineAuthResponseSchema.redmineUrl,
                redmineApiKey: widget.redmineAuthResponseSchema.redmineApiKey,
                redmineProjectId: projectId,
                redmineTrackerId: trackerId,
                redmineSupervisorId: superVisorId,
              ))
                  .then((value) {
                Get.close(2);
                showOk("Redmine setup bol úspešne uložený");
              }, onError: (error) {
                showError(
                    "Redmine setup sa nepodarilo uložiť " + error.toString());
              });
            }
          },
          child: const Text('Uložiť'),
        ),
      ]),
    );
  }
}
