//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssignedComponentSchema {
  /// Returns a new [AssignedComponentSchema] instance.
  AssignedComponentSchema({
    required this.assetId,
    required this.stationId,
    required this.id,
  });

  String assetId;

  String stationId;

  String id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssignedComponentSchema &&
     other.assetId == assetId &&
     other.stationId == stationId &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (assetId.hashCode) +
    (stationId.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'AssignedComponentSchema[assetId=$assetId, stationId=$stationId, id=$id]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'asset_id'] = assetId;
      _json[r'station_id'] = stationId;
      _json[r'id'] = id;
    return _json;
  }

  /// Returns a new [AssignedComponentSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssignedComponentSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssignedComponentSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssignedComponentSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssignedComponentSchema(
        assetId: mapValueOfType<String>(json, r'asset_id')!,
        stationId: mapValueOfType<String>(json, r'station_id')!,
        id: mapValueOfType<String>(json, r'id')!,
      );
    }
    return null;
  }

  static List<AssignedComponentSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssignedComponentSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssignedComponentSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssignedComponentSchema> mapFromJson(dynamic json) {
    final map = <String, AssignedComponentSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssignedComponentSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssignedComponentSchema-objects as value to a dart map
  static Map<String, List<AssignedComponentSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssignedComponentSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssignedComponentSchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'asset_id',
    'station_id',
    'id',
  };
}

