import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';

import '../../states/asset_types_state.dart';
import '../../states/station/components_state.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu_widget.dart';

class TaskChangeComponentsPage extends StatelessWidget {
  static const String ENDPOINT = '/TaskChangeComponent';
  final String taskId;
  late String stationId;
  final AssetTypesState _assets = Get.find();

  TaskChangeComponentsPage({
    Key? key,
    required this.taskId,
  }) : super(key: key) {
    TasksService().loadByIdTaskManagerGetTaskGet(taskId).then((value) {
      stationId = value!.stationId;
      try {
        Get.find(tag: value.stationId);
      } catch (e) {
        Get.put(AssignedComponentsState(value.stationId), tag: value.stationId);
      }
    });
  }

  final Rxn<TaskChangeComponentsSchema> task =
      Rxn<TaskChangeComponentsSchema>();
  bool isModelLoaded = false;

  loadTask() {
    TasksService()
        .loadTaskManagerGetComponentTaskTaskIdGet(taskId)
        .then((value) => task.value = value);
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
    loadTask();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
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
        Text(
          "Uloha - zmena komponentov:  " + task.value!.name,
          style: TextStyle(fontSize: 25),
        ),
        Divider(),
        buildTaskHeader(),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTaskComponents(),
                Text("komentare k tasku"),
                Placeholder(),
              ],
            ),
          ),
        )

        // buildTaskComments(),
      ],
    );
  }

  Widget buildMissingRoadSegment() {
    return SizedBox(
        width: 200, height: 200, child: CircularProgressIndicator());
  }

  buildTaskHeader() {
    return Column(
      children: [
        Text("Datum vytovrenia: " + task.value!.createdAt.toString()),
        Text("Stav: " + buildTaskStatusString()),
        Text("Priradeny k: " + "Jozko Mrkvicka"),
        Divider(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Opis",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.edit),
              ],
            ),
            Text(buildDescription(), style: TextStyle(height: 3), maxLines: 10)
          ],
        ),
        Divider(),
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
        break;
      case TaskState.open:
        return "Nova uloha";
        break;
      case TaskState.ready:
        return "Uloha je pripravena";
        break;
      case TaskState.removed:
        return "Uloha je zrusena";
        break;
    }
    return "Neznamy stav";
  }

  buildTaskComponents() {
    return Column(
      children: [...buildAddComponents(), ...buildRemoveComponnets()],
    );
  }

  buildAddComponents() {
    var col = [];
    if (task.value!.add.isEmpty) {
      return col;
    }
    col.add(ListTile(
      style: ListTileStyle.drawer,
      title: Text(
        "Pridat Komponenty:",
        style: TextStyle(fontSize: 20),
      ),
    ));
    col.add(Divider());
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
    col.add(ListTile(
      style: ListTileStyle.drawer,
      title: Text(
        "Odstranit Komponenty:",
        style: TextStyle(fontSize: 20),
      ),
    ));
    col.add(Divider());
    task.value!.remove.forEach((removeCom) {
      col.add(ListTile(
        leading: Icon(getComponentStatusIcon(
            removeCom.state, TaskComponentState.removed)),
        title: GetBuilder<AssignedComponentsState>(
            tag: stationId,
            builder: (_components) {
              final comp = _components.getById(removeCom.assignedComponentId);
              if (comp == null) return Text("loading...");
              final asset = _assets.getAssetById(comp.assetId);
              if (asset == null) return Text("loading...");
              return Text(asset.name);
            }),
        subtitle: Text(getComponentStatusText(removeCom.state)),
      ));
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
          } else
            return Icons.timer_sharp;
        }

      case TaskComponentState.removed:
        return Icons.done;
        break;
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
        break;
    }
    return "Neznamy stav";
  }
}
