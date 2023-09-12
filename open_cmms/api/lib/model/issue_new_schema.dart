//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IssueNewSchema {
  /// Returns a new [IssueNewSchema] instance.
  IssueNewSchema({
    required this.username,
    required this.subject,
    required this.description,
    required this.stationId,
    required this.roadSegmentId,
  });

  String username;

  String subject;

  String description;

  String stationId;

  String roadSegmentId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueNewSchema &&
          other.username == username &&
          other.subject == subject &&
          other.description == description &&
          other.stationId == stationId &&
          other.roadSegmentId == roadSegmentId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (username.hashCode) +
      (subject.hashCode) +
      (description.hashCode) +
      (stationId.hashCode) +
      (roadSegmentId.hashCode);

  @override
  String toString() =>
      'IssueNewSchema[username=$username, subject=$subject, description=$description, stationId=$stationId, roadSegmentId=$roadSegmentId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'username'] = this.username;
    json[r'subject'] = this.subject;
    json[r'description'] = this.description;
    json[r'station_id'] = this.stationId;
    json[r'road_segment_id'] = this.roadSegmentId;
    return json;
  }

  /// Returns a new [IssueNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IssueNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "IssueNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "IssueNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IssueNewSchema(
        username: mapValueOfType<String>(json, r'username')!,
        subject: mapValueOfType<String>(json, r'subject')!,
        description: mapValueOfType<String>(json, r'description')!,
        stationId: mapValueOfType<String>(json, r'station_id')!,
        roadSegmentId: mapValueOfType<String>(json, r'road_segment_id')!,
      );
    }
    return null;
  }

  static List<IssueNewSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <IssueNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = IssueNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IssueNewSchema> mapFromJson(dynamic json) {
    final map = <String, IssueNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IssueNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IssueNewSchema-objects as value to a dart map
  static Map<String, List<IssueNewSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<IssueNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = IssueNewSchema.listFromJson(
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
  };
}

