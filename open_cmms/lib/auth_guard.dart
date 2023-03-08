import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/login.dart';
import 'package:open_cmms/states/auth_state.dart';

class AuthGuard extends GetMiddleware {
  final authService = Get.find<AuthState>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.isAuthenticated.isTrue
        ? null
        : const RouteSettings(name: Login.ENDPOINT);
  }
}
