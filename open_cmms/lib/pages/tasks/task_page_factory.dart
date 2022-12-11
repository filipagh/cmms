import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/tasks/task_change_component.dart';
import 'package:open_cmms/pages/tasks/task_on_site_service.dart';
import 'package:open_cmms/pages/tasks/task_remote_service.dart';
import 'package:open_cmms/service/backend_api/tasks_service.dart';

class TaskPageFactory {
  openTaskPageFromModel(TaskSchema task) {
    switch (task.taskType) {
      case TaskType.componentChange:
        Get.toNamed(TaskChangeComponentsPage.ENDPOINT + '/' + task.id);
        break;
      case TaskType.onSiteService:
        Get.toNamed(TaskOnSiteServicePage.ENDPOINT + '/' + task.id);
        break;
      case TaskType.remoteService:
        Get.toNamed(TaskRemoteServicePage.ENDPOINT + '/' + task.id);
        break;
    }
  }

  openTaskPage(String taskId) {
    TasksService().loadByIdTaskManagerGetTaskGet(taskId).then((value) {
      openTaskPageFromModel(value!);
    });
  }

}
