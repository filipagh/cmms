import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/tasks/task_change_component.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';

class TaskPageFactory {
  openTaskPageFromModel(TaskSchema task) {
    switch (task.taskType) {
      case TaskType.componentChange:
        _openComponentChangeTaskPage(task.id);
        break;
      case TaskType.onSiteService:
        // TODO: Handle this case.
        break;
      case TaskType.remoteService:
        // TODO: Handle this case.
        break;
    }
  }

  openTaskPage(String taskId) {
    TasksService().loadByIdTaskManagerGetTaskGet(taskId).then((value) {
      openTaskPageFromModel(value!);
    });
  }

  _openComponentChangeTaskPage(String taskId) {
    Get.toNamed(TaskChangeComponentsPage.ENDPOINT + '/' + taskId);
  }
}
