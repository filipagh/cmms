import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class ServiceContracts extends StatelessWidget {
  final List<ServiceContractSchema> _contracts = <ServiceContractSchema>[].obs;
  bool loaded = false;

  ServiceContracts({
    Key? key,
  }) : super(key: key) {
    reloadContracts();
  }

  reloadContracts() {
    ServiceContractService()
        .getContractsServiceContractContractsGet()
        .then((contracts) {
      loaded = true;
      _contracts.clear();
      _contracts.addAll(contracts!);
    });
  }

  Widget buildContent() {
    if (loaded) {
      return buildContractsList();
    }
    return CircularProgressIndicator();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
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
          children: [
            Text(
              "Servicne zmluvy",
              textScaleFactor: 5,
            ),
            IconButton(
                onPressed: () {
                  reloadContracts();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        Divider(),
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
                                  // Get.toNamed(StationBasePage.ENDPOINT+"/${list[index].id}");
                                },
                                hoverColor: Colors.blue.shade200,
                                title:
                                    Center(child: Text(_contracts[index].name)),
                                subtitle: Center(
                                    child: Text(
                                        'platnost: ${_contracts[index].validFrom.toString()} ${_contracts[index].validUntil.toString()}')),
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
