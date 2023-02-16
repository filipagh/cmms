//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServiceContractSchema {
  /// Returns a new [ServiceContractSchema] instance.
  ServiceContractSchema({
    required this.name,
    required this.validFrom,
    required this.validUntil,
    this.stationIdList = const [],
    required this.id,
    required this.createdAt,
  });

  String name;

  DateTime validFrom;

  DateTime validUntil;

  List<String> stationIdList;

  String id;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ServiceContractSchema &&
     other.name == name &&
     other.validFrom == validFrom &&
     other.validUntil == validUntil &&
     other.stationIdList == stationIdList &&
     other.id == id &&
     other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (validFrom.hashCode) +
    (validUntil.hashCode) +
    (stationIdList.hashCode) +
    (id.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'ServiceContractSchema[name=$name, validFrom=$validFrom, validUntil=$validUntil, stationIdList=$stationIdList, id=$id, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'name'] = name;
      _json[r'valid_from'] = _dateFormatter.format(validFrom.toUtc());
      _json[r'valid_until'] = _dateFormatter.format(validUntil.toUtc());
      _json[r'station_id_list'] = stationIdList;
      _json[r'id'] = id;
      _json[r'created_at'] = _dateFormatter.format(createdAt.toUtc());
    return _json;
  }

  /// Returns a new [ServiceContractSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServiceContractSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ServiceContractSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ServiceContractSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServiceContractSchema(
        name: mapValueOfType<String>(json, r'name')!,
        validFrom: mapDateTime(json, r'valid_from', '')!,
        validUntil: mapDateTime(json, r'valid_until', '')!,
        stationIdList: json[r'station_id_list'] is List
            ? (json[r'station_id_list'] as List).cast<String>()
            : const [],
        id: mapValueOfType<String>(json, r'id')!,
        createdAt: mapDateTime(json, r'created_at', '')!,
      );
    }
    return null;
  }

  static List<ServiceContractSchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ServiceContractSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServiceContractSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServiceContractSchema> mapFromJson(dynamic json) {
    final map = <String, ServiceContractSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServiceContractSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServiceContractSchema-objects as value to a dart map
  static Map<String, List<ServiceContractSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ServiceContractSchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ServiceContractSchema.listFromJson(entry.value, growable: growable,);
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
    'id',
    'created_at',
  };
}

