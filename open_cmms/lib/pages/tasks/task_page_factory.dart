import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/task.dart';
import 'package:open_cmms/pages/tasks/task_change_component.dart';
import 'package:open_cmms/pages/tasks/task_on_site_service.dart';
import 'package:open_cmms/pages/tasks/task_remote_service.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';

class TaskPageFactory {
  openTaskPageFromModel(TaskSchema task) {
    Get.toNamed(getTaskPageUrl(task));
  }

  String getTaskPageUrl(TaskSchema task) {
    switch (task.taskType) {
      case TaskType.componentChange:
        return (TaskChangeComponentsPage.ENDPOINT + '/' + task.id);

      case TaskType.onSiteService:
        return (TaskOnSiteServicePage.ENDPOINT + '/' + task.id);

      case TaskType.remoteService:
        return (TaskRemoteServicePage.ENDPOINT + '/' + task.id);

      default:
        return TaskPage.ENDPOINT;
    }
  }

  Future<String> getTaskUrlFromId(String taskId) async {
    var task = await TasksService().loadByIdTaskManagerGetTaskGet(taskId);
    return getTaskPageUrl(task!);
  }

  openTaskFromId(String taskId) {
    TasksService().loadByIdTaskManagerGetTaskGet(taskId).then((value) {
      openTaskPageFromModel(value!);
    });
  }
}
