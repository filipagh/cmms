import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/assigned_components_service.dart';

class AssignedComponentsState extends GetxController {
  final List<AssignedComponentSchema> components = <AssignedComponentSchema>[];
  late final String _stationId;

  AssignedComponentsState(this._stationId);

  @override
  void onInit() {
    super.onInit();
  }

  AssignedComponentSchema? getById(String assigned_component_id) {
    return components
        .firstWhereOrNull((element) => element.id == assigned_component_id);
  }

  Future<AssignedComponentsState> load() async {
    var v = await AssignedComponentService()
        .getAllAssignedComponentsComponentsGet(stationId: _stationId);

    components.clear();
    components.addAll(v ?? []);
    refresh();
    update();
    return this;
  }
}
