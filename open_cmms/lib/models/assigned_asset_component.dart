import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/states/asset_types_state.dart';

class AssignedAssetComponent {
  late final AssetSchema asset;
  final AssignedComponentSchema assignedComponent;

  AssignedAssetComponent(this.assignedComponent) {
    AssetTypesState assets = Get.find();
    asset = assets.getAssetById(assignedComponent.assetId)!;
  }
}
