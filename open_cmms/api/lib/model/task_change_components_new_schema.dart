//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TaskChangeComponentsNewSchema {
  /// Returns a new [TaskChangeComponentsNewSchema] instance.
  TaskChangeComponentsNewSchema({
    required this.stationId,
    required this.name,
    required this.description,
    required this.warrantyPeriodDays,
    this.add = const [],
    this.remove = const [],
  });

  String stationId;

  String name;

  String description;

  int warrantyPeriodDays;

  List<TaskComponentAddNewSchema> add;

  List<TaskComponentRemoveNewSchema> remove;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskChangeComponentsNewSchema &&
          other.stationId == stationId &&
          other.name == name &&
          other.description == description &&
          other.warrantyPeriodDays == warrantyPeriodDays &&
          other.add == add &&
     other.remove == remove;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
  (stationId.hashCode) +
      (name.hashCode) +
      (description.hashCode) +
      (warrantyPeriodDays.hashCode) +
      (add.hashCode) +
    (remove.hashCode);

  @override
  String toString() =>
      'TaskChangeComponentsNewSchema[stationId=$stationId, name=$name, description=$description, warrantyPeriodDays=$warrantyPeriodDays, add=$add, remove=$remove]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'station_id'] = stationId;
    _json[r'name'] = name;
    _json[r'description'] = description;
    _json[r'warranty_period_days'] = warrantyPeriodDays;
    _json[r'add'] = add;
    _json[r'remove'] = remove;
    return _json;
  }

  /// Returns a new [TaskChangeComponentsNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TaskChangeComponentsNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TaskChangeComponentsNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TaskChangeComponentsNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TaskChangeComponentsNewSchema(
        stationId: mapValueOfType<String>(json, r'station_id')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        warrantyPeriodDays: mapValueOfType<int>(json, r'warranty_period_days')!,
        add: TaskComponentAddNewSchema.listFromJson(json[r'add'])!,
        remove: TaskComponentRemoveNewSchema.listFromJson(json[r'remove'])!,
      );
    }
    return null;
  }

  static List<TaskChangeComponentsNewSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TaskChangeComponentsNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskChangeComponentsNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TaskChangeComponentsNewSchema> mapFromJson(dynamic json) {
    final map = <String, TaskChangeComponentsNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TaskChangeComponentsNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TaskChangeComponentsNewSchema-objects as value to a dart map
  static Map<String, List<TaskChangeComponentsNewSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TaskChangeComponentsNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TaskChangeComponentsNewSchema.listFromJson(entry.value, growable: growable,);
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
    'warranty_period_days',
    'add',
    'remove',
  };
}

