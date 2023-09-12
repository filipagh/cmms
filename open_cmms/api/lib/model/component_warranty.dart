//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ComponentWarranty {
  /// Returns a new [ComponentWarranty] instance.
  ComponentWarranty({
    this.componentWarrantyUntil,
    required this.componentWarrantyDays,
    required this.componentWarrantySource,
    this.componentWarrantyId,
    this.componentPrepaidServiceUntil,
    required this.componentPrepaidServiceDays,
    this.componentTechnicalWarrantyUntil,
    this.componentTechnicalWarrantyId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? componentWarrantyUntil;

  int componentWarrantyDays;

  ComponentWarrantySource componentWarrantySource;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? componentWarrantyId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? componentPrepaidServiceUntil;

  int componentPrepaidServiceDays;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? componentTechnicalWarrantyUntil;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? componentTechnicalWarrantyId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentWarranty &&
          other.componentWarrantyUntil == componentWarrantyUntil &&
          other.componentWarrantyDays == componentWarrantyDays &&
          other.componentWarrantySource == componentWarrantySource &&
          other.componentWarrantyId == componentWarrantyId &&
          other.componentPrepaidServiceUntil == componentPrepaidServiceUntil &&
          other.componentPrepaidServiceDays == componentPrepaidServiceDays &&
          other.componentTechnicalWarrantyUntil ==
              componentTechnicalWarrantyUntil &&
          other.componentTechnicalWarrantyId == componentTechnicalWarrantyId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (componentWarrantyUntil == null ? 0 : componentWarrantyUntil!.hashCode) +
      (componentWarrantyDays.hashCode) +
      (componentWarrantySource.hashCode) +
      (componentWarrantyId == null ? 0 : componentWarrantyId!.hashCode) +
      (componentPrepaidServiceUntil == null
          ? 0
          : componentPrepaidServiceUntil!.hashCode) +
      (componentPrepaidServiceDays.hashCode) +
      (componentTechnicalWarrantyUntil == null
          ? 0
          : componentTechnicalWarrantyUntil!.hashCode) +
      (componentTechnicalWarrantyId == null
          ? 0
          : componentTechnicalWarrantyId!.hashCode);

  @override
  String toString() =>
      'ComponentWarranty[componentWarrantyUntil=$componentWarrantyUntil, componentWarrantyDays=$componentWarrantyDays, componentWarrantySource=$componentWarrantySource, componentWarrantyId=$componentWarrantyId, componentPrepaidServiceUntil=$componentPrepaidServiceUntil, componentPrepaidServiceDays=$componentPrepaidServiceDays, componentTechnicalWarrantyUntil=$componentTechnicalWarrantyUntil, componentTechnicalWarrantyId=$componentTechnicalWarrantyId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.componentWarrantyUntil != null) {
      json[r'component_warranty_until'] =
          this.componentWarrantyUntil!.toUtc().toIso8601String();
    } else {
      json[r'component_warranty_until'] = null;
    }
    json[r'component_warranty_days'] = this.componentWarrantyDays;
    json[r'component_warranty_source'] = this.componentWarrantySource;
    if (this.componentWarrantyId != null) {
      json[r'component_warranty_id'] = this.componentWarrantyId;
    } else {
      json[r'component_warranty_id'] = null;
    }
    if (this.componentPrepaidServiceUntil != null) {
      json[r'component_prepaid_service_until'] =
          this.componentPrepaidServiceUntil!.toUtc().toIso8601String();
    } else {
      json[r'component_prepaid_service_until'] = null;
    }
    json[r'component_prepaid_service_days'] = this.componentPrepaidServiceDays;
    if (this.componentTechnicalWarrantyUntil != null) {
      json[r'component_technical_warranty_until'] =
          this.componentTechnicalWarrantyUntil!.toUtc().toIso8601String();
    } else {
      json[r'component_technical_warranty_until'] = null;
    }
    if (this.componentTechnicalWarrantyId != null) {
      json[r'component_technical_warranty_id'] =
          this.componentTechnicalWarrantyId;
    } else {
      json[r'component_technical_warranty_id'] = null;
    }
    return json;
  }

  /// Returns a new [ComponentWarranty] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ComponentWarranty? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "ComponentWarranty[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "ComponentWarranty[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ComponentWarranty(
        componentWarrantyUntil:
            mapDateTime(json, r'component_warranty_until', ''),
        componentWarrantyDays:
            mapValueOfType<int>(json, r'component_warranty_days')!,
        componentWarrantySource: ComponentWarrantySource.fromJson(
            json[r'component_warranty_source'])!,
        componentWarrantyId:
            mapValueOfType<String>(json, r'component_warranty_id'),
        componentPrepaidServiceUntil:
            mapDateTime(json, r'component_prepaid_service_until', ''),
        componentPrepaidServiceDays:
            mapValueOfType<int>(json, r'component_prepaid_service_days')!,
        componentTechnicalWarrantyUntil:
            mapDateTime(json, r'component_technical_warranty_until', ''),
        componentTechnicalWarrantyId:
            mapValueOfType<String>(json, r'component_technical_warranty_id'),
      );
    }
    return null;
  }

  static List<ComponentWarranty> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ComponentWarranty>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ComponentWarranty.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ComponentWarranty> mapFromJson(dynamic json) {
    final map = <String, ComponentWarranty>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ComponentWarranty.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ComponentWarranty-objects as value to a dart map
  static Map<String, List<ComponentWarranty>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ComponentWarranty>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ComponentWarranty.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'component_warranty_days',
    'component_warranty_source',
    'component_prepaid_service_days',
  };
}
