import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/issues_service.dart';

class IssueReportPage extends StatelessWidget {
  static const ENDPOINT = "/issue_report";

  IssueReportPage({Key? key}) : super(key: key);
  final Rxn<String> issueId = Rxn<String>();
  var subject = "";
  var description = "";
  var email = "";
  var _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          width: 600,
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            if (issueId.value != null) {
              return buildSuccesSendIssue();
            }
            return buildIssueForm();
          }),
        ),
      ),
    );
  }

  Column buildSuccesSendIssue() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
            "Váš problém ${issueId.value!} bol úspešne odoslaný, ďakujeme za pomoc"),
      ],
    );
  }

  Form buildIssueForm() {
    return Form(
      key: _key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              "Formulár na nahlásenie problému meteorologickych staníc Spinet"),
          const Divider(),
          TextFormField(
            onSaved: (value) {
              subject = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Prosím vyplňte názov';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Názov",
            ),
          ),
          TextFormField(
            onSaved: (value) {
              description = value!;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Prosím vyplňte popis';
              }
              return null;
            },
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: "Popis",
            ),
          ),
          TextFormField(
            onSaved: (value) {
              email = value!;
            },
            validator: (value) {
              final emailRegex = RegExp(
                  r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');

              if (value == null || value.isEmpty) {
                return "Prosím vyplňte platný email";
              } else if (!emailRegex.hasMatch(value)) {
                return "Prosím vyplňte platný email";
              }

              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              onPressed: () {
                if (!_key.currentState!.validate()) {
                  return;
                }
                _key.currentState!.save();
                IssuesService()
                    .createIssuesPost(subject, description, email)
                    .then((value) => issueId.value = value);
              },
              child: const Text("Odoslať"),
            ),
          ),
        ],
      ),
    );
  }
}
