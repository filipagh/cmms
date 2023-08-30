//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssetTelemetry {
  /// Returns a new [AssetTelemetry] instance.
  AssetTelemetry({
    required this.type,
    required this.value,
  });

  AssetTelemetryType type;

  AssetTelemetryValue value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssetTelemetry &&
     other.type == type &&
     other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type.hashCode) +
    (value.hashCode);

  @override
  String toString() => 'AssetTelemetry[type=$type, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'type'] = this.type;
    json[r'value'] = this.value;
    return json;
  }

  /// Returns a new [AssetTelemetry] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssetTelemetry? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssetTelemetry[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssetTelemetry[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssetTelemetry(
        type: AssetTelemetryType.fromJson(json[r'type'])!,
        value: AssetTelemetryValue.fromJson(json[r'value'])!,
      );
    }
    return null;
  }

  static List<AssetTelemetry> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AssetTelemetry>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssetTelemetry.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssetTelemetry> mapFromJson(dynamic json) {
    final map = <String, AssetTelemetry>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssetTelemetry.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssetTelemetry-objects as value to a dart map
  static Map<String, List<AssetTelemetry>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssetTelemetry>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssetTelemetry.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
    'value',
  };
}

