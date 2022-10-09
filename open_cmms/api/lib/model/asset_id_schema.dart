//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssetIdSchema {
  /// Returns a new [AssetIdSchema] instance.
  AssetIdSchema({
    required this.id,
  });

  String id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssetIdSchema &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode);

  @override
  String toString() => 'AssetIdSchema[id=$id]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'id'] = id;
    return _json;
  }

  /// Returns a new [AssetIdSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssetIdSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssetIdSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssetIdSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssetIdSchema(
        id: mapValueOfType<String>(json, r'id')!,
      );
    }
    return null;
  }

  static List<AssetIdSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssetIdSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssetIdSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssetIdSchema> mapFromJson(dynamic json) {
    final map = <String, AssetIdSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssetIdSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssetIdSchema-objects as value to a dart map
  static Map<String, List<AssetIdSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssetIdSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssetIdSchema.listFromJson(entry.value, growable: growable,);
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
  };
}

