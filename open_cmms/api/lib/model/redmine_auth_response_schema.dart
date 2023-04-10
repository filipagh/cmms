//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RedmineAuthResponseSchema {
  /// Returns a new [RedmineAuthResponseSchema] instance.
  RedmineAuthResponseSchema({
    required this.redmineUrl,
    required this.redmineApiKey,
    this.projects = const [],
    this.trackers = const [],
    this.users = const [],
  });

  String redmineUrl;

  String redmineApiKey;

  List<RedmineObjectSchema> projects;

  List<RedmineObjectSchema> trackers;

  List<RedmineObjectSchema> users;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RedmineAuthResponseSchema &&
          other.redmineUrl == redmineUrl &&
          other.redmineApiKey == redmineApiKey &&
          other.projects == projects &&
          other.trackers == trackers &&
          other.users == users;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (redmineUrl.hashCode) +
      (redmineApiKey.hashCode) +
      (projects.hashCode) +
      (trackers.hashCode) +
      (users.hashCode);

  @override
  String toString() =>
      'RedmineAuthResponseSchema[redmineUrl=$redmineUrl, redmineApiKey=$redmineApiKey, projects=$projects, trackers=$trackers, users=$users]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'redmine_url'] = redmineUrl;
    _json[r'redmine_api_key'] = redmineApiKey;
    _json[r'projects'] = projects;
    _json[r'trackers'] = trackers;
    _json[r'users'] = users;
    return _json;
  }

  /// Returns a new [RedmineAuthResponseSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RedmineAuthResponseSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "RedmineAuthResponseSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "RedmineAuthResponseSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RedmineAuthResponseSchema(
        redmineUrl: mapValueOfType<String>(json, r'redmine_url')!,
        redmineApiKey: mapValueOfType<String>(json, r'redmine_api_key')!,
        projects: RedmineObjectSchema.listFromJson(json[r'projects'])!,
        trackers: RedmineObjectSchema.listFromJson(json[r'trackers'])!,
        users: RedmineObjectSchema.listFromJson(json[r'users'])!,
      );
    }
    return null;
  }

  static List<RedmineAuthResponseSchema>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RedmineAuthResponseSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RedmineAuthResponseSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RedmineAuthResponseSchema> mapFromJson(dynamic json) {
    final map = <String, RedmineAuthResponseSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineAuthResponseSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RedmineAuthResponseSchema-objects as value to a dart map
  static Map<String, List<RedmineAuthResponseSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<RedmineAuthResponseSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineAuthResponseSchema.listFromJson(
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
    'redmine_url',
    'redmine_api_key',
    'projects',
    'trackers',
    'users',
  };
}
