import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/util/date_utils.dart';

class InstallComponentForm extends StatelessWidget implements PopupForm {
  TextEditingController installDateText = TextEditingController();

  InstallComponentForm(
      {Key? key, required this.asset, required this.taskItemId})
      : super(key: key);

  AssetSchema asset;
  late String taskItemId;
  String serialNumber = "";
  DateTime? install_date;

  String getTitle() {
    return "Údaje o inštalácií komponentu ${asset.name}";
  }

  @override
  Widget getContent() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Vložte sériové číslo"),
        Form(
          child: Column(
            children: [
              TextField(
                autofocus: true,
                onChanged: (v) {
                  serialNumber = v;
                },
                decoration: InputDecoration(labelText: 'Sériové číslo'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Dátum inštalácie komponentu",
                ),
                readOnly: true,
                controller: installDateText,
                validator: (v) {
                  return (v == null || v.isEmpty) ? "zvoľte dátum" : null;
                },
                onTap: () {
                  var now = DateTime.now();
                  showDatePicker(
                          context: context,
                          firstDate:
                              now.subtract(const Duration(days: 365 * 20)),
                          lastDate: now,
                          initialDate: now)
                      .then((value) {
                    if (value == null) {
                      return;
                    }
                    install_date = value;
                    installDateText.text =
                        value.toIso8601String().split("T").first;
                  });
                },
              )
            ],
          ),
        ),
        TextButton(
            onPressed: () {
              if (install_date == null) {
                showError("Dátum inštalácie nesmie byť prázdny");
                return;
              }
              if (serialNumber == null || serialNumber.isEmpty) {
                showError("Sériové číslo nesmie byť prázdne");
                return;
              }
              Get.back(
                  result: TaskChangeComponentRequestCompleted(
                      id: taskItemId,
                      serialNumber: serialNumber,
                      completedAt: convertDatetimeToUtc(install_date!)));
            },
            child: Text("uloziť")),
      ],
    );
  }
}
