//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RedmineSetupRequestSchema {
  /// Returns a new [RedmineSetupRequestSchema] instance.
  RedmineSetupRequestSchema({
    required this.redmineUrl,
    required this.redmineApiKey,
    required this.redmineProjectId,
    required this.redmineTrackerId,
    required this.redmineSupervisorId,
  });

  String redmineUrl;

  String redmineApiKey;

  String redmineProjectId;

  String redmineTrackerId;

  String redmineSupervisorId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RedmineSetupRequestSchema &&
     other.redmineUrl == redmineUrl &&
     other.redmineApiKey == redmineApiKey &&
     other.redmineProjectId == redmineProjectId &&
     other.redmineTrackerId == redmineTrackerId &&
     other.redmineSupervisorId == redmineSupervisorId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (redmineUrl.hashCode) +
    (redmineApiKey.hashCode) +
    (redmineProjectId.hashCode) +
    (redmineTrackerId.hashCode) +
    (redmineSupervisorId.hashCode);

  @override
  String toString() => 'RedmineSetupRequestSchema[redmineUrl=$redmineUrl, redmineApiKey=$redmineApiKey, redmineProjectId=$redmineProjectId, redmineTrackerId=$redmineTrackerId, redmineSupervisorId=$redmineSupervisorId]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'redmine_url'] = redmineUrl;
      _json[r'redmine_api_key'] = redmineApiKey;
      _json[r'redmine_project_id'] = redmineProjectId;
      _json[r'redmine_tracker_id'] = redmineTrackerId;
      _json[r'redmine_supervisor_id'] = redmineSupervisorId;
    return _json;
  }

  /// Returns a new [RedmineSetupRequestSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RedmineSetupRequestSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RedmineSetupRequestSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RedmineSetupRequestSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RedmineSetupRequestSchema(
        redmineUrl: mapValueOfType<String>(json, r'redmine_url')!,
        redmineApiKey: mapValueOfType<String>(json, r'redmine_api_key')!,
        redmineProjectId: mapValueOfType<String>(json, r'redmine_project_id')!,
        redmineTrackerId: mapValueOfType<String>(json, r'redmine_tracker_id')!,
        redmineSupervisorId: mapValueOfType<String>(json, r'redmine_supervisor_id')!,
      );
    }
    return null;
  }

  static List<RedmineSetupRequestSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RedmineSetupRequestSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RedmineSetupRequestSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RedmineSetupRequestSchema> mapFromJson(dynamic json) {
    final map = <String, RedmineSetupRequestSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineSetupRequestSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RedmineSetupRequestSchema-objects as value to a dart map
  static Map<String, List<RedmineSetupRequestSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RedmineSetupRequestSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineSetupRequestSchema.listFromJson(entry.value, growable: growable,);
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
    'redmine_project_id',
    'redmine_tracker_id',
    'redmine_supervisor_id',
  };
}

