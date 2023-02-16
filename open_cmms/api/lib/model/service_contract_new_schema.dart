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
    this.stationIdList = const [],
  });

  String name;

  DateTime validFrom;

  DateTime validUntil;

  List<String> stationIdList;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServiceContractNewSchema &&
     other.name == name &&
     other.validFrom == validFrom &&
     other.validUntil == validUntil &&
     other.stationIdList == stationIdList;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (validFrom.hashCode) +
    (validUntil.hashCode) +
    (stationIdList.hashCode);

  @override
  String toString() => 'ServiceContractNewSchema[name=$name, validFrom=$validFrom, validUntil=$validUntil, stationIdList=$stationIdList]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'name'] = name;
      _json[r'valid_from'] = _dateFormatter.format(validFrom.toUtc());
      _json[r'valid_until'] = _dateFormatter.format(validUntil.toUtc());
      _json[r'station_id_list'] = stationIdList;
    return _json;
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
        stationIdList: json[r'station_id_list'] is List
            ? (json[r'station_id_list'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<ServiceContractNewSchema>? listFromJson(dynamic json, {bool growable = false,}) {
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
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServiceContractNewSchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'valid_from',
    'valid_until',
    'station_id_list',
  };
}

