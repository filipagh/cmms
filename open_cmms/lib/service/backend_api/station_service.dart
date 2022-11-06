
import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'oauthUtil.dart';




class StationService extends StationManagerApi {
  @override
  late final ApiClient apiClient;

  StationService() {
    apiClient = getApiClient();
  }
}
