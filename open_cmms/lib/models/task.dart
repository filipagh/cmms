enum TaskStatus {
  awaiting,
  inProgress,
  finished,
}

class Task {
  late String id;
  late String name;
  late String text;
  late String stationId;
  late TaskStatus status;

  Task(this.id,this.name,this.text,this.stationId, this.status);
}


