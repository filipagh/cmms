//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RedmineCommentDataSchema {
  /// Returns a new [RedmineCommentDataSchema] instance.
  RedmineCommentDataSchema({
    required this.comment,
    required this.author,
    required this.createdOn,
  });

  String comment;

  String author;

  DateTime createdOn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RedmineCommentDataSchema &&
     other.comment == comment &&
     other.author == author &&
     other.createdOn == createdOn;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (comment.hashCode) +
    (author.hashCode) +
    (createdOn.hashCode);

  @override
  String toString() => 'RedmineCommentDataSchema[comment=$comment, author=$author, createdOn=$createdOn]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'comment'] = this.comment;
    json[r'author'] = this.author;
    json[r'created_on'] = this.createdOn.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [RedmineCommentDataSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RedmineCommentDataSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RedmineCommentDataSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RedmineCommentDataSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RedmineCommentDataSchema(
        comment: mapValueOfType<String>(json, r'comment')!,
        author: mapValueOfType<String>(json, r'author')!,
        createdOn: mapDateTime(json, r'created_on', '')!,
      );
    }
    return null;
  }

  static List<RedmineCommentDataSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RedmineCommentDataSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RedmineCommentDataSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RedmineCommentDataSchema> mapFromJson(dynamic json) {
    final map = <String, RedmineCommentDataSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RedmineCommentDataSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RedmineCommentDataSchema-objects as value to a dart map
  static Map<String, List<RedmineCommentDataSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RedmineCommentDataSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RedmineCommentDataSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'comment',
    'author',
    'created_on',
  };
}

