//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserSchema {
  /// Returns a new [UserSchema] instance.
  UserSchema({
    required this.id,
    required this.name,
    required this.isVerified,
    required this.isAdmin,
    required this.role,
  });

  String id;

  String name;

  bool isVerified;

  bool isAdmin;

  Role role;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSchema &&
          other.id == id &&
          other.name == name &&
          other.isVerified == isVerified &&
          other.isAdmin == isAdmin &&
          other.role == role;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (id.hashCode) +
      (name.hashCode) +
      (isVerified.hashCode) +
      (isAdmin.hashCode) +
      (role.hashCode);

  @override
  String toString() =>
      'UserSchema[id=$id, name=$name, isVerified=$isVerified, isAdmin=$isAdmin, role=$role]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'id'] = id;
    _json[r'name'] = name;
    _json[r'isVerified'] = isVerified;
    _json[r'isAdmin'] = isAdmin;
    _json[r'role'] = role;
    return _json;
  }

  /// Returns a new [UserSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserSchema(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        isVerified: mapValueOfType<bool>(json, r'isVerified')!,
        isAdmin: mapValueOfType<bool>(json, r'isAdmin')!,
        role: Role.fromJson(json[r'role'])!,
      );
    }
    return null;
  }

  static List<UserSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserSchema> mapFromJson(dynamic json) {
    final map = <String, UserSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserSchema-objects as value to a dart map
  static Map<String, List<UserSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserSchema.listFromJson(entry.value, growable: growable,);
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
    'name',
    'isVerified',
    'isAdmin',
    'role',
  };
}

