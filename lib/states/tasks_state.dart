import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/task.dart';

class TasksState extends GetxController {
  Map<String, Task> tasks = <String, Task>{}.obs;
  int _taskSequence = 0;

  @override
  void onInit() {

    HelpTask.task0 = createNewTask('vymena teplomeru', 'text', HelpStation.station0, TaskStatus.awaiting);
    HelpTask.task1= createNewTask('kontrola stanice', 'text', HelpStation.station1, TaskStatus.inProgress);
    super.onInit();
  }

  String createNewTask(name, text, stationId, status) {
    var id = _taskSequence.toString();
    var item = new Task(id, name, text, stationId, status);

    tasks[id] = item;

    _taskSequence++;
    return id;
  }
}
