//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationSchema {
  /// Returns a new [StationSchema] instance.
  StationSchema({
    required this.name,
    required this.roadSegmentId,
  });

  String name;

  String roadSegmentId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationSchema &&
     other.name == name &&
     other.roadSegmentId == roadSegmentId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (roadSegmentId.hashCode);

  @override
  String toString() => 'StationSchema[name=$name, roadSegmentId=$roadSegmentId]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'name'] = name;
      _json[r'road_segment_id'] = roadSegmentId;
    return _json;
  }

  /// Returns a new [StationSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StationSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StationSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationSchema(
        name: mapValueOfType<String>(json, r'name')!,
        roadSegmentId: mapValueOfType<String>(json, r'road_segment_id')!,
      );
    }
    return null;
  }

  static List<StationSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StationSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationSchema> mapFromJson(dynamic json) {
    final map = <String, StationSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationSchema-objects as value to a dart map
  static Map<String, List<StationSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StationSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationSchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'road_segment_id',
  };
}

