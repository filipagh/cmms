import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class PopupForm {
  String getTitle();

  Widget getContent();
}

abstract class FormWithLoadingIndicator extends PopupForm {
  late final RxBool isProcessing;
}

Future<T?> showFormDialog<T>(PopupForm form) async {
  return await Get.defaultDialog(
    title: form.getTitle(),
    content: IntrinsicHeight(
        child: ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: Get.height - 50, maxWidth: Get.width - 200, minWidth: 500),
      child: form is FormWithLoadingIndicator
          ? Obx(() {
              if (form.isProcessing.value) {
                return CircularProgressIndicator();
              } else {
                return form.getContent();
              }
            })
          : form.getContent(),
    )),
  );
}
