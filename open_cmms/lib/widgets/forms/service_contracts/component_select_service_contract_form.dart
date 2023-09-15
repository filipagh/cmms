import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class ComponentsSelectServiceContractForm extends StatefulWidget
    implements PopupForm {
  ComponentsSelectServiceContractForm(
      {Key? key,
      required List<String> selectedContractsId,
      this.onlyActive = true})
      : super(key: key) {
    selectedContractsIds.value = selectedContractsId;

    ServiceContractService()
        .getContractsServiceContractContractsGet()
        .then((value) => contracts.value = value ?? []);
  }

  final RxList<ServiceContractSchema> contracts = <ServiceContractSchema>[].obs;
  final RxList<String> selectedContractsIds = <String>[].obs;
  late final bool onlyActive;

  @override
  State<ComponentsSelectServiceContractForm> createState() =>
      _ComponentsSelectServiceContractFormState();

  @override
  String getTitle() {
    return "Zvoľte servisne zmluvy";
  }

  @override
  Widget getContent() {
    return this;
  }
}

class _ComponentsSelectServiceContractFormState
    extends State<ComponentsSelectServiceContractForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 600,
              height: Get.height - 300,
              child: Obx(
                () => ListView.builder(
                  itemCount: widget.contracts.length,
                  itemBuilder: (context, index) {
                    var contract = widget.contracts[index];
                    return ListTile(
                        title: Text('Kontrakt: ' + contract.name),
                        subtitle: Text('Platne od: ' +
                            contract.validFrom.toString() +
                            ' do: ' +
                            contract.validUntil.toString()),
                        leading: Obx(
                          () => Checkbox(
                            value: widget.selectedContractsIds.value
                                .contains(contract.id),
                            onChanged: (value) {
                              if (value == true) {
                                widget.selectedContractsIds.add(contract.id);
                              } else {
                                widget.selectedContractsIds.remove(contract.id);
                              }
                            },
                          ),
                        ));
                  },
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Zrusit")),
              ElevatedButton(
                  onPressed: () {
                    Get.back(
                        result: widget.contracts
                            .where((selectedContract) => widget
                                .selectedContractsIds
                                .contains(selectedContract.id))
                            .toList());
                  },
                  child: const Text("Zvoliť zmluvy"))
            ],
          )
        ],
      ),
    );
  }
}
