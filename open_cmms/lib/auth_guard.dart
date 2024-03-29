import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/main.dart';
import 'package:open_cmms/pages/forbidden.dart';
import 'package:open_cmms/pages/login.dart';
import 'package:open_cmms/pages/unverified.dart';
import 'package:open_cmms/service/backend_api/auth_service.dart';
import 'package:open_cmms/states/auth_state.dart';

class AuthGuard extends GetMiddleware {
  final authService = Get.find<AuthState>();

  @override
  RouteSettings? redirect(String? route) {
    if (authService.isAuthenticated.isFalse)
      return const RouteSettings(name: Login.ENDPOINT);
    if (authService.isVerified.isFalse) {
      AuthService().getMeAuthMeGet().then((value) {
        if (value?.isVerified == true) {
          authService.isVerified.value = true;
          if (value?.isAdmin == true) {
            authService.isAdmin.value = true;
          }
          loadPostLoginStates();
          Get.toNamed(route ?? "/");
        }
      }, onError: (e) {
        Get.toNamed(Unverified.ENDPOINT);
      });
      return const RouteSettings(name: Login.ENDPOINT);
    }

    return null;
  }
}

class AdminGuard extends GetMiddleware {
  final authService = Get.find<AuthState>();

  @override
  RouteSettings? redirect(String? route) {
    if (authService.isAdmin.isFalse) {
      return const RouteSettings(name: Forbidden.ENDPOINT);
    }
    return null;
  }
}
