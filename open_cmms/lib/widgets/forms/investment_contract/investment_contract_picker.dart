import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/investment_contract_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class InvestmentContractPicker extends StatelessWidget implements hasFormTitle {
  final bool onlyActive;
  Rxn<List<InvestmentContractSchema>> contracts =
      Rxn<List<InvestmentContractSchema>>();

  InvestmentContractPicker({Key? key, this.onlyActive = true})
      : super(key: key) {
    InvestmentContractService()
        .getContractsInvestmentContractContractsGet(onlyActive: false)
        .then((value) => contracts.value = value);
  }

  @override
  String getTitle() {
    return "Vybrať investičnú zmluvu";
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 500,
          height: Get.height - 300,
          child: Obx(() {
            if (contracts.value == null) {
              return Text("nacitanie");
            } else if (contracts.value!.isEmpty) {
              return Text("Žiadne zmluvy");
            } else {
              return ListView.builder(
                itemCount: contracts.value!.length,
                itemBuilder: (BuildContext context, int index) {
                  var contract = contracts.value![index];
                  return Card(
                    child: ListTile(
                      onTap: () => Get.back(result: contract),
                      title: Center(child: Text(contract.identifier)),
                      subtitle: Center(
                          child: Text(
                              "platnost ${contract.validFrom} - ${contract.validUntil}")),
                    ),
                  );
                },
              );
            }
          }),
        )
      ],
    );
  }
}
