import 'package:flutter/material.dart';

import '../widgets/mainMenuWidget.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key, required }) : super(key: key);



  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OpenCMMS"),
      ),
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
          )
        ],
      ),
    );
  }
}
