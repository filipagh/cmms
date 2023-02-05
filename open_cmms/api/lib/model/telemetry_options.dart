//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TelemetryOptions {
  /// Returns a new [TelemetryOptions] instance.
  TelemetryOptions({
    this.types = const [],
    this.values = const [],
  });

  List<AssetTelemetryType> types;

  List<AssetTelemetryValue> values;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TelemetryOptions &&
          other.types == types &&
          other.values == values;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (types.hashCode) + (values.hashCode);

  @override
  String toString() => 'TelemetryOptions[types=$types, values=$values]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json[r'types'] = types;
    _json[r'values'] = values;
    return _json;
  }

  /// Returns a new [TelemetryOptions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TelemetryOptions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "TelemetryOptions[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "TelemetryOptions[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TelemetryOptions(
        types: AssetTelemetryType.listFromJson(json[r'types'])!,
        values: AssetTelemetryValue.listFromJson(json[r'values'])!,
      );
    }
    return null;
  }

  static List<TelemetryOptions>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TelemetryOptions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TelemetryOptions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TelemetryOptions> mapFromJson(dynamic json) {
    final map = <String, TelemetryOptions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TelemetryOptions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TelemetryOptions-objects as value to a dart map
  static Map<String, List<TelemetryOptions>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<TelemetryOptions>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TelemetryOptions.listFromJson(
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
    'types',
    'values',
  };
}
