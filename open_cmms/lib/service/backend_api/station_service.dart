
import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'oauthUtil.dart';




class StationService extends StationApi {
  @override
  late final ApiClient apiClient;

  StationService() {
    apiClient = getApiClient();
  }
}
