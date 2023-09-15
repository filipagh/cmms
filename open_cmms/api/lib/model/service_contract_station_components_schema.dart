//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ServiceContractStationComponentsSchema {
  /// Returns a new [ServiceContractStationComponentsSchema] instance.
  ServiceContractStationComponentsSchema({
    required this.stationId,
    this.componentIdList = const [],
  });

  String stationId;

  List<String> componentIdList;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceContractStationComponentsSchema &&
          other.stationId == stationId &&
          other.componentIdList == componentIdList;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (stationId.hashCode) + (componentIdList.hashCode);

  @override
  String toString() =>
      'ServiceContractStationComponentsSchema[stationId=$stationId, componentIdList=$componentIdList]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'station_id'] = this.stationId;
    json[r'component_id_list'] = this.componentIdList;
    return json;
  }

  /// Returns a new [ServiceContractStationComponentsSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ServiceContractStationComponentsSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ServiceContractStationComponentsSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ServiceContractStationComponentsSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ServiceContractStationComponentsSchema(
        stationId: mapValueOfType<String>(json, r'station_id')!,
        componentIdList: json[r'component_id_list'] is List
            ? (json[r'component_id_list'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<ServiceContractStationComponentsSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ServiceContractStationComponentsSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ServiceContractStationComponentsSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ServiceContractStationComponentsSchema> mapFromJson(
      dynamic json) {
    final map = <String, ServiceContractStationComponentsSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value =
            ServiceContractStationComponentsSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ServiceContractStationComponentsSchema-objects as value to a dart map
  static Map<String, List<ServiceContractStationComponentsSchema>>
      mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ServiceContractStationComponentsSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ServiceContractStationComponentsSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'station_id',
    'component_id_list',
  };
}

