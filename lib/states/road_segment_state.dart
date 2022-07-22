import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/road_segment_model.dart';

class RoadSegmentState extends GetxController {
  Map<String, RoadSegmentModel> segments = <String, RoadSegmentModel>{}.obs;
  int _sequence = 0;

  @override
  void onInit() {
    HelpRoadSegment.D1 = createNewRoadSegment('D1', '', 'ssud');
    HelpRoadSegment.D4 = createNewRoadSegment('D4', '', 'ssud');
    super.onInit();
  }

  String createNewRoadSegment(name, text, ssud) {
    var id = _sequence.toString();
    var item = RoadSegmentModel(id, name, text, ssud);

    segments[id] = item;

    _sequence++;
    return id;
  }
}
