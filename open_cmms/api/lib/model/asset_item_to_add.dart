//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssetItemToAdd {
  /// Returns a new [AssetItemToAdd] instance.
  AssetItemToAdd({
    required this.storageItemId,
    required this.countToAdd,
  });

  String storageItemId;

  int countToAdd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssetItemToAdd &&
     other.storageItemId == storageItemId &&
     other.countToAdd == countToAdd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (storageItemId.hashCode) +
    (countToAdd.hashCode);

  @override
  String toString() => 'AssetItemToAdd[storageItemId=$storageItemId, countToAdd=$countToAdd]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'storage_item_id'] = storageItemId;
      _json[r'count_to_add'] = countToAdd;
    return _json;
  }

  /// Returns a new [AssetItemToAdd] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssetItemToAdd? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssetItemToAdd[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssetItemToAdd[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssetItemToAdd(
        storageItemId: mapValueOfType<String>(json, r'storage_item_id')!,
        countToAdd: mapValueOfType<int>(json, r'count_to_add')!,
      );
    }
    return null;
  }

  static List<AssetItemToAdd>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssetItemToAdd>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssetItemToAdd.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssetItemToAdd> mapFromJson(dynamic json) {
    final map = <String, AssetItemToAdd>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssetItemToAdd.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssetItemToAdd-objects as value to a dart map
  static Map<String, List<AssetItemToAdd>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssetItemToAdd>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssetItemToAdd.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'storage_item_id',
    'count_to_add',
  };
}

