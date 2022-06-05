import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showdialog() {
  Get.defaultDialog(
    title: "add ...",
      content: Container(
        width: 800,
        child: Column(
          children: [Text("form"), Placeholder()],
        ),
      ),
      confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("submit")));
}
