
import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'oauthUtil.dart';




class BackEndService extends DefaultApi {
  @override
  late final ApiClient apiClient;

  BackEndService() {
    apiClient = getApiClient();
  }
}
