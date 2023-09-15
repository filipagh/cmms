import 'package:BackendAPI/api.dart' as schema;
import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/snacbars.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/service_contracts/component_select_service_contract_form.dart';
import 'package:open_cmms/widgets/forms/util/contract_types_localization.dart';
import 'package:open_cmms/widgets/forms/util/date_utils.dart';

import '../../../service/backend_api/investment_contract_service.dart';
import '../../../states/asset_types_state.dart';
import '../investment_contract/investment_contract_picker.dart';

class SetComponentWarrantyForm extends StatelessWidget
    implements FormWithLoadingIndicator {
  final schema.AssignedComponentSchema component;
  final AssetTypesState _assetTypes = Get.find();
  late AssetSchema asset = _assetTypes.getAssetById(component.assetId)!;

  SetComponentWarrantyForm({Key? key, required this.component})
      : super(key: key) {
    if (component.componentWarrantyId != null) {
      InvestmentContractService()
          .getContractInvestmentContractContractGet(
              component.componentWarrantyId!)
          .then((value) {
        warrantyContract.value = value;
      });
    }
    setComponentWarranty(component.componentWarrantyUntil);
    setPrepaidWarranty(component.prepaidServiceUntil);
    ServiceContractService()
        .getServiceContractContractsForComponentGet(component.id)
        .then((value) {
      componentContracts.value = value ?? [];
      componentContractsText.text =
          componentContracts.value.map((e) => e.name).join(",");
    });
  }

  String getTitle() {
    return "Zmena zaruk komponentu ${asset.name} s seriovim cislom ${component.serialNumber}";
  }

  @override
  RxBool isProcessing = false.obs;

  @override
  Widget getContent() {
    return this;
  }

  final sourceOptions = ComponentWarrantySource.values
      .map((e) => DropdownMenuItem<ComponentWarrantySource>(
            value: e,
            child: Text(localize(e)),
          ))
      .toList();

  late Rx<ComponentWarrantySource> warrantySource = sourceOptions
      .firstWhere(
          (element) => element.value == component.componentWarrantySource)
      .value!
      .obs;
  Rxn<InvestmentContractSchema> warrantyContract =
      Rxn<InvestmentContractSchema>();
  Rxn<DateTime> componentWarrantyDate = Rxn<DateTime>();
  TextEditingController componentWarrantyDateText = TextEditingController();
  Rxn<DateTime> prepaidWarrantyDate = Rxn<DateTime>();
  TextEditingController prepaidWarrantyDateText = TextEditingController();
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
                              .overrideWarrantyAssignedComponentsOverrideWarrantyPost(
                                  component.id, warrantySource.value,
                                  componentWarrantyId:
                                      warrantyContract.value?.id,
                                  componentWarrantyUntil: convertDatetimeToUtc(
                                      componentWarrantyDate.value),
                                  paidServiceUntil: convertDatetimeToUtc(
                                      prepaidWarrantyDate.value),
                                  serviceContractsId: componentContracts.value
                                      .map((e) => e.id)
                                      .toList())
                              .then((value) => Get.back(result: true));
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
