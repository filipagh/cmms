//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AddComponentRequestSchema {
  /// Returns a new [AddComponentRequestSchema] instance.
  AddComponentRequestSchema({
    required this.newAssetId,
    this.assignedComponent,
    required this.state,
  });

  String newAssetId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? assignedComponent;

  TaskComponentState state;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddComponentRequestSchema &&
     other.newAssetId == newAssetId &&
     other.assignedComponent == assignedComponent &&
     other.state == state;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (newAssetId.hashCode) +
    (assignedComponent == null ? 0 : assignedComponent!.hashCode) +
    (state.hashCode);

  @override
  String toString() => 'AddComponentRequestSchema[newAssetId=$newAssetId, assignedComponent=$assignedComponent, state=$state]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'new_asset_id'] = newAssetId;
    if (assignedComponent != null) {
      _json[r'assigned_component'] = assignedComponent;
    }
      _json[r'state'] = state;
    return _json;
  }

  /// Returns a new [AddComponentRequestSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AddComponentRequestSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AddComponentRequestSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AddComponentRequestSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AddComponentRequestSchema(
        newAssetId: mapValueOfType<String>(json, r'new_asset_id')!,
        assignedComponent: mapValueOfType<String>(json, r'assigned_component'),
        state: TaskComponentState.fromJson(json[r'state'])!,
      );
    }
    return null;
  }

  static List<AddComponentRequestSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AddComponentRequestSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AddComponentRequestSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AddComponentRequestSchema> mapFromJson(dynamic json) {
    final map = <String, AddComponentRequestSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddComponentRequestSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AddComponentRequestSchema-objects as value to a dart map
  static Map<String, List<AddComponentRequestSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AddComponentRequestSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddComponentRequestSchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'new_asset_id',
    'state',
  };
}

