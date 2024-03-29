//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class RoadSegmentSchema {
  /// Returns a new [RoadSegmentSchema] instance.
  RoadSegmentSchema({
    required this.name,
    required this.ssud,
    required this.id,
    required this.isActive,
  });

  String name;

  String ssud;

  String id;

  bool isActive;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoadSegmentSchema &&
          other.name == name &&
          other.ssud == ssud &&
          other.id == id &&
          other.isActive == isActive;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (name.hashCode) + (ssud.hashCode) + (id.hashCode) + (isActive.hashCode);

  @override
  String toString() =>
      'RoadSegmentSchema[name=$name, ssud=$ssud, id=$id, isActive=$isActive]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'name'] = this.name;
    json[r'ssud'] = this.ssud;
    json[r'id'] = this.id;
    json[r'is_active'] = this.isActive;
    return json;
  }

  /// Returns a new [RoadSegmentSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RoadSegmentSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RoadSegmentSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RoadSegmentSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RoadSegmentSchema(
        name: mapValueOfType<String>(json, r'name')!,
        ssud: mapValueOfType<String>(json, r'ssud')!,
        id: mapValueOfType<String>(json, r'id')!,
        isActive: mapValueOfType<bool>(json, r'is_active')!,
      );
    }
    return null;
  }

  static List<RoadSegmentSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <RoadSegmentSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RoadSegmentSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RoadSegmentSchema> mapFromJson(dynamic json) {
    final map = <String, RoadSegmentSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RoadSegmentSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RoadSegmentSchema-objects as value to a dart map
  static Map<String, List<RoadSegmentSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RoadSegmentSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RoadSegmentSchema.listFromJson(
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
    'ssud',
    'id',
    'is_active',
  };
}

