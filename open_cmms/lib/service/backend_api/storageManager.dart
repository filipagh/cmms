
import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'oauthUtil.dart';




class StorageManagerService extends StorageManagerApi {
  @override
  late final ApiClient apiClient;

  StorageManagerService() {
    apiClient = getApiClient();
  }
}
