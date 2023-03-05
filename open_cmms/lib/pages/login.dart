import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Login extends StatefulWidget {
  Login({
    Key? key,
  }) : super(key: key) {
    final uri = Uri.parse("http://localhost:8080/login");
    launchUrl(uri, mode: LaunchMode.inAppWebView);
  }

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Text(
                  "DashBoard",
                  textScaleFactor: 5,
                ),
                Text("mapa"),
                // html.window.open('http://localhost:8080/login',"_blank", 'location=yes');

                // ElevatedButton(onPressed: () {launchUrl(uri);}, child: Text("liodjeofij")),
                // ElevatedButton(onPressed: () {BackEndService().getUserUserGet().then((value) => print(value));}, child: Text("liodjeofij")),
                // ElevatedButton(onPressed: () {launchUrl(uri);}, child: Text("liodjeofij"))
                // Expanded(child: Placeholder()),
                // launchUrl("http://www.google.com", forceSafariVC: true, forceWebView: true)
              ],
            ),
          )
        ],
      ),
    );
  }
}
