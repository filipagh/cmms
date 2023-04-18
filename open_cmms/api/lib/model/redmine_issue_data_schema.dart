//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RedmineIssueDataSchema {
  /// Returns a new [RedmineIssueDataSchema] instance.
  RedmineIssueDataSchema({
    required this.taskId,
    required this.description,
    required this.assignedTo,
    required this.linkToRedmine,
    this.comments = const [],
  });

  int taskId;

  String description;

  String assignedTo;

  String linkToRedmine;

  List<RedmineCommentDataSchema> comments;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RedmineIssueDataSchema &&
     other.taskId == taskId &&
     other.description == description &&
     other.assignedTo == assignedTo &&
     other.linkToRedmine == linkToRedmine &&
     other.comments == comments;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (taskId.hashCode) +
    (description.hashCode) +
    (assignedTo.hashCode) +
    (linkToRedmine.hashCode) +
    (comments.hashCode);

  @override
  String toString() => 'RedmineIssueDataSchema[taskId=$taskId, description=$description, assignedTo=$assignedTo, linkToRedmine=$linkToRedmine, comments=$comments]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'task_id'] = taskId;
      _json[r'description'] = description;
      _json[r'assigned_to'] = assignedTo;
      _json[r'link_to_redmine'] = linkToRedmine;
      _json[r'comments'] = comments;
    return _json;
  }

  /// Returns a new [RedmineIssueDataSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RedmineIssueDataSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RedmineIssueDataSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RedmineIssueDataSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RedmineIssueDataSchema(
        taskId: mapValueOfType<int>(json, r'task_id')!,
        description: mapValueOfType<String>(json, r'description')!,
        assignedTo: mapValueOfType<String>(json, r'assigned_to')!,
        linkToRedmine: mapValueOfType<String>(json, r'link_to_redmine')!,
        comments: RedmineCommentDataSchema.listFromJson(json[r'comments'])!,
      );
    }
    return null;
  }

  static List<RedmineIssueDataSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RedmineIssueDataSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RedmineIssueDataSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RedmineIssueDataSchema> mapFromJson(dynamic json) {
    final map = <String, RedmineIssueDataSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineIssueDataSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RedmineIssueDataSchema-objects as value to a dart map
  static Map<String, List<RedmineIssueDataSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RedmineIssueDataSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineIssueDataSchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'task_id',
    'description',
    'assigned_to',
    'link_to_redmine',
    'comments',
  };
}

