//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RemoveComponentRequestSchema {
  /// Returns a new [RemoveComponentRequestSchema] instance.
  RemoveComponentRequestSchema({
    required this.id,
    required this.assignedComponentId,
    required this.state,
  });

  String id;

  String assignedComponentId;

  TaskComponentState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RemoveComponentRequestSchema &&
     other.id == id &&
     other.assignedComponentId == assignedComponentId &&
     other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (assignedComponentId.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'RemoveComponentRequestSchema[id=$id, assignedComponentId=$assignedComponentId, state=$state]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'id'] = this.id;
    json[r'assigned_component_id'] = this.assignedComponentId;
    json[r'state'] = this.state;
    return json;
  }

  /// Returns a new [RemoveComponentRequestSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RemoveComponentRequestSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RemoveComponentRequestSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RemoveComponentRequestSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RemoveComponentRequestSchema(
        id: mapValueOfType<String>(json, r'id')!,
        assignedComponentId: mapValueOfType<String>(json, r'assigned_component_id')!,
        state: TaskComponentState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<RemoveComponentRequestSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RemoveComponentRequestSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RemoveComponentRequestSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RemoveComponentRequestSchema> mapFromJson(dynamic json) {
    final map = <String, RemoveComponentRequestSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RemoveComponentRequestSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RemoveComponentRequestSchema-objects as value to a dart map
  static Map<String, List<RemoveComponentRequestSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RemoveComponentRequestSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RemoveComponentRequestSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'assigned_component_id',
    'state',
  };
}

