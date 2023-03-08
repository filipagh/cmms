import 'dart:html';

import 'package:BackendAPI/api.dart';

import '../secrets_manager_service.dart';

ApiClient getApiClient() {
  // if (isAuthSet) {
  //   AuthState _authState = Get.find();
  //
  //   var token = _authState.token?.value;
  //
  //   if (token != null) {
  OAuth? oAuth = null;
  final cookie = document.cookie!;
  if (!cookie.isEmpty) {
    final entity = cookie.split("; ").map((item) {
      final split = item.split("=");
      return MapEntry(split[0], split[1]);
    });
    final cookieMap = Map.fromEntries(entity);

    if (cookieMap['user_session'] != null) {
      oAuth = OAuth(accessToken: cookieMap['user_session']!);
      // apiKeyAuth.apiKey = cookieMap['user_session']!;
    }
  }
  // ApiClient(
  //    basePath: getBackendUri(), authentication: ApiKeyAuth("cookie",));
  //   } else {
  //     return ApiClient(basePath: getBackendUri());
  //   }
  // }
  return ApiClient(basePath: getBackendUri(), authentication: oAuth);
}
