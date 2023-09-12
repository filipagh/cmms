//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationRelocateSchema {
  /// Returns a new [StationRelocateSchema] instance.
  StationRelocateSchema({
    required this.stationId,
    required this.newRoadSegmentId,
  });

  String stationId;

  String newRoadSegmentId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationRelocateSchema &&
          other.stationId == stationId &&
          other.newRoadSegmentId == newRoadSegmentId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (stationId.hashCode) + (newRoadSegmentId.hashCode);

  @override
  String toString() =>
      'StationRelocateSchema[stationId=$stationId, newRoadSegmentId=$newRoadSegmentId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'station_id'] = this.stationId;
    json[r'new_road_segment_id'] = this.newRoadSegmentId;
    return json;
  }

  /// Returns a new [StationRelocateSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationRelocateSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "StationRelocateSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "StationRelocateSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationRelocateSchema(
        stationId: mapValueOfType<String>(json, r'station_id')!,
        newRoadSegmentId: mapValueOfType<String>(json, r'new_road_segment_id')!,
      );
    }
    return null;
  }

  static List<StationRelocateSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <StationRelocateSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationRelocateSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationRelocateSchema> mapFromJson(dynamic json) {
    final map = <String, StationRelocateSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationRelocateSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationRelocateSchema-objects as value to a dart map
  static Map<String, List<StationRelocateSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<StationRelocateSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StationRelocateSchema.listFromJson(
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
    'new_road_segment_id',
  };
}

