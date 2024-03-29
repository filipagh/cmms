//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TaskComponentAddNewSchema {
  /// Returns a new [TaskComponentAddNewSchema] instance.
  TaskComponentAddNewSchema({
    required this.newAssetId,
    required this.warranty,
    this.replacedComponentId,
    this.serviceContractsId = const [],
  });

  String newAssetId;

  ComponentWarranty warranty;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? replacedComponentId;

  List<String> serviceContractsId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TaskComponentAddNewSchema &&
          other.newAssetId == newAssetId &&
          other.warranty == warranty &&
          other.replacedComponentId == replacedComponentId &&
          other.serviceContractsId == serviceContractsId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
      (newAssetId.hashCode) +
      (warranty.hashCode) +
      (replacedComponentId == null ? 0 : replacedComponentId!.hashCode) +
      (serviceContractsId.hashCode);

  @override
  String toString() =>
      'TaskComponentAddNewSchema[newAssetId=$newAssetId, warranty=$warranty, replacedComponentId=$replacedComponentId, serviceContractsId=$serviceContractsId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'new_asset_id'] = this.newAssetId;
    json[r'warranty'] = this.warranty;
    if (this.replacedComponentId != null) {
      json[r'replaced_component_id'] = this.replacedComponentId;
    } else {
      json[r'replaced_component_id'] = null;
    }
    json[r'service_contracts_id'] = this.serviceContractsId;
    return json;
  }

  /// Returns a new [TaskComponentAddNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TaskComponentAddNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TaskComponentAddNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TaskComponentAddNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TaskComponentAddNewSchema(
        newAssetId: mapValueOfType<String>(json, r'new_asset_id')!,
        warranty: ComponentWarranty.fromJson(json[r'warranty'])!,
        replacedComponentId:
            mapValueOfType<String>(json, r'replaced_component_id'),
        serviceContractsId: json[r'service_contracts_id'] is List
            ? (json[r'service_contracts_id'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<TaskComponentAddNewSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TaskComponentAddNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskComponentAddNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TaskComponentAddNewSchema> mapFromJson(dynamic json) {
    final map = <String, TaskComponentAddNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TaskComponentAddNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TaskComponentAddNewSchema-objects as value to a dart map
  static Map<String, List<TaskComponentAddNewSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TaskComponentAddNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TaskComponentAddNewSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'new_asset_id',
    'warranty',
    'service_contracts_id',
  };
}

