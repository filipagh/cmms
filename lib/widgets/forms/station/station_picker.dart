import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/states/stations_state.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class StationPickerForm extends StatelessWidget implements hasFormTitle {
   final StationsState _stationsState = Get.find();


  StationPickerForm({Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    var stations = _stationsState.getAllStations();
    return Container(width: 800, height: 600,
      child: ListView.builder(itemCount: stations.length, itemBuilder: (BuildContext context, index) {
        return ListTile(title: Text(stations[index].name),onTap: () => pickStation(stations[index]));
      }),
    );
  }

  pickStation(Station station) {
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
