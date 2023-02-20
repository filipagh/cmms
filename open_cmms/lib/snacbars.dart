import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showError(String message) {
  Get.dialog(
    AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          child: const Text("spat"),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

void showOk(String message) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      message,
    ),
    backgroundColor: Colors.green[200]!,
    duration: const Duration(seconds: 3),
  ));
}
