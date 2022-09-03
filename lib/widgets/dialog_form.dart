import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class hasFormTitle {
  String getTitle();

  Widget getInstance();

}

Future<T?> showFormDialog<T>(hasFormTitle form) async {
  return await Get.defaultDialog(

      title: form.getTitle(),

      content: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: Get.height-150,maxWidth: Get.width-200, minWidth: 800),

        child: SingleChildScrollView(
          child: Column(
            children: [
              form.getInstance(),
            ],
          ),
        ),
      ),
      // confirm: TextButton(
      //     onPressed: () {
      //
      //       form.submit() ? Get.back() : null;
      //
      //     },
      //     child: Text("submit"))
  );
}
