import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/tasks.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text("openCMMS"),);

  }
}
