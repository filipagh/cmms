import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:open_cmms/service/backend_api/redmine_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/config/redmine_setup.dart';

class Redmine_auth_form extends StatefulWidget implements hasFormTitle {
  Redmine_auth_form({Key? key}) : super(key: key);

  @override
  State<Redmine_auth_form> createState() => _Redmine_auth_formState();

  @override
  Widget getInstance() {
    return this;
  }

  @override
  String getTitle() {
    return "Redmine prihlásenie";
  }
}

class _Redmine_auth_formState extends State<Redmine_auth_form> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String url = '';
    String apiKey = '';

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (value) {
                url = value!;
              },
              decoration: const InputDecoration(
                labelText: "Redmine URL (https://redmine.example.com)",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Prosím zadajte URL';
                }
                return null;
              },
            ),
            TextFormField(
              onSaved: (value) {
                apiKey = value!;
              },
              //todo remove
              decoration: const InputDecoration(
                labelText: "Redmine API key",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Prosím zadajte API key';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  RedmineService()
                      .authRedmineAuthPost(RedmineAuthSchema(
                          redmineUrl: url, redmineApiKey: apiKey))
                      .then((value) {
                    if (value == null) {
                      showError("Prihlásenie bolo neúspešné");
                      return;
                    }
                    showFormDialog(
                        Redmine_setup_form(redmineAuthResponseSchema: value));
                  }, onError: (e) {
                    showError("Prihlásenie bolo neúspešné");
                  });
                }
              },
              child: const Text("Prihlásiť"),
            )
          ],
        ));
  }
}
