import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';

class AssignedComponentsState extends GetxController {
  final List<AssignedComponentSchema> components = <AssignedComponentSchema>[];
  late final String _stationId;

  AssignedComponentsState(this._stationId);

  @override
  void onInit() {
    print("put componets");
    AssignedComponentService()
        .getAllAssignedComponentsComponentsGet(_stationId)
        .then((value) => components.addAll(value ?? []));
    update();
    super.onInit();
  }
}
