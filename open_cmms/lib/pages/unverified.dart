import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../states/auth_state.dart';
import '../widgets/custom_app_bar.dart';

class Unverified extends StatelessWidget {
  Unverified({
    Key? key,
  }) : super(key: key);
  static const ENDPOINT = "/unverified";

  AuthState authState = Get.find();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          "Váš účet nebol povolený kontaktujete admina",
          textScaleFactor: 5,
        ),
      ),
    );
  }
}
