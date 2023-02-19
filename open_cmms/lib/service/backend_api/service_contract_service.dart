import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';

class ServiceContractService extends ServiceContractApi {
  @override
  late final ApiClient apiClient;

  ServiceContractService() {
    apiClient = getApiClient();
  }
}
