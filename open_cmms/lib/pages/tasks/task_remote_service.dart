import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks/tasks_remote_service.dart';
import 'package:open_cmms/widgets/forms/util/text_edit_form.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/dialog_form.dart';
import '../../widgets/main_menu_widget.dart';

class TaskRemoteServicePage extends StatelessWidget {
  static const String ENDPOINT = '/TaskRemoteService';
  final String taskId;
  final Rxn<TaskServiceRemoteSchema> task = Rxn<TaskServiceRemoteSchema>();

  TaskRemoteServicePage({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  TasksRemoteService getService() {
    return TasksRemoteService();
  }

  loadTask() {
    getService().loadTaskServiceRemoteTaskIdGet(taskId).then((value) {
      task.value = value;
      task.refresh();
    });
  }

  Widget buildContent() {
    return Obx(() {
      if (task.value != null) {
        return buildTaskPage();
      }
      return buildLoadingCircle();
    });
  }

  @override
  Widget build(BuildContext context) {
    loadTask();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: buildContent(),
          )
        ],
      ),
    );
  }

  Widget buildTaskPage() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Uloha - vzdialena kontrola :  " + task.value!.name,
              style: const TextStyle(fontSize: 25),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                showFormDialog(TextEditForm(
                        title: "Zmena nazvu ulohy", text: task.value!.name))
                    .then((value) {
                  getService()
                      .changeDetailsTaskServiceRemoteTaskIdChangeDetailsPost(
                          taskId,
                          newName: value)
                      .then((value) => loadTask());
                });
              },
            )
          ],
        ),
        const Divider(),
        buildTaskHeader(),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("komentare k tasku"),
                const Placeholder(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (x) => Colors.red)),
                        onPressed: () {
                          getService()
                              .cancelTaskServiceRemoteTaskIdDelete(taskId)
                              .then((value) => loadTask());
                        },
                        child: Text("Zrusit ulohu")),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (x) => Colors.green)),
                        onPressed: () {
                          getService()
                              .completeTaskServiceRemoteTaskIdCompleteGet(
                                  taskId)
                              .then((value) => loadTask());
                        },
                        child: Text("Dokoncit ulohu"))
                  ],
                )
              ],
            ),
          ),
        )

        // buildTaskComments(),
      ],
    );
  }

  Widget buildLoadingCircle() {
    return const SizedBox(
        width: 200, height: 200, child: CircularProgressIndicator());
  }

  buildTaskHeader() {
    return Column(
      children: [
        Text("Datum vytovrenia: " + task.value!.createdAt.toString()),
        Text("Stav: " + buildTaskStatusString()),
        const Text("Priradeny k: " + "Jozko Mrkvicka"),
        const Divider(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Opis",
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    showFormDialog(TextEditForm(
                            title: "Zmena opisu ulohy",
                            text: task.value!.description))
                        .then((value) {
                      getService()
                          .changeDetailsTaskServiceRemoteTaskIdChangeDetailsPost(
                              taskId,
                              newDescription: value)
                          .then((value) => loadTask());
                    });
                  },
                )
              ],
            ),
            Text(buildDescription(),
                style: const TextStyle(height: 3), maxLines: 10)
          ],
        ),
        const Divider(),
      ],
    );
  }

  String buildDescription() {
    var description = task.value!.description;
    return description.isEmpty ? "Bez popisu" : description;
  }

  String buildTaskStatusString() {
    switch (task.value!.state) {
      case TaskState.done:
        return "Uloha je dokoncena";
      case TaskState.open:
        return "Nova uloha";
      case TaskState.ready:
        return "Uloha je pripravena";
      case TaskState.removed:
        return "Uloha je zrusena";
    }
    return "Neznamy stav";
  }
}
