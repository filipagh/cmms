//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssignedComponentNewSchema {
  /// Returns a new [AssignedComponentNewSchema] instance.
  AssignedComponentNewSchema({
    required this.assetId,
    required this.stationId,
  });

  String assetId;

  String stationId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssignedComponentNewSchema &&
     other.assetId == assetId &&
     other.stationId == stationId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (assetId.hashCode) +
    (stationId.hashCode);

  @override
  String toString() => 'AssignedComponentNewSchema[assetId=$assetId, stationId=$stationId]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'asset_id'] = assetId;
      _json[r'station_id'] = stationId;
    return _json;
  }

  /// Returns a new [AssignedComponentNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssignedComponentNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssignedComponentNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssignedComponentNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssignedComponentNewSchema(
        assetId: mapValueOfType<String>(json, r'asset_id')!,
        stationId: mapValueOfType<String>(json, r'station_id')!,
      );
    }
    return null;
  }

  static List<AssignedComponentNewSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssignedComponentNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssignedComponentNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssignedComponentNewSchema> mapFromJson(dynamic json) {
    final map = <String, AssignedComponentNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssignedComponentNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssignedComponentNewSchema-objects as value to a dart map
  static Map<String, List<AssignedComponentNewSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssignedComponentNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssignedComponentNewSchema.listFromJson(entry.value, growable: growable,);
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
  };
}

