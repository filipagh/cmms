import 'package:BackendAPI/api.dart' as schema;
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/service_contracts/component_select_service_contract_form.dart';
import 'package:open_cmms/widgets/forms/util/contract_types_localization.dart';
import 'package:open_cmms/widgets/forms/util/date_utils.dart';

import '../investment_contract/investment_contract_picker.dart';

class AddComponentToStationForm extends StatelessWidget
    implements FormWithLoadingIndicator {
  final schema.StationSchema station;
  final schema.AssetSchema asset;

  AddComponentToStationForm(
      {Key? key, required this.station, required this.asset})
      : super(key: key);

  String getTitle() {
    return "Pridat komponent ${asset.name} na stanicu ${station.name}";
  }

  @override
  Widget getContent() {
    return this;
  }

  @override
  RxBool isProcessing = false.obs;

  final sourceOptions = ComponentWarrantySource.values
      .map((e) => DropdownMenuItem<ComponentWarrantySource>(
            value: e,
            child: Text(localize(e)),
          ))
      .toList();

  late Rx<ComponentWarrantySource> warrantySource = sourceOptions
      .firstWhere((element) => element.value == ComponentWarrantySource.NAN)
      .value!
      .obs;
  Rxn<InvestmentContractSchema> warrantyContract =
      Rxn<InvestmentContractSchema>();
  Rxn<DateTime> installDate = Rxn<DateTime>();
  TextEditingController installDateText = TextEditingController();
  Rxn<DateTime> componentWarrantyDate = Rxn<DateTime>();
  TextEditingController componentWarrantyDateText = TextEditingController();
  Rxn<DateTime> prepaidWarrantyDate = Rxn<DateTime>();
  TextEditingController prepaidWarrantyDateText = TextEditingController();
  TextEditingController serialNumberText = TextEditingController();
  TextEditingController componentContractsText = TextEditingController();
  RxList<ServiceContractSchema> componentContracts =
      <ServiceContractSchema>[].obs;

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
                Expanded(
                    child: (TextFormField(
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
                      installDate.value = value;
                      installDateText.text =
                          value.toIso8601String().split("T").first;
                    });
                  },
                ))),
                Divider(),
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
                            var date = installDate.value ?? DateTime.now();
                            setComponentWarranty(date.add(
                                Duration(days: value.warrantyPeriodDays!)));
                            setPrepaidWarranty(date.add(
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
                Expanded(
                    child: (TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Dátum konca záruky komponentu",
                  ),
                  readOnly: true,
                  controller: componentWarrantyDateText,
                  validator: (v) {
                    return warrantySource.value !=
                                ComponentWarrantySource.NAN &&
                            (v == null || v.isEmpty)
                        ? "zvoľte dátum"
                        : null;
                  },
                  onTap: () {
                    if (warrantySource.value == ComponentWarrantySource.NAN) {
                      return;
                    }
                    var now = DateTime.now();
                    showDatePicker(
                            context: context,
                            firstDate:
                                now.subtract(const Duration(days: 365 * 10)),
                            lastDate: now.add(const Duration(days: 365 * 10)),
                            initialDate: now)
                        .then((value) {
                      if (value == null) {
                        return;
                      }
                      setComponentWarranty(value);
                    });
                  },
                ))),
                Expanded(
                    child: (TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Dátum konca predplateného servisu komponentu",
                  ),
                  readOnly: true,
                  controller: prepaidWarrantyDateText,
                  onTap: () {
                    if (warrantySource.value == ComponentWarrantySource.NAN) {
                      return;
                    }
                    var now = DateTime.now();
                    showDatePicker(
                            context: context,
                            firstDate:
                                now.subtract(const Duration(days: 365 * 10)),
                            lastDate: now.add(const Duration(days: 365 * 10)),
                            initialDate: now)
                        .then((value) {
                      if (value == null) {
                        return;
                      }
                      setPrepaidWarranty(value);
                    });
                  },
                ))),
                Divider(),
                Expanded(
                    child: (TextFormField(
                  validator: (v) {
                    return (v == null || v.isEmpty)
                        ? "zadajte seriové číslo"
                        : null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Seriové číslo",
                  ),
                  controller: serialNumberText,
                ))),
                Expanded(
                    child: (TextFormField(
                  readOnly: true,
                  onTap: () async {
                    await showFormDialog(ComponentsSelectServiceContractForm(
                      onlyActive: true,
                      selectedContractsId: componentContracts
                          .map((element) => element.id)
                          .toList(),
                    )).then((value) {
                      if (value == null) {
                        return;
                      }
                      componentContracts.value = value ?? [];
                      componentContractsText.text =
                          componentContracts.value.map((e) => e.name).join(",");
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Servisné zmluvy",
                  ),
                  controller: componentContractsText,
                ))),
                // todo servisne zmluvy
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
                          isProcessing.value = true;
                          await AssignedComponentService()
                              .createInstalledComponentAssignedComponentsCreateInstalledComponentPost(
                            warrantySource.value,
                            convertDatetimeToUtc(installDate.value!),
                            [
                              AssignedComponentNewSchema(
                                  assetId: asset.id,
                                  stationId: station.id,
                                  serialNumber: serialNumberText.text,
                                  serviceContractsId: componentContracts
                                      .map((e) => e.id)
                                      .toList())
                            ],
                            componentWarrantyId: warrantyContract.value?.id,
                            componentWarrantyUntil: componentWarrantyDate.value,
                            paidServiceUntil: prepaidWarrantyDate.value,
                          );

                          Get.back(result: true);
                        },
                        child: const Text("uložiť")),
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
      prepaidWarrantyDateText.text = value.toIso8601String().split("T").first;
    }
  }

  void setComponentWarranty(DateTime? value) {
    if (value == null) {
      componentWarrantyDate.value = null;
      componentWarrantyDateText.text = "";
    } else {
      componentWarrantyDate.value = value;
      componentWarrantyDateText.text = value.toIso8601String().split("T").first;
    }
  }
}
