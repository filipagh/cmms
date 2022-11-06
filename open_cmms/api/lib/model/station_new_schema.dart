//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationNewSchema {
  /// Returns a new [StationNewSchema] instance.
  StationNewSchema({
    required this.name,
    required this.roadSegmentId,
  });

  String name;

  String roadSegmentId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationNewSchema &&
     other.name == name &&
     other.roadSegmentId == roadSegmentId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (roadSegmentId.hashCode);

  @override
  String toString() => 'StationNewSchema[name=$name, roadSegmentId=$roadSegmentId]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'name'] = name;
      _json[r'road_segment_id'] = roadSegmentId;
    return _json;
  }

  /// Returns a new [StationNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StationNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StationNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationNewSchema(
        name: mapValueOfType<String>(json, r'name')!,
        roadSegmentId: mapValueOfType<String>(json, r'road_segment_id')!,
      );
    }
    return null;
  }

  static List<StationNewSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StationNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationNewSchema> mapFromJson(dynamic json) {
    final map = <String, StationNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationNewSchema-objects as value to a dart map
  static Map<String, List<StationNewSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StationNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationNewSchema.listFromJson(entry.value, growable: growable,);
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

