import 'package:BackendAPI/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class StationPickerForm extends StatelessWidget implements hasFormTitle {
  final RxList<StationSchema> stations = <StationSchema>[].obs;

  StationPickerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadStations();
    return Container(
      width: 800,
      height: Get.height - 400,
      child: Obx(
        () => ListView.builder(
            itemCount: stations.length,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                  title: Text(stations[index].name),
                  onTap: () => pickStation(stations[index]));
            }),
      ),
    );
  }

  loadStations() {
    StationService().getAllStationStationsGet().then((value) {
      stations.clear();
      stations.addAll(value ?? []);
      stations.refresh();
    });
  }

  pickStation(StationSchema station) {
    Get.back(result: station);
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  String getTitle() {
    return "Pick Station";
  }
}
