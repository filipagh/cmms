import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../states/auth_state.dart';
import '../widgets/custom_app_bar.dart';

class Login extends StatelessWidget {
  Login({
    Key? key,
  }) : super(key: key);
  static const ENDPOINT = "/login";

  AuthState authState = Get.find();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Prihláste sa prosím",
              textScaleFactor: 5,
            ),
            Spacer(),
            GetX<AuthState>(builder: (_) {
              if (_.isAuthWindowOpen.value) {
                return Column(
                  children: [
                    Text("prihlasovaci formular je otvoreny v novom okne"),
                    Text(
                      "je potrebne povolit vyskakovacie okno",
                      style: TextStyle(
                          color: Colors.red[400], fontWeight: FontWeight.bold),
                    ),
                    CircularProgressIndicator(),
                  ],
                );
              }
              return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.green[400]!)),
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    "Prihlásiť sa",
                    textScaleFactor: 3,
                  ));
            }),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
