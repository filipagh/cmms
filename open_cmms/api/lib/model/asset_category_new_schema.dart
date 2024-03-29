//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssetCategoryNewSchema {
  /// Returns a new [AssetCategoryNewSchema] instance.
  AssetCategoryNewSchema({
    this.parentId,
    required this.name,
    required this.description,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? parentId;

  String name;

  String description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssetCategoryNewSchema &&
     other.parentId == parentId &&
     other.name == name &&
     other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (parentId == null ? 0 : parentId!.hashCode) +
    (name.hashCode) +
    (description.hashCode);

  @override
  String toString() => 'AssetCategoryNewSchema[parentId=$parentId, name=$name, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.parentId != null) {
      json[r'parent_id'] = this.parentId;
    } else {
      json[r'parent_id'] = null;
    }
    json[r'name'] = this.name;
    json[r'description'] = this.description;
    return json;
  }

  /// Returns a new [AssetCategoryNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssetCategoryNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssetCategoryNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssetCategoryNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssetCategoryNewSchema(
        parentId: mapValueOfType<String>(json, r'parent_id'),
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
      );
    }
    return null;
  }

  static List<AssetCategoryNewSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AssetCategoryNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssetCategoryNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssetCategoryNewSchema> mapFromJson(dynamic json) {
    final map = <String, AssetCategoryNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssetCategoryNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssetCategoryNewSchema-objects as value to a dart map
  static Map<String, List<AssetCategoryNewSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssetCategoryNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssetCategoryNewSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'description',
  };
}

