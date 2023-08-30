import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/investment_contract_service.dart';
import 'package:open_cmms/widgets/forms/investment_contract/investment_contract_form.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/dialog_form.dart';
import '../widgets/main_menu_widget.dart';

class InvestmentContracts extends StatelessWidget {
  static const String ENDPOINT = '/investment_contracts';

  final Rxn<List<InvestmentContractSchema>> _contracts =
      Rxn<List<InvestmentContractSchema>>();

  InvestmentContracts({
    Key? key,
  }) : super(key: key) {
    reloadContracts();
  }

  reloadContracts() {
    var investmentContractService = InvestmentContractService();
    investmentContractService
        .getContractsInvestmentContractContractsGet(onlyActive: false)
        .then((contracts) {
      contracts?.sort((a, b) => a.validFrom.isBefore(b.validFrom) ? 1 : 0);
      _contracts.value = contracts;
    });
  }

  Widget buildContent() {
    return Obx(() {
      if (_contracts.value != null) {
        return buildContractsList();
      }
      return const CircularProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        pageText: Text("Investičné zmluvy"),
      ),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(child: buildContent())
        ],
      ),
    );
  }

  Column buildContractsList() {
    return Column(
      children: [
        Divider(),
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showFormDialog(InvestmentContractForm())
                    .then((value) => reloadContracts());
              },
              child: const Text("vytvorit novu zmluvu"),
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          addRepaintBoundaries: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: _contracts.value!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var contract = _contracts.value![index];
                            return Card(
                              child: ListTile(
                                title: Center(
                                    child: Text("Identifikátor: " +
                                        contract.identifier)),
                                subtitle: Center(
                                    child: Text(
                                        'platnost:    ${contract.validFrom.toString().substring(0, 10)}   -   ${contract.validUntil.toString().substring(0, 10)}, Dĺžka záruky v dňoch: ${contract.warrantyPeriodDays}')),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
