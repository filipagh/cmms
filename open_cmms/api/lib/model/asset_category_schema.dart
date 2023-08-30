//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssetCategorySchema {
  /// Returns a new [AssetCategorySchema] instance.
  AssetCategorySchema({
    this.parentId,
    required this.name,
    required this.description,
    required this.id,
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

  String id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssetCategorySchema &&
     other.parentId == parentId &&
     other.name == name &&
     other.description == description &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (parentId == null ? 0 : parentId!.hashCode) +
    (name.hashCode) +
    (description.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'AssetCategorySchema[parentId=$parentId, name=$name, description=$description, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.parentId != null) {
      json[r'parent_id'] = this.parentId;
    } else {
      json[r'parent_id'] = null;
    }
    json[r'name'] = this.name;
    json[r'description'] = this.description;
    json[r'id'] = this.id;
    return json;
  }

  /// Returns a new [AssetCategorySchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssetCategorySchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssetCategorySchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssetCategorySchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssetCategorySchema(
        parentId: mapValueOfType<String>(json, r'parent_id'),
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        id: mapValueOfType<String>(json, r'id')!,
      );
    }
    return null;
  }

  static List<AssetCategorySchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AssetCategorySchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssetCategorySchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssetCategorySchema> mapFromJson(dynamic json) {
    final map = <String, AssetCategorySchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssetCategorySchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssetCategorySchema-objects as value to a dart map
  static Map<String, List<AssetCategorySchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssetCategorySchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssetCategorySchema.listFromJson(
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
    'id',
  };
}

