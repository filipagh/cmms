import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/service/backend_api/station_service.dart';

class StationState extends GetxController {
  StationSchema? station;
  late String _station_id_to_load;

  StationState(this._station_id_to_load);

  @override
  void onInit() {
    print("load");
    StationService()
        .getByIdStationStationGet(_station_id_to_load)
        .then((value) => station = value);
    super.onInit();
  }
}
