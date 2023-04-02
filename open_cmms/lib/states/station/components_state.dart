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
    reload();
    super.onInit();
  }

  AssignedComponentSchema? getById(String assigned_component_id) {
    return components
        .firstWhereOrNull((element) => element.id == assigned_component_id);
  }

  reload() {
    AssignedComponentService()
        .getAllAssignedComponentsComponentsGet(stationId: _stationId)
        .then((value) {
      components.clear();
      components.addAll(value ?? []);
      refresh();
      update();
    });
  }
}
