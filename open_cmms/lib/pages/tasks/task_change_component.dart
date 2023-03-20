import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/tasks/complete_change_components_task.dart';
import 'package:open_cmms/widgets/forms/util/text_edit_form.dart';

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

  TaskChangeComponentsPage({
    Key? key,
    required this.taskId,
  }) : super(key: key) {
    TasksService().loadByIdTaskManagerGetTaskGet(taskId).then((value) {
      taskProjection = value;
      try {
        Get.find(tag: taskProjection!.stationId);
      } catch (e) {
        Get.put(AssignedComponentsState(taskProjection!.stationId),
            tag: taskProjection!.stationId);
      }
      loadTask();
    });
  }

  loadTask() {
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
                      .then((value) => loadTask());
                });
              },
            )
          ],
        ),
        const Divider(),
        Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  const Text("komentare k tasku"),
                  Container(width: 600, child: const Placeholder()),
                ],
              ),
              VerticalDivider(),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (x) => Colors.red)),
                            onPressed: () {
                              TasksService()
                                  .cancelTaskTaskManagerTaskIdDelete(taskId)
                                  .then((value) => loadTask());
                            },
                            child: Text("Zrusit ulohu")),
                        VerticalDivider(),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (x) => Colors.green)),
                            onPressed: () {
                              showFormDialog(CompleteChangeComponentsTaskForm(
                                      stationId: taskProjection!.stationId,
                                      task: task.value!))
                                  .then((value) => loadTask());
                            },
                            child: Text("Dokoncit ulohu"))
                      ],
                    ),
                    Divider(),
                    buildTaskHeader(),

                    Expanded(
                        child: Container(
                            height: 300,
                            child: ListView(
                              children: [...buildTaskComponents()],
                            ))),

                    // buildTaskComments(),
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
        Text("Stanica: " + taskProjection!.stationName),
        Text("Cestny usek: " + taskProjection!.roadSegmentName),
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
                      TasksService()
                          .changeDetailsTaskManagerTaskIdChangeDetailsPost(
                          taskId,
                          newDescription: value)
                          .then((value) => loadTask());
                    });
                  },
                ),
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
          if (task.value!.add
              .any((element) => element.state == TaskComponentState.awaiting))
            ElevatedButton(
                onPressed: () {
                  TasksService()
                      .allocateComponentsTaskManagerTaskIdAllocateComponentsGet(
                          taskId)
                      .then((value) => loadTask());
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
            if (comp == null) return const Text("loading...");
            final asset = _assets.getAssetById(comp.assetId);
            if (asset == null) return const Text("loading...");
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
                          (comp.warrantyPeriodUntil
                                  ?.toIso8601String()
                                  .substring(0, 10) ??
                              "")),
                      task.value!.createdAt.isBefore(comp.warrantyPeriodUntil!)
                          ? Icon(Icons.check)
                          : Icon(Icons.close)
                    ],
                  ),
                ],
              ),
            );
          }));
    });

    return col;
  }

  buildTaskComments() {}

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
}
