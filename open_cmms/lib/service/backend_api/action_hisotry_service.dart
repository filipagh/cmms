
import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';




class ActionHistoryService extends ActionHistoryApi {
  @override
  late final ApiClient apiClient;

  ActionHistoryService() {
    apiClient = getApiClient();
  }
}
