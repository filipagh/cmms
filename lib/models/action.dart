enum ActionStatus {
  awaiting,
  inProgress,
  finished,
}

class Action {
  late String id;
  late String taskId;
  late ActionStatus status;

  Action(this.id, this.taskId, this.status);
}
