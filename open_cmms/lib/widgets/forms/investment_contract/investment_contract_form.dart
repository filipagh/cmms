import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/investment_contract_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class InvestmentContractForm extends StatefulWidget
    implements FormWithLoadingIndicator {
  InvestmentContractForm({Key? key}) : super(key: key);

  @override
  State<InvestmentContractForm> createState() => _InvestmentContractFormState();

  @override
  String getTitle() {
    return "Nová investičná zmluva";
  }

  @override
  RxBool isProcessing = false.obs;

  @override
  Widget getContent() {
    return this;
  }
}

class _InvestmentContractFormState extends State<InvestmentContractForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateDue = TextEditingController();
  final TextEditingController dateFrom = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController warranty = TextEditingController();
  DateTime? dateDueDT;
  DateTime? dateFromDT;
  Rx<DateTime> warrantyDT =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;

  @override
  Widget build(BuildContext context) {
    warranty.text = "0";
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: name,
            decoration:
                const InputDecoration(label: Text("Identifikátor zmluvy")),
            validator: (v) {
              return (v == null || v.isEmpty) ? "zvoľte identifikátor" : null;
            },
          ),
          TextFormField(
              controller: dateFrom,
              validator: (v) {
                return (v == null || v.isEmpty) ? "zvoľte dátum" : null;
              },
              decoration:
                  const InputDecoration(labelText: "Datum platnosti od"),
              onTap: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        initialDate: DateTime.now())
                    .then((value) {
                  dateFrom.text = value.toString().substring(0, 10);
                  dateFromDT = value;
                });
              }),
          TextFormField(
              controller: dateDue,
              validator: (v) {
                return (v == null || v.isEmpty) ? "zvoľte dátum" : null;
              },
              decoration:
                  const InputDecoration(labelText: "Datum platnosti do"),
              onTap: () {
                showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                        initialDate: DateTime.now())
                    .then((value) {
                  dateDue.text = value.toString().substring(0, 10);
                  dateDueDT = value;
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    addDurationToWarranty(const Duration(days: -365));
                  },
                  child: const Text("-1 rok")),
              ElevatedButton(
                  onPressed: () {
                    addDurationToWarranty(const Duration(days: -1));
                  },
                  child: const Text("-1 deň")),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (v) {
                        warrantyDT.value =
                            DateTime.now().add(Duration(days: int.parse(v)));
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: warranty,
                      decoration: const InputDecoration(
                          label: Text("dĺžka záruky v dňoch")),
                      validator: (v) {
                        return (v == null || v.isEmpty || int.parse(v) <= 0)
                            ? "zvoľte kladnú dĺžku záruky"
                            : null;
                      },
                    ),
                    Obx(() => Text(
                        warrantyDT.value.toIso8601String().substring(0, 10)))
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    addDurationToWarranty(const Duration(days: 1));
                  },
                  child: const Text("+1 deň")),
              ElevatedButton(
                  onPressed: () {
                    addDurationToWarranty(const Duration(days: 365));
                  },
                  child: const Text("+1 rok")),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Zrušiť")),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.isProcessing.value = true;
                      InvestmentContractService()
                          .createContractInvestmentContractCreateContractPost(
                              InvestmentContractNewSchema(
                                  identifier: name.value.text,
                                  validFrom: dateFromDT!,
                                  validUntil: dateDueDT!,
                                  warrantyPeriodDays: int.parse(warranty.text)))
                          .then((value) {
                        Get.back();
                        showOk("Investičná zmluva bola pridaná");
                      });
                    }
                  },
                  child: const Text("Vytvoriť zmluvu")),
            ],
          )
        ],
      ),
    );
  }

  void addDurationToWarranty(Duration duration) {
    warrantyDT.value = warrantyDT.value.add(duration);
    warranty.text = (warrantyDT.value
            .difference(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day))
            .inDays)
        .toString();
  }
}
