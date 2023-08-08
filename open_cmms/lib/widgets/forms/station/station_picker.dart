import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../states/stations_list_state.dart';

class StationPickerForm extends StatelessWidget implements hasFormTitle {
  final StationsListState stationListState = Get.put(StationsListState());

  StationPickerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: Get.height - 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty || value.length < 3)
                  stationListState.search(null);
                else
                  stationListState.search(value);
              },
              decoration: InputDecoration(
                hintText: "Hľadať",
              ),
            ),
          ),
          GetX<StationsListState>(
            builder: (state) {
              var list = state.getStations();
              return Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                          title: Center(child: Text(list[index].name)),
                          onTap: () => pickStation(list[index]));
                    }),
              );
            },
          ),
        ],
      ),
    );
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
    return "Vybrať stanicu";
  }
}
