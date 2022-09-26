import 'dart:core';

import 'package:get/get.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/station.dart';

class StationsState extends GetxController {
  int _sequence = 0;
  //roadsegmentid <id, taskcomp>
  Map<String, Map<String, Station>> station =
      <String, Map<String, Station>>{}.obs;
  Map<String, String> stationRoadMap =
      <String, String>{}.obs;


  @override
  void onInit() {
    HelpStation.station0 =
        _createNewStation(HelpRoadSegment.D1, 'stanica 0', 'text' );
    HelpStation.station1 =
        _createNewStation(HelpRoadSegment.D1,'stanica 1', 'text' );
    super.onInit();
  }

  Station getByStationId(String stationId) {
    return station[stationRoadMap[stationId]]![stationId]!;
  }
  List<Station> getAllStations() {
    var list = <Station>[];
    station.forEach((key, value) {value.forEach((key, value) {list.add(value);});});
    return list;
  }

  String _createNewStation(roadsegmentId,[name = "name", text = "text"]) {
    var id = _getNewId();
    var item = new Station(id, roadsegmentId, name, text);
    if (!station.containsKey(item.roadSegmentId)) {
      station[item.roadSegmentId] = <String, Station>{}.obs;
      station[item.roadSegmentId]![id] = item;
      stationRoadMap[id] = item.roadSegmentId;
    } else {
      station[item.roadSegmentId]![id] = item;
      stationRoadMap[id] = item.roadSegmentId;
    }
    return id;
  }

  String _getNewId() {
    var id = _sequence.toString();
    _sequence++;
    return id;
  }
}
