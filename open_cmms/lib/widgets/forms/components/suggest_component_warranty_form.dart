import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/components/set_new_component_warranty_form.dart';

import '../../../service/backend_api/investment_contract_service.dart';
import '../util/contract_types_localization.dart';

class SuggestComponentWarrantyForm extends StatelessWidget
    implements PopupForm {
  SuggestComponentWarrantyForm({Key? key, required this.suggestedWarranty})
      : super(key: key) {
    suggestedWarranty.componentWarrantyId != null
        ? InvestmentContractService()
            .getContractInvestmentContractContractGet(
                suggestedWarranty.componentWarrantyId!)
            .then((value) => warrantyContract.value = value)
        : null;
  }

  Rxn<InvestmentContractSchema> warrantyContract =
      Rxn<InvestmentContractSchema>();
  ComponentWarranty suggestedWarranty;

  String getTitle() {
    return "Navrhovaná záruka pre komponent";
  }

  @override
  Widget getContent() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Typ zaruky: " +
                  localize(suggestedWarranty.componentWarrantySource)),
              Obx(() => Text(
                  "Zmluva: ${warrantyContract.value?.identifier ?? "žiadna"}")),
              Divider(),
              Text(suggestedWarranty.componentWarrantyUntil == null
                  ? "Dlzka zaruky po instalacii: " +
                      suggestedWarranty.componentWarrantyDays.toString()
                  : "Záruka komponentu do: " +
                      suggestedWarranty.componentWarrantyUntil
                          .toString()
                          .substring(0, 10)),
              Text(suggestedWarranty.componentWarrantyUntil == null
                  ? "Dlzka predplateneho servisu po instalacii: " +
                      suggestedWarranty.componentPrepaidServiceDays.toString()
                  : "Záruka predplateneho servisu do: " +
                      suggestedWarranty.componentPrepaidServiceUntil
                          .toString()
                          .substring(0, 10)),
              ElevatedButton(
                  onPressed: () async {
                    await showFormDialog(SetNewComponentWarrantyForm())
                        .then((value) {
                      if (value != null) {
                        Get.back(result: value);
                      }
                    });
                  },
                  child: Text("Zvolit vlastnu zaruku")),
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
                        Get.back(result: suggestedWarranty);
                      },
                      child: const Text("zvolť odporucanu zaruku")),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
