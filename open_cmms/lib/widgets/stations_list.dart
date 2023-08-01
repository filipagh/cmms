import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/states/stations_list_state.dart';

class StationsList extends StatelessWidget {
  StationsList({
    Key? key,
  }) : super(key: key) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _state.loadMore();
      }
    });
  }

  final StationsListState _state = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetX<StationsListState>(builder: (StationsListState state) {
      var list = state.getStations();
      return list.isEmpty
          ? Expanded(
              child: Center(
                  child: Text(
              "Žiadna stanica",
              textScaleFactor: 3,
            )))
          : Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  addRepaintBoundaries: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return getStationCard(list[index]);
                  }),
            );
    });
  }
}

Card getStationCard(StationSchema station) {
  return Card(
    child: ListTile(
      onTap: () {
        Get.toNamed(StationBasePage.ENDPOINT + "/${station.id}");
      },
      hoverColor: Colors.blue.shade200,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Stanica: ${station.name}'),
          if (station.isActive != true) ...[
            Tooltip(
                message: 'stanica je zmazaná',
                child: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.red,
                ))
          ],
        ],
      ),
      subtitle: Center(child: Text('Stanica Id: ${station.id}')),
    ),
  );
}
