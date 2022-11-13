import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';

class AssignedComponentService extends AssignedComponentsApi {
  @override
  late final ApiClient apiClient;

  AssignedComponentService() {
    apiClient = getApiClient();
  }
}
