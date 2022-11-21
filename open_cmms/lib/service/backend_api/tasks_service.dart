
import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';




class TasksService extends TaskManagerApi {
  @override
  late final ApiClient apiClient;

  TasksService() {
    apiClient = getApiClient();
  }
}
