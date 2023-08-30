import 'package:BackendAPI/api.dart';

import 'oauthUtil.dart';

class InvestmentContractService extends InvestmentContractApi {
  @override
  late final ApiClient apiClient;

  InvestmentContractService() {
    apiClient = getApiClient();
  }
}
