import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/service/backend_api/service_contract_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/service_contracts/service_contract_form.dart';

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
        SelectableText("Meno stanice: " + station.name),
        SelectableText(
            "Km cestneho useku: " + (station.kmOfRoad?.toString() ?? "")),
        SelectableText("Km cestneho useku poznamka: " + station.kmOfRoadNote),
        SelectableText(
            "Gps - dlzka: " + (station.longitude?.toString() ?? "-")),
        SelectableText("Gps - sirka: " + (station.latitude?.toString() ?? '-')),
        SelectableText(
            "nadmorska vyska: " + (station.seeLevel?.toString() ?? '-')),
        SelectableText("poznamka: " + station.description),
        SelectableText("ID: " + station.id),
        Obx(() {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400, maxWidth: 400),
            child: Column(
              children: [
                Divider(
                  thickness: 3,
                ),
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
