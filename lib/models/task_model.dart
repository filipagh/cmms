class TaskModel {
  late String id;
  late String name;
  late String text;
  late List<String> technician = [];

  TaskModel(this.id,this.name,this.text,this.technician);
}



List<TaskModel> dummyTasks = [TaskModel("1","change component", "text",[]), TaskModel("2","diagnose station ...", "text",[])];

TaskModel? getDummyTaskById(String id) {
  var i = dummyTasks.where((element) => element.id == id);
  if (i.isEmpty) {
    return null;
  }
  return i.first;
}
