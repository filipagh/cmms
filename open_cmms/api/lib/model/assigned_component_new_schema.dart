//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssignedComponentNewSchema {
  /// Returns a new [AssignedComponentNewSchema] instance.
  AssignedComponentNewSchema({
    required this.assetId,
    required this.stationId,
    this.serialNumber,
    this.serviceContractsId = const [],
  });

  String assetId;

  String stationId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serialNumber;

  List<String> serviceContractsId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssignedComponentNewSchema &&
     other.assetId == assetId &&
     other.stationId == stationId &&
          other.serialNumber == serialNumber &&
          other.serviceContractsId == serviceContractsId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (assetId.hashCode) +
    (stationId.hashCode) +
      (serialNumber == null ? 0 : serialNumber!.hashCode) +
      (serviceContractsId.hashCode);

  @override
  String toString() =>
      'AssignedComponentNewSchema[assetId=$assetId, stationId=$stationId, serialNumber=$serialNumber, serviceContractsId=$serviceContractsId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'asset_id'] = this.assetId;
    json[r'station_id'] = this.stationId;
    if (this.serialNumber != null) {
      json[r'serial_number'] = this.serialNumber;
    } else {
      json[r'serial_number'] = null;
    }
    json[r'service_contracts_id'] = this.serviceContractsId;
    return json;
  }

  /// Returns a new [AssignedComponentNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssignedComponentNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssignedComponentNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssignedComponentNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssignedComponentNewSchema(
        assetId: mapValueOfType<String>(json, r'asset_id')!,
        stationId: mapValueOfType<String>(json, r'station_id')!,
        serialNumber: mapValueOfType<String>(json, r'serial_number'),
        serviceContractsId: json[r'service_contracts_id'] is List
            ? (json[r'service_contracts_id'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<AssignedComponentNewSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AssignedComponentNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssignedComponentNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssignedComponentNewSchema> mapFromJson(dynamic json) {
    final map = <String, AssignedComponentNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssignedComponentNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssignedComponentNewSchema-objects as value to a dart map
  static Map<String, List<AssignedComponentNewSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssignedComponentNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssignedComponentNewSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'asset_id',
    'station_id',
    'service_contracts_id',
  };
}

