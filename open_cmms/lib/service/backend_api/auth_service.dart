import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';

class AuthService extends AuthApi {
  @override
  late final ApiClient apiClient;

  AuthService() {
    apiClient = getApiClient();
  }
}
