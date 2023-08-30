//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InvestmentContractNewSchema {
  /// Returns a new [InvestmentContractNewSchema] instance.
  InvestmentContractNewSchema({
    required this.identifier,
    required this.validFrom,
    required this.validUntil,
    required this.warrantyPeriodDays,
  });

  String identifier;

  DateTime validFrom;

  DateTime validUntil;

  int warrantyPeriodDays;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvestmentContractNewSchema &&
          other.identifier == identifier &&
          other.validFrom == validFrom &&
          other.validUntil == validUntil &&
          other.warrantyPeriodDays == warrantyPeriodDays;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (identifier.hashCode) +
      (validFrom.hashCode) +
      (validUntil.hashCode) +
      (warrantyPeriodDays.hashCode);

  @override
  String toString() =>
      'InvestmentContractNewSchema[identifier=$identifier, validFrom=$validFrom, validUntil=$validUntil, warrantyPeriodDays=$warrantyPeriodDays]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'identifier'] = this.identifier;
    json[r'valid_from'] = _dateFormatter.format(this.validFrom.toUtc());
    json[r'valid_until'] = _dateFormatter.format(this.validUntil.toUtc());
    json[r'warranty_period_days'] = this.warrantyPeriodDays;
    return json;
  }

  /// Returns a new [InvestmentContractNewSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InvestmentContractNewSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "InvestmentContractNewSchema[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "InvestmentContractNewSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return InvestmentContractNewSchema(
        identifier: mapValueOfType<String>(json, r'identifier')!,
        validFrom: mapDateTime(json, r'valid_from', '')!,
        validUntil: mapDateTime(json, r'valid_until', '')!,
        warrantyPeriodDays: mapValueOfType<int>(json, r'warranty_period_days')!,
      );
    }
    return null;
  }

  static List<InvestmentContractNewSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <InvestmentContractNewSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InvestmentContractNewSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InvestmentContractNewSchema> mapFromJson(dynamic json) {
    final map = <String, InvestmentContractNewSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InvestmentContractNewSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InvestmentContractNewSchema-objects as value to a dart map
  static Map<String, List<InvestmentContractNewSchema>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<InvestmentContractNewSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InvestmentContractNewSchema.listFromJson(
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
  };
}
