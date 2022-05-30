import 'package:flutter/material.dart';
import 'package:open_cmms/widgets/customAppBar.dart';

import '../widgets/mainMenuWidget.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key, required}) : super(key: key);

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
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
                  "My Tasks",
                  textScaleFactor: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
