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
    this.kmOfRoad,
    required this.kmOfRoadNote,
    this.latitude,
    this.longitude,
    this.seeLevel,
    required this.description,
    required this.id,
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

  String id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationSchema &&
          other.name == name &&
          other.roadSegmentId == roadSegmentId &&
          other.kmOfRoad == kmOfRoad &&
          other.kmOfRoadNote == kmOfRoadNote &&
          other.latitude == latitude &&
          other.longitude == longitude &&
          other.seeLevel == seeLevel &&
          other.description == description &&
          other.id == id;

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
      (description.hashCode) +
      (id.hashCode);

  @override
  String toString() =>
      'StationSchema[name=$name, roadSegmentId=$roadSegmentId, kmOfRoad=$kmOfRoad, kmOfRoadNote=$kmOfRoadNote, latitude=$latitude, longitude=$longitude, seeLevel=$seeLevel, description=$description, id=$id]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'name'] = name;
    _json[r'road_segment_id'] = roadSegmentId;
    if (kmOfRoad != null) {
      _json[r'km_of_road'] = kmOfRoad;
    }
    _json[r'km_of_road_note'] = kmOfRoadNote;
    if (latitude != null) {
      _json[r'latitude'] = latitude;
    }
    if (longitude != null) {
      _json[r'longitude'] = longitude;
    }
    if (seeLevel != null) {
      _json[r'see_level'] = seeLevel;
    }
    _json[r'description'] = description;
    _json[r'id'] = id;
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
        id: mapValueOfType<String>(json, r'id')!,
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
    'km_of_road_note',
    'description',
    'id',
  };
}

