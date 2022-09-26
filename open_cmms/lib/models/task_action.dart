enum ActionStatus {
  awaiting,
  inProgress,
  finished,
}

enum ActionJob {
  install,
  remove,
  remoteService,
}



class TaskAction {
  late String id;
  late String taskId;
  late ActionStatus status;
  late ActionJob job;

  TaskAction(this.id, this.taskId, this.job, this.status);
}
