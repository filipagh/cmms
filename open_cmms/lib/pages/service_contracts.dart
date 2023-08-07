import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/widgets/forms/service_contracts/service_contract_form.dart';
import 'package:open_cmms/widgets/forms/service_contracts/stations_missing_service_contract_form.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/dialog_form.dart';
import '../widgets/main_menu_widget.dart';

class ServiceContracts extends StatelessWidget {
  static const String ENDPOINT = '/service_contracts';

  final List<ServiceContractSchema> _contracts = <ServiceContractSchema>[].obs;
  final List<StationIdSchema> _stationsIdsWithoutContracts =
      <StationIdSchema>[].obs;
  final RxBool loaded = false.obs;
  final RxnString _query = RxnString();

  ServiceContracts({
    Key? key,
  }) : super(key: key) {
    reloadContracts();
  }

  reloadContracts() {
    var serviceContractService = ServiceContractService();
    if (_query.value != null) {
      serviceContractService
          .searchServiceContractContractsSearchGet(_query.value!)
          .then((contracts) {
        contracts?.sort((a, b) => a.validFrom.isBefore(b.validFrom) ? 1 : 0);
        loaded.value = true;
        _contracts.clear();
        _contracts.addAll(contracts!);
      });
    } else {
      serviceContractService
          .getContractsServiceContractContractsGet()
          .then((contracts) {
        contracts?.sort((a, b) => a.validFrom.isBefore(b.validFrom) ? 1 : 0);
        loaded.value = true;
        _contracts.clear();
        _contracts.addAll(contracts!);
      });
    }
    serviceContractService
        .getStationsWithoutContractServiceContractStationsWithoutContractGet()
        .then((value) {
      _stationsIdsWithoutContracts.clear();
      _stationsIdsWithoutContracts.addAll(value!);
    });
  }

  Widget buildContent() {
    if (loaded.value) {
      return buildContractsList();
    }
    return const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Obx(() {
              return buildContent();
            }),
          )
        ],
      ),
    );
  }

  Column buildContractsList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Servisne zmluvy",
              textScaleFactor: 5,
            ),
            IconButton(
                onPressed: () {
                  reloadContracts();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        const Divider(),
        Row(
          children: [
            Container(
              width: 200,
              child: TextField(
                onChanged: (v) {
                  if (v.length >= 3) {
                    _query.value = v;
                    reloadContracts();
                  }
                  if (v.length < 3 && _query.value != null) {
                    _query.value = null;
                    reloadContracts();
                  }
                },
                decoration: InputDecoration(
                  hintText: "Hľadať",
                ),
              ),
            ),
            // const Placeholder(
            //   child: SizedBox(width: 300, child: Text("searchbar")),
            // ),
            // const Placeholder(
            //   child: Icon(Icons.filter_list_alt),
            // ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showFormDialog(StationsMissingServiceContractForm(
                    station_list: _stationsIdsWithoutContracts.toList()));
              },
              child: const Text("zobraziť stanice bez zmluvy"),
            ),
            ElevatedButton(
              onPressed: () {
                showFormDialog(ServiceContractForm(
                  isNew: true,
                  stationsWithoutContract: _stationsIdsWithoutContracts,
                )).then((value) => reloadContracts());
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
                          itemCount: _contracts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  showFormDialog(ServiceContractForm(
                                    contract: _contracts[index],
                                    stationsWithoutContract:
                                        _stationsIdsWithoutContracts,
                                  ));
                                },
                                trailing: ElevatedButton.icon(
                                    onPressed: () {
                                      showFormDialog(ServiceContractForm(
                                        contract: _contracts[index],
                                        isNew: true,
                                        stationsWithoutContract:
                                            _stationsIdsWithoutContracts,
                                      )).then((value) => reloadContracts());
                                    },
                                    icon: Icon(Icons.copy),
                                    label: Text("kópia")),
                                hoverColor: Colors.blue.shade200,
                                title:
                                    Center(child: Text(_contracts[index].name)),
                                subtitle: Center(
                                    child: Text(
                                        'platnost:    ${_contracts[index].validFrom.toString().substring(0, 10)}   -   ${_contracts[index].validUntil.toString().substring(0, 10)}')),
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
