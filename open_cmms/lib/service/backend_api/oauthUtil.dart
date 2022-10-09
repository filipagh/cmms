import 'package:BackendAPI/api.dart';
import '../secrets_manager_service.dart';

ApiClient getApiClient() {
  // if (isAuthSet) {
  //   AuthState _authState = Get.find();
  //
  //   var token = _authState.token?.value;
  //
  //   if (token != null) {
  //     return ApiClient(
  //         basePath: getBackendUri(), authentication: OAuth(accessToken: token.accessToken));
  //   } else {
  //     return ApiClient(basePath: getBackendUri());
  //   }
  // }
  return ApiClient(basePath: getBackendUri());
}
