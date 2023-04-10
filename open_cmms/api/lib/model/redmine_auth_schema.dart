//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RedmineAuthSchema {
  /// Returns a new [RedmineAuthSchema] instance.
  RedmineAuthSchema({
    required this.redmineUrl,
    required this.redmineApiKey,
  });

  String redmineUrl;

  String redmineApiKey;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RedmineAuthSchema &&
          other.redmineUrl == redmineUrl &&
          other.redmineApiKey == redmineApiKey;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (redmineUrl.hashCode) + (redmineApiKey.hashCode);

  @override
  String toString() =>
      'RedmineAuthSchema[redmineUrl=$redmineUrl, redmineApiKey=$redmineApiKey]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'redmine_url'] = redmineUrl;
    _json[r'redmine_api_key'] = redmineApiKey;
    return _json;
  }

  /// Returns a new [RedmineAuthSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RedmineAuthSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "RedmineAuthSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "RedmineAuthSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RedmineAuthSchema(
        redmineUrl: mapValueOfType<String>(json, r'redmine_url')!,
        redmineApiKey: mapValueOfType<String>(json, r'redmine_api_key')!,
      );
    }
    return null;
  }

  static List<RedmineAuthSchema>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RedmineAuthSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RedmineAuthSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RedmineAuthSchema> mapFromJson(dynamic json) {
    final map = <String, RedmineAuthSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineAuthSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RedmineAuthSchema-objects as value to a dart map
  static Map<String, List<RedmineAuthSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<RedmineAuthSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineAuthSchema.listFromJson(
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
  };
}
