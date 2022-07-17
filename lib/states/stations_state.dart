import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/models/station.dart';

class StationsState extends GetxController {
  Map<String, Station> station = <String, Station>{}.obs;
  int stationSequence = 0;

  @override
  void onInit() {
    stationSequence = 0;
    createNewStation('stanica 0', 'text');
    createNewStation('stanica 1', 'text');
    super.onInit();
  }

  String createNewStation([name = "name", text = "text"]) {
    var id = stationSequence.toString();
    var item = new Station(id, name, text);

    station[id] = item;

    stationSequence++;
    return id;
  }
}
