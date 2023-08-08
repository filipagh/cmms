import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/auth.dart';
import 'package:open_cmms/states/auth_state.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({Key? key, this.pageText}) : super(key: key);

  Widget? pageText;

  @override
  State<CustomAppBar> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Center(child: widget.pageText ?? Text("openCMMS")),
        actions: [
          GetX<AuthState>(
            builder: (_) {
              if (_.isAuthenticated.value) {
                return Center(
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (x) => Colors.white)),
                      child: Text("odhlás sa"),
                      onPressed: () {
                        logout();
                      }),
                );
              }
              return Center(child: Text("neprihláseny"));
            },
          ),
        ]);
  }
}
