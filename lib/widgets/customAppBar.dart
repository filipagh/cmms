import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/myTasks.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<CustomAppBar> {
  String aa = "xxxx";
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(aa),);

  }
}
