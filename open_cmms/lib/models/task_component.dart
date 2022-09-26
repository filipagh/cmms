enum TaskComponentStatus {
  awaiting,
  allocated,
  installed,
  removed,
}

class TaskComponent {
  late String id;
  late String actionId;
  late String productId;
  late String? assignedComponentId;
  late TaskComponentStatus status;

  TaskComponent(this.id, this.actionId, this.productId, this.status);
}
