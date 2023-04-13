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
    required this.id,
    required this.subject,
    required this.description,
    this.stationId,
    this.componentId,
    required this.user,
    required this.createdOn,
    required this.active,
  });

  String id;

  String subject;

  String description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? stationId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? componentId;

  String user;

  DateTime createdOn;

  bool active;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IssueSchema &&
          other.id == id &&
          other.subject == subject &&
          other.description == description &&
          other.stationId == stationId &&
          other.componentId == componentId &&
          other.user == user &&
          other.createdOn == createdOn &&
          other.active == active;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (subject.hashCode) +
      (description.hashCode) +
      (stationId == null ? 0 : stationId!.hashCode) +
      (componentId == null ? 0 : componentId!.hashCode) +
      (user.hashCode) +
      (createdOn.hashCode) +
      (active.hashCode);

  @override
  String toString() =>
      'IssueSchema[id=$id, subject=$subject, description=$description, stationId=$stationId, componentId=$componentId, user=$user, createdOn=$createdOn, active=$active]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'id'] = id;
    _json[r'subject'] = subject;
    _json[r'description'] = description;
    if (stationId != null) {
      _json[r'station_id'] = stationId;
    }
    if (componentId != null) {
      _json[r'component_id'] = componentId;
    }
    _json[r'user'] = user;
    _json[r'created_on'] = createdOn.toUtc().toIso8601String();
    _json[r'active'] = active;
    return _json;
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
          assert(json.containsKey(key),
              'Required key "IssueSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "IssueSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IssueSchema(
        id: mapValueOfType<String>(json, r'id')!,
        subject: mapValueOfType<String>(json, r'subject')!,
        description: mapValueOfType<String>(json, r'description')!,
        stationId: mapValueOfType<String>(json, r'station_id'),
        componentId: mapValueOfType<String>(json, r'component_id'),
        user: mapValueOfType<String>(json, r'user')!,
        createdOn: mapDateTime(json, r'created_on', '')!,
        active: mapValueOfType<bool>(json, r'active')!,
      );
    }
    return null;
  }

  static List<IssueSchema>? listFromJson(
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
  static Map<String, List<IssueSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<IssueSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IssueSchema.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'subject',
    'description',
    'user',
    'created_on',
    'active',
  };
}
