import 'dart:core';

import 'package:get/get.dart';
import 'package:open_cmms/auth.dart';

class AuthState extends GetxController {
  RxBool isAuthenticated = false.obs;
  RxBool isAuthWindowOpen = false.obs;

  @override
  void onInit() {
    isAuthenticated.value = hasToken();
    super.onInit();
  }
}
