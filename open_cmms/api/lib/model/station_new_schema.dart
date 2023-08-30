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
    this.kmOfRoad,
    required this.kmOfRoadNote,
    this.latitude,
    this.longitude,
    this.seeLevel,
    required this.description,
  });

  String name;

  String roadSegmentId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? kmOfRoad;

  String kmOfRoadNote;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? latitude;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? longitude;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? seeLevel;

  String description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StationNewSchema &&
     other.name == name &&
     other.roadSegmentId == roadSegmentId &&
     other.kmOfRoad == kmOfRoad &&
     other.kmOfRoadNote == kmOfRoadNote &&
     other.latitude == latitude &&
     other.longitude == longitude &&
     other.seeLevel == seeLevel &&
     other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (roadSegmentId.hashCode) +
    (kmOfRoad == null ? 0 : kmOfRoad!.hashCode) +
    (kmOfRoadNote.hashCode) +
    (latitude == null ? 0 : latitude!.hashCode) +
    (longitude == null ? 0 : longitude!.hashCode) +
    (seeLevel == null ? 0 : seeLevel!.hashCode) +
    (description.hashCode);

  @override
  String toString() => 'StationNewSchema[name=$name, roadSegmentId=$roadSegmentId, kmOfRoad=$kmOfRoad, kmOfRoadNote=$kmOfRoadNote, latitude=$latitude, longitude=$longitude, seeLevel=$seeLevel, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'name'] = this.name;
    json[r'road_segment_id'] = this.roadSegmentId;
    if (this.kmOfRoad != null) {
      json[r'km_of_road'] = this.kmOfRoad;
    } else {
      json[r'km_of_road'] = null;
    }
    json[r'km_of_road_note'] = this.kmOfRoadNote;
    if (this.latitude != null) {
      json[r'latitude'] = this.latitude;
    } else {
      json[r'latitude'] = null;
    }
    if (this.longitude != null) {
      json[r'longitude'] = this.longitude;
    } else {
      json[r'longitude'] = null;
    }
    if (this.seeLevel != null) {
      json[r'see_level'] = this.seeLevel;
    } else {
      json[r'see_level'] = null;
    }
    json[r'description'] = this.description;
    return json;
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
        kmOfRoad: json[r'km_of_road'] == null
            ? null
            : num.parse(json[r'km_of_road'].toString()),
        kmOfRoadNote: mapValueOfType<String>(json, r'km_of_road_note')!,
        latitude: json[r'latitude'] == null
            ? null
            : num.parse(json[r'latitude'].toString()),
        longitude: json[r'longitude'] == null
            ? null
            : num.parse(json[r'longitude'].toString()),
        seeLevel: mapValueOfType<int>(json, r'see_level'),
        description: mapValueOfType<String>(json, r'description')!,
      );
    }
    return null;
  }

  static List<StationNewSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
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
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StationNewSchema.listFromJson(
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
    'km_of_road_note',
    'description',
  };
}

