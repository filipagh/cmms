import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class hasFormTitle {
  String getTitle();

  StatefulWidget getInstance();
}

void showFormDialog(hasFormTitle form) {
  Get.defaultDialog(
      title: form.getTitle(),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: Get.height-150, minWidth: 800),

        child: SingleChildScrollView(
          child: Column(
            children: [
              form.getInstance(),
            ],
          ),
        ),
      ),
      confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("submit")));
}
