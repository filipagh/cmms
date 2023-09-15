import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/auth_state.dart';
import '../widgets/custom_app_bar.dart';

class Forbidden extends StatelessWidget {
  Forbidden({
    Key? key,
  }) : super(key: key);
  static const ENDPOINT = "/forbidden";

  AuthState authState = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Na zobrazenie stranky musite byt admin",
              textScaleFactor: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/");
                },
                child: const Text("prejst na hlavnu stranku"))
          ],
        ),
      ),
    );
  }
}
