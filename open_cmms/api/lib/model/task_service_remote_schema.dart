//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TaskServiceRemoteSchema {
  /// Returns a new [TaskServiceRemoteSchema] instance.
  TaskServiceRemoteSchema({
    required this.stationId,
    required this.name,
    required this.description,
    required this.id,
    required this.state,
    required this.createdAt,
    this.finishedAt,
  });

  String stationId;

  String name;

  String description;

  String id;

  TaskState state;

  DateTime createdAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? finishedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TaskServiceRemoteSchema &&
     other.stationId == stationId &&
     other.name == name &&
     other.description == description &&
     other.id == id &&
     other.state == state &&
     other.createdAt == createdAt &&
     other.finishedAt == finishedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationId.hashCode) +
    (name.hashCode) +
    (description.hashCode) +
    (id.hashCode) +
    (state.hashCode) +
    (createdAt.hashCode) +
    (finishedAt == null ? 0 : finishedAt!.hashCode);

  @override
  String toString() => 'TaskServiceRemoteSchema[stationId=$stationId, name=$name, description=$description, id=$id, state=$state, createdAt=$createdAt, finishedAt=$finishedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'station_id'] = this.stationId;
    json[r'name'] = this.name;
    json[r'description'] = this.description;
    json[r'id'] = this.id;
    json[r'state'] = this.state;
    json[r'created_at'] = this.createdAt.toUtc().toIso8601String();
    if (this.finishedAt != null) {
      json[r'finished_at'] = this.finishedAt!.toUtc().toIso8601String();
    } else {
      json[r'finished_at'] = null;
    }
    return json;
  }

  /// Returns a new [TaskServiceRemoteSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TaskServiceRemoteSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TaskServiceRemoteSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TaskServiceRemoteSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TaskServiceRemoteSchema(
        stationId: mapValueOfType<String>(json, r'station_id')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        id: mapValueOfType<String>(json, r'id')!,
        state: TaskState.fromJson(json[r'state'])!,
        createdAt: mapDateTime(json, r'created_at', '')!,
        finishedAt: mapDateTime(json, r'finished_at', ''),
      );
    }
    return null;
  }

  static List<TaskServiceRemoteSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TaskServiceRemoteSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskServiceRemoteSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TaskServiceRemoteSchema> mapFromJson(dynamic json) {
    final map = <String, TaskServiceRemoteSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TaskServiceRemoteSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TaskServiceRemoteSchema-objects as value to a dart map
  static Map<String, List<TaskServiceRemoteSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TaskServiceRemoteSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TaskServiceRemoteSchema.listFromJson(
          entry.value,
          growable: growable,
        );
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
    'created_at',
  };
}

