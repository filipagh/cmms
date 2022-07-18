import 'dart:core';

enum AssignedComponentStateEnum { awaiting, installed, removed }

class AssignedComponent {
  late String assignedComponentId;
  late String productId;
  late String stationId;
  late DateTime? installed;
  late DateTime created;
  late DateTime? removed;
  late AssignedComponentStateEnum actualState;

  AssignedComponent(
    this.assignedComponentId,
    this.productId,
    this.stationId,
    this.created, [
    this.installed,
    this.removed,
    this.actualState = AssignedComponentStateEnum.awaiting,
  ]);
}
