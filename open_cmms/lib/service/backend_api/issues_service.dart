import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';

class IssuesService extends IssuesApi {
  @override
  late final ApiClient apiClient;

  IssuesService() {
    apiClient = getApiClient();
  }
}
