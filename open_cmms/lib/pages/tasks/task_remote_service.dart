import 'package:BackendAPI/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/tasks/task_utils.dart';
import 'package:open_cmms/service/backend_api/tasks/tasks_remote_service.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/forms/util/text_edit_form.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/backend_api/redmine_service.dart';
import '../../snacbars.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/dialog_form.dart';
import '../../widgets/main_menu_widget.dart';
import '../station/station_base_page.dart';

class TaskRemoteServicePage extends StatelessWidget {
  static const String ENDPOINT = '/TaskRemoteService';
  final String taskId;

  final Rxn<TaskSchema> taskProjection = Rxn<TaskSchema>();
  final Rxn<TaskServiceRemoteSchema> task = Rxn<TaskServiceRemoteSchema>();
  final Rxn<RedmineIssueDataSchema> redmineData = Rxn<RedmineIssueDataSchema>();

  TaskRemoteServicePage({
    Key? key,
    required this.taskId,
  }) : super(key: key) {
    TasksService().loadByIdTaskManagerGetTaskGet(taskId).then((value) {
      taskProjection.value = value;
      taskProjection.refresh();
    });
  }

  TasksRemoteService getService() {
    return TasksRemoteService();
  }

  loadTask() {
    getService().loadTaskServiceRemoteTaskIdGet(taskId).then((value) {
      task.value = value;
      task.refresh();
      loadRedmineData(task.value!.id);
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
          child: Column(
            children: [
              if (task.value!.state == TaskState.open ||
                  task.value!.state == TaskState.ready) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (x) => Colors.red)),
                        onPressed: () async {
                          if (await showAlert(
                          "Naozaj chcete úlohu zrušiť?") ==
                          false) return;
                          getService()
                              .cancelTaskServiceRemoteTaskIdDelete(taskId)
                              .then((value) {
                            loadTask();
                            showOk("úloha bola zrusená");
                          });
                        },
                        child: Text("Zrusit ulohu")),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (x) => Colors.green)),
                        onPressed: () async {
                          if (await showAlert(
                          "Naozaj chcete úlohu dokončiť?") ==
                          false) return;
                          getService()
                              .completeTaskServiceRemoteTaskIdCompleteGet(
                                  taskId)
                              .then((value) {
                            loadTask();
                            showOk("úloha bola dokoncená");
                          });
                        },
                        child: Text("Dokoncit ulohu"))
                  ],
                ),
                const Divider(),
              ],
              const Text("komentáre k tasku"),
              Obx(() {
                if (redmineData.value != null)
                  return buildRedmineComments(redmineData.value!);
                else
                  return Text("Ziadne komentáre");
              }),
            ],
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
        Text("Stav: " + buildTaskStatusString()),
        Divider(),
        taskProjection.value != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Stanica: " + taskProjection.value!.stationName),
                  IconButton(
                      onPressed: () {
                        Get.toNamed(StationBasePage.ENDPOINT +
                            "/" +
                            taskProjection.value!.stationId);
                      },
                      icon: Icon(Icons.link)),
                ],
              )
            : Text("nacitavam"),
        Text("Datum vytovrenia: " + task.value!.createdAt.toString()),
        Obx(() =>
            Text("Priradeny k: " + (redmineData.value?.assignedTo ?? ""))),
        Obx(() => RichText(
                    text: TextSpan(
                  text: "Link na redmine: ",
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchUrl(
                              Uri.parse(redmineData.value!.linkToRedmine)),
                        text: redmineData.value?.linkToRedmine ?? "",
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline))
                  ],
                ))
            //
            // Text(
            // "Link na redmine: " + (redmineData.value?.linkToRedmine ?? ""))
            ),
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
                // IconButton(
                //   icon: const Icon(Icons.edit),
                //   onPressed: () async {
                //     showFormDialog(TextEditForm(
                //             title: "Zmena opisu ulohy",
                //             text: task.value!.description))
                //         .then((value) {
                //       getService()
                //           .changeDetailsTaskServiceRemoteTaskIdChangeDetailsPost(
                //               taskId,
                //               newDescription: value)
                //           .then((value) => loadTask());
                //     });
                //   },
                // )
              ],
            ),
            Obx(() =>
            Text(buildDescription(),
                style: const TextStyle(height: 3), maxLines: 10))
          ],
        ),
        const Divider(),
      ],
    );
  }

  String buildDescription() {
    var description = this.redmineData.value?.description ?? task.value!.description;
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

  void loadRedmineData(String task_id) {
    RedmineService().loadRedmineTaskIdLoadGet(task_id).then((value) {
      redmineData.value = value;
    }, onError: (error) {
      redmineData.value = null;
    });
  }
}
