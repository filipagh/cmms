import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth.dart';
import '../states/auth_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AuthState authState = Get.find();
  final uri = Uri.parse("http://localhost:8080/login");

  // final uri = Uri.parse("https://google.sk");
  @override
  Widget build(BuildContext context) {
    if (!authState.isAuthenticated.value) {
      login();
    }

    // launchUrl(uri,mode: LaunchMode.inAppWebView).then((value) => print(value));
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
                GetX<AuthState>(builder: (_) {
                  return Text(_.isAuthenticated.value.toString());
                }),
                // html.window.open('http://localhost:8080/login',"_blank", 'location=yes');

                // ElevatedButton(onPressed: () {launchUrl(uri);}, child: Text("liodjeofij")),
                // ElevatedButton(onPressed: () {BackEndService().getUserUserGet().then((value) => print(value));}, child: Text("liodjeofij")),
                ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    child: Text("logout")),
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text("login"))
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
