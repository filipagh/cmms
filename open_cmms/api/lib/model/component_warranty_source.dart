//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// An enumeration.
class ComponentWarrantySource {
  /// Instantiate a new enum with the provided [value].
  const ComponentWarrantySource._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const INVESTMENT_CONTRACT =
      ComponentWarrantySource._(r'INVESTMENT_CONTRACT');
  static const COMPANY_WARRANTY =
      ComponentWarrantySource._(r'COMPANY_WARRANTY');
  static const NAN = ComponentWarrantySource._(r'NAN');

  /// List of all possible values in this [enum][ComponentWarrantySource].
  static const values = <ComponentWarrantySource>[
    INVESTMENT_CONTRACT,
    COMPANY_WARRANTY,
    NAN,
  ];

  static ComponentWarrantySource? fromJson(dynamic value) =>
      ComponentWarrantySourceTypeTransformer().decode(value);

  static List<ComponentWarrantySource> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ComponentWarrantySource>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ComponentWarrantySource.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ComponentWarrantySource] to String,
/// and [decode] dynamic data back to [ComponentWarrantySource].
class ComponentWarrantySourceTypeTransformer {
  factory ComponentWarrantySourceTypeTransformer() =>
      _instance ??= const ComponentWarrantySourceTypeTransformer._();

  const ComponentWarrantySourceTypeTransformer._();

  String encode(ComponentWarrantySource data) => data.value;

  /// Decodes a [dynamic value][data] to a ComponentWarrantySource.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ComponentWarrantySource? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'INVESTMENT_CONTRACT':
          return ComponentWarrantySource.INVESTMENT_CONTRACT;
        case r'COMPANY_WARRANTY':
          return ComponentWarrantySource.COMPANY_WARRANTY;
        case r'NAN':
          return ComponentWarrantySource.NAN;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ComponentWarrantySourceTypeTransformer] instance.
  static ComponentWarrantySourceTypeTransformer? _instance;
}

