import 'package:BackendAPI/api.dart';

import '../oauthUtil.dart';

class TasksRemoteService extends TaskServiceRemoteApi {
  @override
  late final ApiClient apiClient;

  TasksRemoteService() {
    apiClient = getApiClient();
  }
}
