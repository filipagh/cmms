//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StorageItemOverrideSchema {
  /// Returns a new [StorageItemOverrideSchema] instance.
  StorageItemOverrideSchema({
    required this.reason,
    required this.id,
    required this.newCount,
  });

  String reason;

  String id;

  int newCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StorageItemOverrideSchema &&
          other.reason == reason &&
          other.id == id &&
          other.newCount == newCount;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (reason.hashCode) + (id.hashCode) + (newCount.hashCode);

  @override
  String toString() =>
      'StorageItemOverrideSchema[reason=$reason, id=$id, newCount=$newCount]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'reason'] = reason;
    _json[r'id'] = id;
    _json[r'new_count'] = newCount;
    return _json;
  }

  /// Returns a new [StorageItemOverrideSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StorageItemOverrideSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "StorageItemOverrideSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "StorageItemOverrideSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StorageItemOverrideSchema(
        reason: mapValueOfType<String>(json, r'reason')!,
        id: mapValueOfType<String>(json, r'id')!,
        newCount: mapValueOfType<int>(json, r'new_count')!,
      );
    }
    return null;
  }

  static List<StorageItemOverrideSchema>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <StorageItemOverrideSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StorageItemOverrideSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StorageItemOverrideSchema> mapFromJson(dynamic json) {
    final map = <String, StorageItemOverrideSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StorageItemOverrideSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StorageItemOverrideSchema-objects as value to a dart map
  static Map<String, List<StorageItemOverrideSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<StorageItemOverrideSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StorageItemOverrideSchema.listFromJson(
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
    'reason',
    'id',
    'new_count',
  };
}
