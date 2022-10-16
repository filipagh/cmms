import 'package:get/get.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/assigned_component.dart';
import 'package:open_cmms/states/items_state_dummy.dart';

class AssignedComponentState extends GetxController {
  int _stationSequence = 0;
  ItemsState_dummy _itemsState = Get.find();

  // <stationId<AssignedComponentId, AssignedComponent>>
  Map<String, Map<String, AssignedComponent>> components =
      <String, Map<String, AssignedComponent>>{}.obs;

  @override
  void onInit() {
    HelpAssignedcomponent.stat0rosa = _initAssignedComponent(
        HelpStation.station0,
        HelpProduct.productROSAID,
        DateTime.now().subtract(Duration(days: 10)),
        AssignedComponentStateEnum.installed); // instaled
    HelpAssignedcomponent.stat0tepanalog = _initAssignedComponent(
        HelpStation.station0,
        HelpProduct.productTEPLOANALOGID,
        DateTime.now().subtract(Duration(days: 10)),
        AssignedComponentStateEnum.willBeRemoved); //instaled tobeuninstaled
    HelpAssignedcomponent.stat0tepdialog = _initAssignedComponent(HelpStation.station0, HelpProduct.productTEPLODIGIID,
        DateTime.now(), AssignedComponentStateEnum.awaiting); // awaiting
    super.onInit();
  }

  String _getNewId() {
    var id = _stationSequence.toString();
    _stationSequence++;
    return id;
  }

  List<AssignedComponent> getInstalledComponentsByStationId(String stationId) {
    var list = <AssignedComponent>[];
    components[stationId]?.values.forEach((element) {
      if (element.actualState != AssignedComponentStateEnum.removed) {
        list.add(element);
      }
    });
    return list;
  }

  void editType(
    stationId,
    assignedComponentId,
    productId,
  ) {
    var i = components[stationId]![assignedComponentId];
    i!.productId = productId;
    components[stationId]![assignedComponentId] = i;
    update([components[stationId]![assignedComponentId]!]);
  }

  void _addItem(AssignedComponent item) {
    if (!components.containsKey(item.stationId)) {
      components[item.stationId] = <String, AssignedComponent>{}.obs;
      components[item.stationId]![item.assignedComponentId] = item;
    } else {
      components[item.stationId]![item.assignedComponentId] = item;
    }

    // if (_isProductInState(item.productId)) {
    //   printError(info: "product duplicity insert to items");
    //   return;
    // }
    // _items.add(item);
  }

  String _initAssignedComponent(String stationId, productId, DateTime installed,
      AssignedComponentStateEnum state,
      [DateTime? removed]) {
    var id = _getNewId();
    _addItem(AssignedComponent(
        id, productId, stationId, DateTime.now(), installed, removed, state));

    switch  (state) {
      case AssignedComponentStateEnum.awaiting:
        _itemsState.addAllocatedComponent(productId);
        break;
      case AssignedComponentStateEnum.installed:
        _itemsState.addUsedComponent(productId);
        break;
      case AssignedComponentStateEnum.willBeRemoved:
        _itemsState.addUsedComponent(productId);
        break;
      case AssignedComponentStateEnum.removed:
        break;
    }
    return id;
  }

  void addAlreadyInstalledComponent(String stationId, productId,
      DateTime installed, AssignedComponentStateEnum state,
      [DateTime? removed]) {
    var id = _getNewId();
    _addItem(AssignedComponent(
        id, productId, stationId, DateTime.now(), installed, removed, state));

    _itemsState.addUsedComponent(productId);
  }

}
