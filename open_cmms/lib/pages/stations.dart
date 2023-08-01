import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/stations_list_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';
import '../widgets/stations_list.dart';

class Stations extends StatelessWidget {
  static const ENDPOINT = '/Stations';

  final StationsListState stationListState = Get.put(StationsListState());

  Stations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "Stanica",
                  textScaleFactor: 5,
                ),
                Row(
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
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    const Text("Zobraziť zmazané"),
                    GetX<StationsListState>(
                        builder: (_) => Checkbox(
                            value: _.getIncludeDeleted(),
                            onChanged: (v) {
                              if (v == null) return;
                              _.setIncludeDeleted(v);
                            })),
                    const Spacer(),
                  ],
                ),
                const Divider(),
                StationsList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
