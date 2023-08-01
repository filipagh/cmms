import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showError(String message) {
  Get.dialog(
    AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}

Future<bool> showAlert(String message) async {
  return await Get.dialog(
    AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          child: const Text("Nie"),
          onPressed: () => Get.back(result: false),
        ),
        TextButton(
          child: const Text("Áno"),
          onPressed: () => Get.back(result: true),
        ),
      ],
    ),
  );
}

void showInfo(String message) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      message,
    ),
    backgroundColor: Colors.yellow[200]!,
    duration: const Duration(seconds: 3),
  ));
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
