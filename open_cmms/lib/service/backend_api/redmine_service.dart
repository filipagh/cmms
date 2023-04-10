import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';

class RedmineService extends RedmineApi {
  @override
  late final ApiClient apiClient;

  RedmineService() {
    apiClient = getApiClient();
  }
}
