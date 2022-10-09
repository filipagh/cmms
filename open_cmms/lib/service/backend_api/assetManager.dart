
import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'oauthUtil.dart';




class AssetManagerService extends AssetManagerApi {
  @override
  late final ApiClient apiClient;

  AssetManagerService() {
    apiClient = getApiClient();
  }
}
