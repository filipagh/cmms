import 'package:BackendAPI/api.dart';

import '../oauthUtil.dart';

class TasksOnSiteService extends TaskServiceOnSiteApi {
  @override
  late final ApiClient apiClient;

  TasksOnSiteService() {
    apiClient = getApiClient();
  }
}
