import 'package:BackendAPI/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/pages/tasks/task_utils.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/tasks/complete_change_components_task.dart';
import 'package:open_cmms/widgets/forms/util/text_edit_form.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/backend_api/redmine_service.dart';
import '../../snacbars.dart';
import '../../states/asset_types_state.dart';
import '../../states/station/components_state.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu_widget.dart';

class TaskChangeComponentsPage extends StatelessWidget {
  static const String ENDPOINT = '/TaskChangeComponent';
  final String taskId;
  late final TaskSchema? taskProjection;
  final AssetTypesState _assets = Get.find();
  final Rxn<TaskChangeComponentsSchema> task =
      Rxn<TaskChangeComponentsSchema>();
  final Rxn<RedmineIssueDataSchema> redmineData = Rxn<RedmineIssueDataSchema>();

  TaskChangeComponentsPage({
    Key? key,
    required this.taskId,
  }) : super(key: key) {
    TasksService().loadByIdTaskManagerGetTaskGet(taskId).then((value) {
      taskProjection = value;
      try {
        AssignedComponentsState com = Get.find(tag: taskProjection!.stationId);
      } catch (e) {
        AssignedComponentsState com = Get.put(
            AssignedComponentsState(taskProjection!.stationId),
            tag: taskProjection!.stationId);
        com.load();
      }
      loadTaskItems();
      loadRedmineData(taskProjection!.id);
    });
  }

  loadTaskItems() {
    TasksService()
        .loadTaskManagerGetComponentTaskTaskIdGet(taskId)
        .then((value) {
      task.value = value;
      task.refresh();
    });
  }

  Widget buildContent() {
    return Obx(() {
      if (task.value != null) {
        return buildTaskPage();
      }
      return buildMissingRoadSegment();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              "Uloha - zmena komponentov:  " + task.value!.name,
              style: const TextStyle(fontSize: 25),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                showFormDialog(TextEditForm(
                        title: "Zmena nazvu ulohy", text: task.value!.name))
                    .then((value) {
                  TasksService()
                      .changeDetailsTaskManagerTaskIdChangeDetailsPost(taskId,
                          newName: value)
                      .then((value) => loadTaskItems());
                });
              },
            )
          ],
        ),
        const Divider(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text("komentáre: "),
                    Obx(() {
                      if (redmineData.value != null)
                        return buildRedmineComments(redmineData.value!);
                      else
                        return Text("Ziadne komentáre");
                    }),
                  ],
                ),
              ),
              const VerticalDivider(),
              Flexible(
                child: Column(
                  children: [
                    if (task.value!.state == TaskState.open ||
                        task.value!.state == TaskState.ready) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (x) => Colors.red)),
                              onPressed: () {
                                TasksService()
                                    .cancelTaskTaskManagerTaskIdDelete(taskId)
                                    .then((value) {
                                  showOk("úloha bola zrusená");
                                  loadTaskItems();
                                });
                              },
                              child: const Text("Zrusit ulohu")),
                          const VerticalDivider(),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith(
                                          (x) => Colors.green)),
                              onPressed: () {
                                showFormDialog(CompleteChangeComponentsTaskForm(
                                        stationId: taskProjection!.stationId,
                                        task: task.value!))
                                    .then((value) => loadTaskItems());
                              },
                              child: const Text("Dokoncit ulohu"))
                        ],
                      ),
                    ],
                    const Divider(),
                    buildTaskHeader(),

                    Expanded(
                        child: Container(
                            height: 300,
                            child: ListView(
                              children: [...buildTaskComponents()],
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMissingRoadSegment() {
    return const SizedBox(
        width: 200, height: 200, child: CircularProgressIndicator());
  }

  // todo deduplikovat 3x
  buildTaskHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(buildTaskStatusIcon()),
            Text("Stav: " + buildTaskStatusString()),
          ],
        ),
        Divider(),
        Padding(padding: EdgeInsets.all(5)),
        Row(
          children: [
            Text("Stanica: " + taskProjection!.stationName),
            IconButton(
                onPressed: () {
                  Get.toNamed(StationBasePage.ENDPOINT +
                      "/" +
                      taskProjection!.stationId);
                },
                icon: Icon(Icons.link)),
          ],
        ),
        Text("Cestny usek: " + taskProjection!.roadSegmentName),
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
              children: const [
                Text(
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
                //       TasksService()
                //           .changeDetailsTaskManagerTaskIdChangeDetailsPost(
                //               taskId,
                //               newDescription: value)
                //           .then((value) => loadTaskItems());
                //     });
                //   },
                // ),
              ],
            ),
            Text(redmineData.value?.description ?? "bez popisu",
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

  IconData buildTaskStatusIcon() {
    switch (task.value!.state) {
      case TaskState.done:
        return Icons.done_all;
      case TaskState.open:
        return Icons.warning;
      case TaskState.ready:
        return Icons.watch_later_outlined;
      case TaskState.removed:
        return Icons.remove_circle_outline;
    }
    return Icons.error;
  }

  buildTaskComponents() {
    return [...buildAddComponents(), ...buildRemoveComponnets()];
  }

  buildAddComponents() {
    var col = [];
    if (task.value!.add.isEmpty) {
      return col;
    }

    col.add(ListTile(
      style: ListTileStyle.drawer,
      title: Row(
        children: [
          const Text(
            "Pridat Komponenty:",
            style: TextStyle(fontSize: 20),
          ),
          if (task.value!.add.any(
                  (element) => element.state == TaskComponentState.awaiting) &&
              task.value!.state == TaskState.open)
            ElevatedButton(
                onPressed: () {
                  TasksService()
                      .allocateComponentsTaskManagerTaskIdAllocateComponentsGet(
                          taskId)
                      .then((value) => loadTaskItems());
                },
                child: const Text("Priradit komponenty")),
        ],
      ),
    ));
    col.add(const Divider());
    task.value!.add.forEach((addCom) {
      col.add(ListTile(
        leading: Icon(
            getComponentStatusIcon(addCom.state, TaskComponentState.installed)),
        title: Text(_assets.getAssetById(addCom.newAssetId)!.name),
        subtitle: Text(getComponentStatusText(addCom.state)),
      ));
    });

    return col;
  }

  buildRemoveComponnets() {
    var col = [];
    if (task.value!.remove.isEmpty) {
      return col;
    }
    col.add(const ListTile(
      style: ListTileStyle.drawer,
      title: Text(
        "Odstranit Komponenty:",
        style: TextStyle(fontSize: 20),
      ),
    ));
    col.add(const Divider());
    task.value!.remove.forEach((removeCom) {
      col.add(GetBuilder<AssignedComponentsState>(
          tag: taskProjection!.stationId,
          builder: (_components) {
            final comp = _components.getById(removeCom.assignedComponentId);
            if (comp == null) return const Text("naciavam...");
            final asset = _assets.getAssetById(comp.assetId);
            if (asset == null) return const Text("nacitavam...");
            return ListTile(
              leading: Icon(getComponentStatusIcon(
                  removeCom.state, TaskComponentState.removed)),
              title: Text(asset.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getComponentStatusText(removeCom.state)),
                  Row(
                    children: [
                      Text("Zaruka do : " +
                          (comp.componentWarrantyUntil
                                  ?.toIso8601String()
                                  .substring(0, 10) ??
                              "")),
                      task.value!.createdAt
                              .isBefore(comp.componentWarrantyUntil!)
                          ? const Icon(Icons.check)
                          : const Icon(Icons.close)
                    ],
                  ),
                ],
              ),
            );
          }));
    });

    return col;
  }


  IconData getComponentStatusIcon(TaskComponentState state, goalState) {
    switch (state) {
      case TaskComponentState.allocated:
        return Icons.timer_sharp;
      case TaskComponentState.awaiting:
        return Icons.warning;
      case TaskComponentState.installed:
        {
          if (goalState == TaskComponentState.installed) {
            return Icons.done;
          } else {
            return Icons.timer_sharp;
          }
        }

      case TaskComponentState.removed:
        return Icons.done;
    }
    return Icons.error;
  }

  String getComponentStatusText(TaskComponentState state) {
    switch (state) {
      case TaskComponentState.allocated:
        return "komponent je alokovoany zo skladu";
      case TaskComponentState.awaiting:
        return "caka sa na naskladnenie zo skladu";
      case TaskComponentState.installed:
        return "komponent je nainstalovany";
      case TaskComponentState.removed:
        return "komponent je odstraneny";
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
