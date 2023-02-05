import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/service/backend_api/assetManager.dart';

class AssetTelemetryState extends GetxController {
  Rx<TelemetryOptions> options = Rx<TelemetryOptions>(TelemetryOptions());

  @override
  void onInit() {
    reloadData();
    super.onInit();
  }

  void reloadData() {
    AssetManagerService()
        .getTelemetryOptionsAssetManagerTelemetryOptionsGet()
        .then((value) {
      if (value != null) {
        options.value = value;
        options.refresh();
      }
    });
  }
}
