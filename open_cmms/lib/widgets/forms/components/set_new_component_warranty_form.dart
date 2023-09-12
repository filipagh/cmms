import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../service/backend_api/investment_contract_service.dart';
import '../investment_contract/investment_contract_picker.dart';

class SetNewComponentWarrantyForm extends StatelessWidget
    implements hasFormTitle {
  SetNewComponentWarrantyForm({Key? key, ComponentWarranty? suggestedWarranty})
      : super(key: key) {
    if (suggestedWarranty != null) {
      warrantySource.value = suggestedWarranty.componentWarrantySource;
      suggestedWarranty.componentWarrantyId != null
          ? InvestmentContractService()
              .getContractInvestmentContractContractGet(
                  suggestedWarranty.componentWarrantyId!)
              .then((value) => warrantyContract.value = value)
          : null;
      if (suggestedWarranty.componentWarrantyDays != 0) {
        setComponentWarranty(DateTime.now()
            .add(Duration(days: suggestedWarranty.componentWarrantyDays)));
      } else {
        setComponentWarranty(suggestedWarranty.componentWarrantyUntil);
      }
      if (suggestedWarranty.componentPrepaidServiceDays != 0) {
        setPrepaidWarranty(DateTime.now().add(
            Duration(days: suggestedWarranty.componentPrepaidServiceDays)));
      } else {
        setPrepaidWarranty(suggestedWarranty.componentPrepaidServiceUntil);
      }
    }
  }

  String getTitle() {
    return "Zadaj zaruku pre nove komponenty";
  }

  @override
  Widget getInstance() {
    return this;
  }

  final sourceOptions = ComponentWarrantySource.values
      .map((e) => DropdownMenuItem<ComponentWarrantySource>(
            value: e,
            child: Text(e.value),
          ))
      .toList();

  late Rx<ComponentWarrantySource> warrantySource = sourceOptions
      .firstWhere((element) => element.value == ComponentWarrantySource.NAN)
      .value!
      .obs;
  Rxn<InvestmentContractSchema> warrantyContract =
      Rxn<InvestmentContractSchema>();
  Rxn<DateTime> componentWarrantyDate = Rxn<DateTime>();
  TextEditingController componentWarrantyDateText = TextEditingController();
  Rxn<DateTime> prepaidWarrantyDate = Rxn<DateTime>();
  TextEditingController prepaidWarrantyDateText = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => DropdownButtonFormField<ComponentWarrantySource>(
                    decoration: const InputDecoration(
                      labelText: "Záruka",
                    ),
                    items: sourceOptions,
                    onChanged: (v) async {
                      if (v != null) {
                        if (v == ComponentWarrantySource.INVESTMENT_CONTRACT) {
                          await showFormDialog(
                                  InvestmentContractPicker(onlyActive: false))
                              .then((value) {
                            if (value == null) {
                              return;
                            }
                            warrantyContract.value = value;
                            setComponentWarranty(DateTime.now().add(
                                Duration(days: value.warrantyPeriodDays!)));
                            setPrepaidWarranty(DateTime.now().add(
                                Duration(days: value.warrantyPeriodDays!)));
                          });
                        }
                        if (v == ComponentWarrantySource.NAN) {
                          warrantyContract.value = null;
                          setComponentWarranty(null);
                          setPrepaidWarranty(null);
                        }
                        warrantySource.value = v;
                      }
                    },
                    value: warrantySource.value,
                  ),
                ),
                Obx(() => Text(
                    "Zmluva: ${warrantyContract.value?.identifier ?? "žiadna"}")),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setComponentWarranty(
                              (componentWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: -365)));
                        },
                        child: const Text("-1 rok")),
                    ElevatedButton(
                        onPressed: () {
                          setComponentWarranty(
                              (componentWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: -1)));
                        },
                        child: const Text("-1 deň")),
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (v) {
                              componentWarrantyDate.value = DateTime.now()
                                  .add(Duration(days: int.parse(v)));
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: componentWarrantyDateText,
                            decoration: const InputDecoration(
                                label: Text("dĺžka záruky v dňoch")),
                            validator: (v) {
                              return (v == null ||
                                      v.isEmpty ||
                                      int.parse(v) <= 0)
                                  ? "zvoľte kladnú dĺžku záruky"
                                  : null;
                            },
                          ),
                          Obx(() => Text(componentWarrantyDate.value
                                  ?.toIso8601String()
                                  .substring(0, 10) ??
                              ""))
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setComponentWarranty(
                              (componentWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: 1)));
                        },
                        child: const Text("+1 deň")),
                    ElevatedButton(
                        onPressed: () {
                          setComponentWarranty(
                              (componentWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: 365)));
                        },
                        child: const Text("+1 rok")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setPrepaidWarranty(
                              (prepaidWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: -365)));
                        },
                        child: const Text("-1 rok")),
                    ElevatedButton(
                        onPressed: () {
                          setPrepaidWarranty(
                              (prepaidWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: -1)));
                        },
                        child: const Text("-1 deň")),
                    SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (v) {
                              prepaidWarrantyDate.value = DateTime.now()
                                  .add(Duration(days: int.parse(v)));
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: prepaidWarrantyDateText,
                            decoration: const InputDecoration(
                                label: Text(
                                    "dĺžka predplaneneho servisu v dňoch")),
                            validator: (v) {
                              return ((int.tryParse(v ?? "0") ?? 0) < 0)
                                  ? "zvoľte kladnú dĺžku záruky"
                                  : null;
                            },
                          ),
                          Obx(() => Text(prepaidWarrantyDate.value
                                  ?.toIso8601String()
                                  .substring(0, 10) ??
                              ""))
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setPrepaidWarranty(
                              (prepaidWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: 1)));
                        },
                        child: const Text("+1 deň")),
                    ElevatedButton(
                        onPressed: () {
                          setPrepaidWarranty(
                              (prepaidWarrantyDate.value ?? DateTime.now())
                                  .add(const Duration(days: 365)));
                        },
                        child: const Text("+1 rok")),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Späť")),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if (warrantySource ==
                                  ComponentWarrantySource.INVESTMENT_CONTRACT &&
                              warrantyContract.value == null) {
                            showError("Zmluva nie je vybraná");
                            return;
                          }
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          Get.back(
                              result: ComponentWarranty(
                                  componentWarrantyId:
                                      warrantyContract.value?.id,
                                  componentWarrantyDays: int.tryParse(
                                          componentWarrantyDateText.text) ??
                                      0,
                                  componentWarrantySource: warrantySource.value,
                                  componentPrepaidServiceDays: int.tryParse(
                                          prepaidWarrantyDateText.text) ??
                                      0));
                        },
                        child: const Text("zvolť")),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void setPrepaidWarranty(DateTime? value) {
    if (value == null) {
      prepaidWarrantyDate.value = null;
      prepaidWarrantyDateText.text = "";
    } else {
      prepaidWarrantyDate.value = value;
      prepaidWarrantyDateText.text = value
          .difference(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))
          .inDays
          .toString();
    }
  }

  void setComponentWarranty(DateTime? value) {
    if (value == null) {
      componentWarrantyDate.value = null;
      componentWarrantyDateText.text = "";
    } else {
      componentWarrantyDate.value = value;
      componentWarrantyDateText.text = value
          .difference(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day))
          .inDays
          .toString();
    }
  }
}
