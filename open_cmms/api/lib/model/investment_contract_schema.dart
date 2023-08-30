//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InvestmentContractSchema {
  /// Returns a new [InvestmentContractSchema] instance.
  InvestmentContractSchema({
    required this.identifier,
    required this.validFrom,
    required this.validUntil,
    required this.warrantyPeriodDays,
    required this.id,
    required this.createdAt,
  });

  String identifier;

  DateTime validFrom;

  DateTime validUntil;

  int warrantyPeriodDays;

  String id;

  DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvestmentContractSchema &&
          other.identifier == identifier &&
          other.validFrom == validFrom &&
          other.validUntil == validUntil &&
          other.warrantyPeriodDays == warrantyPeriodDays &&
          other.id == id &&
          other.createdAt == createdAt;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (identifier.hashCode) +
      (validFrom.hashCode) +
      (validUntil.hashCode) +
      (warrantyPeriodDays.hashCode) +
      (id.hashCode) +
      (createdAt.hashCode);

  @override
  String toString() =>
      'InvestmentContractSchema[identifier=$identifier, validFrom=$validFrom, validUntil=$validUntil, warrantyPeriodDays=$warrantyPeriodDays, id=$id, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'identifier'] = this.identifier;
    json[r'valid_from'] = _dateFormatter.format(this.validFrom.toUtc());
    json[r'valid_until'] = _dateFormatter.format(this.validUntil.toUtc());
    json[r'warranty_period_days'] = this.warrantyPeriodDays;
    json[r'id'] = this.id;
    json[r'created_at'] = _dateFormatter.format(this.createdAt.toUtc());
    return json;
  }

  /// Returns a new [InvestmentContractSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InvestmentContractSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "InvestmentContractSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "InvestmentContractSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InvestmentContractSchema(
        identifier: mapValueOfType<String>(json, r'identifier')!,
        validFrom: mapDateTime(json, r'valid_from', '')!,
        validUntil: mapDateTime(json, r'valid_until', '')!,
        warrantyPeriodDays: mapValueOfType<int>(json, r'warranty_period_days')!,
        id: mapValueOfType<String>(json, r'id')!,
        createdAt: mapDateTime(json, r'created_at', '')!,
      );
    }
    return null;
  }

  static List<InvestmentContractSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InvestmentContractSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InvestmentContractSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InvestmentContractSchema> mapFromJson(dynamic json) {
    final map = <String, InvestmentContractSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InvestmentContractSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InvestmentContractSchema-objects as value to a dart map
  static Map<String, List<InvestmentContractSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<InvestmentContractSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InvestmentContractSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'identifier',
    'valid_from',
    'valid_until',
    'warranty_period_days',
    'id',
    'created_at',
  };
}
