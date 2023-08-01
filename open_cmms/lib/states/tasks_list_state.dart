import 'dart:core';

import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/task_state_filter.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';

class TasksListState extends GetxController {
  late final StationSchema? _station;
  final RxList<TaskSchema> _tasks = <TaskSchema>[].obs;
  late final RxList<TaskStateCustom> _tasksState = <TaskStateCustom>[].obs;
  final RxInt _page = 1.obs;
  final RxBool _hasMoreData = true.obs;

  final pagesize = 15;

  TasksListState(this._station, List<TaskStateCustom> tasksState) {
    _tasksState.value = tasksState;
  }

  @override
  void onInit() {
    _reload();
    super.onInit();
  }

  _reload() {
    _hasMoreData.value = true;
    _page.value = 1;
    TasksService()
        .loadAllTaskManagerGetTasksGet(_page.value, pagesize,
            stationId: _station?.id,
            filterState: _tasksState.value.map((e) => e.state).toList())
        .then((value) {
      _tasks.clear();
      _tasks.addAll(value ?? []);
      _tasks.refresh();
      if (value == null || value.length < pagesize) {
        _hasMoreData.value = false;
      }
    });
  }

  loadMore() {
    if (!_hasMoreData.value) {
      return;
    }
    _page.value++;
    TasksService()
        .loadAllTaskManagerGetTasksGet(_page.value, pagesize,
            stationId: _station?.id,
            filterState: _tasksState.value.map((e) => e.state).toList())
        .then((value) {
      _tasks.addAll(value ?? []);
      _tasks.refresh();
      if (value == null || value.length < pagesize) {
        _hasMoreData.value = false;
      }
    });
  }

  List<TaskSchema> getTasks() {
    return _tasks.toList();
  }

  List<TaskStateCustom> getFilterTasksStates() {
    return _tasksState.value;
  }

  setFilterTasksStates(List<TaskStateCustom> tasksState) {
    _tasksState.value = tasksState;
    _reload();
  }

  reload() {
    _reload();
  }
}
