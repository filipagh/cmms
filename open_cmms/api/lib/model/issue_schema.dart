//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IssueSchema {
  /// Returns a new [IssueSchema] instance.
  IssueSchema({
    required this.username,
    required this.subject,
    required this.description,
    required this.stationId,
    required this.roadSegmentId,
    required this.id,
    required this.isExternal,
    required this.createdOn,
    required this.active,
    required this.stationName,
    required this.roadSegmentName,
  });

  String username;

  String subject;

  String description;

  String stationId;

  String roadSegmentId;

  String id;

  bool isExternal;

  DateTime createdOn;

  bool active;

  String stationName;

  String roadSegmentName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueSchema &&
          other.username == username &&
          other.subject == subject &&
          other.description == description &&
          other.stationId == stationId &&
          other.roadSegmentId == roadSegmentId &&
          other.id == id &&
          other.isExternal == isExternal &&
          other.createdOn == createdOn &&
          other.active == active &&
          other.stationName == stationName &&
          other.roadSegmentName == roadSegmentName;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (username.hashCode) +
      (subject.hashCode) +
      (description.hashCode) +
      (stationId.hashCode) +
      (roadSegmentId.hashCode) +
      (id.hashCode) +
      (isExternal.hashCode) +
      (createdOn.hashCode) +
      (active.hashCode) +
      (stationName.hashCode) +
      (roadSegmentName.hashCode);

  @override
  String toString() =>
      'IssueSchema[username=$username, subject=$subject, description=$description, stationId=$stationId, roadSegmentId=$roadSegmentId, id=$id, isExternal=$isExternal, createdOn=$createdOn, active=$active, stationName=$stationName, roadSegmentName=$roadSegmentName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'username'] = this.username;
    json[r'subject'] = this.subject;
    json[r'description'] = this.description;
    json[r'station_id'] = this.stationId;
    json[r'road_segment_id'] = this.roadSegmentId;
    json[r'id'] = this.id;
    json[r'is_external'] = this.isExternal;
    json[r'created_on'] = this.createdOn.toUtc().toIso8601String();
    json[r'active'] = this.active;
    json[r'station_name'] = this.stationName;
    json[r'road_segment_name'] = this.roadSegmentName;
    return json;
  }

  /// Returns a new [IssueSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IssueSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "IssueSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "IssueSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IssueSchema(
        username: mapValueOfType<String>(json, r'username')!,
        subject: mapValueOfType<String>(json, r'subject')!,
        description: mapValueOfType<String>(json, r'description')!,
        stationId: mapValueOfType<String>(json, r'station_id')!,
        roadSegmentId: mapValueOfType<String>(json, r'road_segment_id')!,
        id: mapValueOfType<String>(json, r'id')!,
        isExternal: mapValueOfType<bool>(json, r'is_external')!,
        createdOn: mapDateTime(json, r'created_on', '')!,
        active: mapValueOfType<bool>(json, r'active')!,
        stationName: mapValueOfType<String>(json, r'station_name')!,
        roadSegmentName: mapValueOfType<String>(json, r'road_segment_name')!,
      );
    }
    return null;
  }

  static List<IssueSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <IssueSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IssueSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IssueSchema> mapFromJson(dynamic json) {
    final map = <String, IssueSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IssueSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IssueSchema-objects as value to a dart map
  static Map<String, List<IssueSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<IssueSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IssueSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'username',
    'subject',
    'description',
    'station_id',
    'road_segment_id',
    'id',
    'is_external',
    'created_on',
    'active',
    'station_name',
    'road_segment_name',
  };
}

