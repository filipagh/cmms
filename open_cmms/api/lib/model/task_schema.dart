//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TaskSchema {
  /// Returns a new [TaskSchema] instance.
  TaskSchema({
    required this.stationId,
    required this.name,
    required this.description,
    required this.id,
    required this.state,
    required this.taskType,
    required this.createdOn,
  });

  String stationId;

  String name;

  String description;

  String id;

  TaskState state;

  TaskType taskType;

  DateTime createdOn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TaskSchema &&
     other.stationId == stationId &&
     other.name == name &&
     other.description == description &&
     other.id == id &&
     other.state == state &&
     other.taskType == taskType &&
     other.createdOn == createdOn;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationId.hashCode) +
    (name.hashCode) +
    (description.hashCode) +
    (id.hashCode) +
    (state.hashCode) +
    (taskType.hashCode) +
    (createdOn.hashCode);

  @override
  String toString() => 'TaskSchema[stationId=$stationId, name=$name, description=$description, id=$id, state=$state, taskType=$taskType, createdOn=$createdOn]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'station_id'] = stationId;
      _json[r'name'] = name;
      _json[r'description'] = description;
      _json[r'id'] = id;
      _json[r'state'] = state;
      _json[r'task_type'] = taskType;
      _json[r'created_on'] = createdOn.toUtc().toIso8601String();
    return _json;
  }

  /// Returns a new [TaskSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TaskSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TaskSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TaskSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TaskSchema(
        stationId: mapValueOfType<String>(json, r'station_id')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        id: mapValueOfType<String>(json, r'id')!,
        state: TaskState.fromJson(json[r'state'])!,
        taskType: TaskType.fromJson(json[r'task_type'])!,
        createdOn: mapDateTime(json, r'created_on', '')!,
      );
    }
    return null;
  }

  static List<TaskSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TaskSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TaskSchema> mapFromJson(dynamic json) {
    final map = <String, TaskSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TaskSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TaskSchema-objects as value to a dart map
  static Map<String, List<TaskSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TaskSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TaskSchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'station_id',
    'name',
    'description',
    'id',
    'state',
    'task_type',
    'created_on',
  };
}

