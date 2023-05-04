import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/service_contracts/service_contract_form.dart';

import '../../service/backend_api/station_service.dart';
import '../../snacbars.dart';

class StationInfoPage extends StatelessWidget
    implements StationBaseContextPage {
  static const String ENDPOINT = '/Info';
  final StationSchema station;

  RxList<ServiceContractSchema> contracts = <ServiceContractSchema>[].obs;

  StationInfoPage({Key? key, required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadServiceContracts();
    return Column(
      children: [
        if (station.isActive == true) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    StationService()
                        .removeStationStationRemoveStationDelete(
                            StationIdSchema(id: station.id))
                        .then((value) {
                      Get.toNamed(StationBasePage.ENDPOINT +
                          "/${station.id}" +
                          StationInfoPage.ENDPOINT);
                      showOk("Stania bola vymazana");
                    }, onError: (e) => showError(e.toString()));
                  },
                  child: Text("Vymazať stanicu")),
            ],
          ),
          Divider(),
        ],
        SelectionArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Meno stanice"),
                  Text("Km cestneho useku"),
                  Text("Km cestneho useku poznamka"),
                  Text("Gps - dlzka"),
                  Text("Gps - sirka"),
                  Text("nadmorska vyska"),
                  Text("poznamka"),
                  Text("ID"),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(station.name),
                  Text(station.kmOfRoad?.toString() ?? ""),
                  Text(station.kmOfRoadNote),
                  Text(station.longitude?.toString() ?? "-"),
                  Text(station.latitude?.toString() ?? '-'),
                  Text(station.seeLevel?.toString() ?? '-'),
                  Text(station.description),
                  Text(station.id),
                ],
              )
            ],
          ),
        ),
        Divider(),
        Obx(() {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
            child: Column(
              children: [
                Text("Servisne zmluvy"),
                Expanded(
                  child: ListView.builder(
                      itemCount: contracts.length,
                      itemBuilder: (context, index) {
                        var contract = contracts[index];
                        return ListTile(
                            onTap: () => showFormDialog(
                                ServiceContractForm(contract: contract)),
                            title: Center(child: Text(contract.name)),
                            subtitle: Center(
                              child: Text(contract.validFrom
                                      .toString()
                                      .substring(0, 10) +
                                  " - " +
                                  contract.validUntil
                                      .toString()
                                      .substring(0, 10)),
                            ));
                      }),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void loadServiceContracts() async {
    ServiceContractService()
        .getServiceContractContractForStationGet(station.id)
        .then((value) {
      value?.sort((a, b) => a.validFrom.isBefore(b.validFrom) ? 1 : 0);
      contracts.addAll(value ?? []);
    });
  }
}
