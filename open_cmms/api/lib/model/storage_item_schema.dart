//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StorageItemSchema {
  /// Returns a new [StorageItemSchema] instance.
  StorageItemSchema({
    this.assetId,
    required this.inStorage,
    required this.allocated,
    required this.id,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? assetId;

  int inStorage;

  int allocated;

  String id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StorageItemSchema &&
     other.assetId == assetId &&
     other.inStorage == inStorage &&
     other.allocated == allocated &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (assetId == null ? 0 : assetId!.hashCode) +
    (inStorage.hashCode) +
    (allocated.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'StorageItemSchema[assetId=$assetId, inStorage=$inStorage, allocated=$allocated, id=$id]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (assetId != null) {
      _json[r'asset_id'] = assetId;
    }
      _json[r'in_storage'] = inStorage;
      _json[r'allocated'] = allocated;
      _json[r'id'] = id;
    return _json;
  }

  /// Returns a new [StorageItemSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StorageItemSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StorageItemSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StorageItemSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StorageItemSchema(
        assetId: mapValueOfType<String>(json, r'asset_id'),
        inStorage: mapValueOfType<int>(json, r'in_storage')!,
        allocated: mapValueOfType<int>(json, r'allocated')!,
        id: mapValueOfType<String>(json, r'id')!,
      );
    }
    return null;
  }

  static List<StorageItemSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StorageItemSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StorageItemSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StorageItemSchema> mapFromJson(dynamic json) {
    final map = <String, StorageItemSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StorageItemSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StorageItemSchema-objects as value to a dart map
  static Map<String, List<StorageItemSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StorageItemSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StorageItemSchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'in_storage',
    'allocated',
    'id',
  };
}

