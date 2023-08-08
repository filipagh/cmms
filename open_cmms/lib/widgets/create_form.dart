import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showdialog() {
  Get.defaultDialog(
      title: "pridať ...",
      content: Container(
        width: 800,
        child: Column(
          // children: [Text("form"), Placeholder()],
          children: [Text("formulár")],
        ),
      ),
      confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("uložiť")));
}
