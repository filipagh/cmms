import 'dart:async';
import 'dart:html' as html;

// web viewx ???

import 'package:get/get.dart';
import 'package:open_cmms/service/secrets_manager_service.dart';
import 'package:open_cmms/states/auth_state.dart';

hasToken() {
  final cookie = html.document.cookie!;
  if (cookie.isNotEmpty) {
    final entity = cookie.split("; ").map((item) {
      final split = item.split("=");
      return MapEntry(split[0], split[1]);
    });
    final cookieMap = Map.fromEntries(entity);

    if (cookieMap['user_session'] != null) {
      return true;
    }
  }
  return false;
}

login() {
  AuthState authState = Get.find();
  if (!authState.isAuthWindowOpen.value) {
    authState.isAuthWindowOpen.value = true;
    html.WindowBase _popup = html.window.open(getBackendUri() + "/auth/login",
        "login", 'left=100,top=100,width=800,height=600');
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      if (_popup.closed!) {
        timer.cancel();
        authState.isAuthWindowOpen.value = false;
        if (hasToken()) {
          authState.isAuthenticated.value = true;
          Get.toNamed("/");
        }
      }
    });
  }
}

logout() {
  AuthState authState = Get.find();
  if (!authState.isAuthWindowOpen.value) {
    authState.isAuthWindowOpen.value = true;
    html.WindowBase _popup = html.window.open(getBackendUri() + "/auth/logout",
        "logout", 'left=100,top=100,width=800,height=600');
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      // Stop the timer when it matches a condition
      if (_popup.closed!) {
        timer.cancel();
        authState.isAuthWindowOpen.value = false;
        if (!hasToken()) {
          authState.isAuthenticated.value = false;
          authState.isVerified.value = false;
          authState.isAdmin.value = false;
          Get.toNamed("/login");
        }
      }
    });
  }
}
