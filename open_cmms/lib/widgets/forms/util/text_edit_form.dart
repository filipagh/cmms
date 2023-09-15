import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class TextEditForm extends StatelessWidget implements PopupForm {
  final String title;
  final String text;

  const TextEditForm({Key? key, required this.title, this.text = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    myController.text = text;
    return Column(
      children: [
        TextField(
          controller: myController,
          minLines: 6,
          // any number you need (It works as the rows for the textarea)
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Zrusit")),
            ElevatedButton(
                onPressed: () {
                  Get.back(result: myController.value.text);
                },
                child: const Text("Zmenit")),
          ],
        ),
      ],
    );
  }

  @override
  Widget getContent() {
    return this;
  }

  @override
  String getTitle() {
    return title;
  }
}
