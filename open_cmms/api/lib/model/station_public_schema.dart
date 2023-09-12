//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StationPublicSchema {
  /// Returns a new [StationPublicSchema] instance.
  StationPublicSchema({
    required this.name,
    required this.roadSegmentId,
    required this.id,
    this.kmOfRoad,
  });

  String name;

  String roadSegmentId;

  String id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? kmOfRoad;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationPublicSchema &&
          other.name == name &&
          other.roadSegmentId == roadSegmentId &&
          other.id == id &&
          other.kmOfRoad == kmOfRoad;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name.hashCode) +
      (roadSegmentId.hashCode) +
      (id.hashCode) +
      (kmOfRoad == null ? 0 : kmOfRoad!.hashCode);

  @override
  String toString() =>
      'StationPublicSchema[name=$name, roadSegmentId=$roadSegmentId, id=$id, kmOfRoad=$kmOfRoad]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'name'] = this.name;
    json[r'road_segment_id'] = this.roadSegmentId;
    json[r'id'] = this.id;
    if (this.kmOfRoad != null) {
      json[r'km_of_road'] = this.kmOfRoad;
    } else {
      json[r'km_of_road'] = null;
    }
    return json;
  }

  /// Returns a new [StationPublicSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StationPublicSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "StationPublicSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "StationPublicSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StationPublicSchema(
        name: mapValueOfType<String>(json, r'name')!,
        roadSegmentId: mapValueOfType<String>(json, r'road_segment_id')!,
        id: mapValueOfType<String>(json, r'id')!,
        kmOfRoad: json[r'km_of_road'] == null
            ? null
            : num.parse(json[r'km_of_road'].toString()),
      );
    }
    return null;
  }

  static List<StationPublicSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <StationPublicSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StationPublicSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StationPublicSchema> mapFromJson(dynamic json) {
    final map = <String, StationPublicSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StationPublicSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StationPublicSchema-objects as value to a dart map
  static Map<String, List<StationPublicSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<StationPublicSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StationPublicSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'road_segment_id',
    'id',
  };
}

