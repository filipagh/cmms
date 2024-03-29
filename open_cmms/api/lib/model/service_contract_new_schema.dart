//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServiceContractNewSchema {
  /// Returns a new [ServiceContractNewSchema] instance.
  ServiceContractNewSchema({
    required this.name,
    required this.validFrom,
    required this.validUntil,
    this.stationsList = const [],
  });

  String name;

  DateTime validFrom;

  DateTime validUntil;

  List<ServiceContractStationComponentsSchema> stationsList;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServiceContractNewSchema &&
     other.name == name &&
     other.validFrom == validFrom &&
     other.validUntil == validUntil &&
          other.stationsList == stationsList;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (validFrom.hashCode) +
    (validUntil.hashCode) +
      (stationsList.hashCode);

  @override
  String toString() =>
      'ServiceContractNewSchema[name=$name, validFrom=$validFrom, validUntil=$validUntil, stationsList=$stationsList]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'name'] = this.name;
    json[r'valid_from'] = _dateFormatter.format(this.validFrom.toUtc());
    json[r'valid_until'] = _dateFormatter.format(this.validUntil.toUtc());
    json[r'stations_list'] = this.stationsList;
    return json;
  }

  /// Returns a new [ServiceContractNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServiceContractNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServiceContractNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServiceContractNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServiceContractNewSchema(
        name: mapValueOfType<String>(json, r'name')!,
        validFrom: mapDateTime(json, r'valid_from', '')!,
        validUntil: mapDateTime(json, r'valid_until', '')!,
        stationsList: ServiceContractStationComponentsSchema.listFromJson(
            json[r'stations_list']),
      );
    }
    return null;
  }

  static List<ServiceContractNewSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ServiceContractNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServiceContractNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServiceContractNewSchema> mapFromJson(dynamic json) {
    final map = <String, ServiceContractNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServiceContractNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServiceContractNewSchema-objects as value to a dart map
  static Map<String, List<ServiceContractNewSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServiceContractNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ServiceContractNewSchema.listFromJson(
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
    'valid_from',
    'valid_until',
    'stations_list',
  };
}

