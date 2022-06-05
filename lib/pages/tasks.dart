import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/task_model.dart';
import 'package:open_cmms/widgets/create_form.dart';
import 'package:open_cmms/widgets/customAppBar.dart';

import '../models/asset_model.dart';
import '../widgets/mainMenuWidget.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key, required}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
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
                  "Tasks",
                  textScaleFactor: 5,
                ),
                Row(
                  children: [
                    Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {showdialog();},
                      child: Text("create task"),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                      addRepaintBoundaries: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: dummyTasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(

                          child: ListTile(
                            onTap: () {Get.toNamed("/Tasks/${dummyTasks[index].id}");},
                            hoverColor: Colors.blue.shade200,
                            title: Text(dummyTasks[index].name),
                            subtitle: Container(
                              child: Text('task id: ${dummyTasks[index].id}'),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
