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
class AssetTelemetryValue {
  /// Instantiate a new enum with the provided [value].
  const AssetTelemetryValue._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const CELSIUS = AssetTelemetryValue._(r'CELSIUS');
  static const METER_PER_SECOND = AssetTelemetryValue._(r'METER_PER_SECOND');
  static const METERS = AssetTelemetryValue._(r'METERS');
  static const CIRCLE_DEGREES = AssetTelemetryValue._(r'CIRCLE_DEGREES');
  static const MILLIMETER_PER_SECOND = AssetTelemetryValue._(r'MILLIMETER_PER_SECOND');
  static const HECTO_PASCAL = AssetTelemetryValue._(r'HECTO_PASCAL');
  static const PERCENTAGE = AssetTelemetryValue._(r'PERCENTAGE');

  /// List of all possible values in this [enum][AssetTelemetryValue].
  static const values = <AssetTelemetryValue>[
    CELSIUS,
    METER_PER_SECOND,
    METERS,
    CIRCLE_DEGREES,
    MILLIMETER_PER_SECOND,
    HECTO_PASCAL,
    PERCENTAGE,
  ];

  static AssetTelemetryValue? fromJson(dynamic value) => AssetTelemetryValueTypeTransformer().decode(value);

  static List<AssetTelemetryValue>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssetTelemetryValue>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssetTelemetryValue.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AssetTelemetryValue] to String,
/// and [decode] dynamic data back to [AssetTelemetryValue].
class AssetTelemetryValueTypeTransformer {
  factory AssetTelemetryValueTypeTransformer() => _instance ??= const AssetTelemetryValueTypeTransformer._();

  const AssetTelemetryValueTypeTransformer._();

  String encode(AssetTelemetryValue data) => data.value;

  /// Decodes a [dynamic value][data] to a AssetTelemetryValue.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AssetTelemetryValue? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'CELSIUS': return AssetTelemetryValue.CELSIUS;
        case r'METER_PER_SECOND': return AssetTelemetryValue.METER_PER_SECOND;
        case r'METERS': return AssetTelemetryValue.METERS;
        case r'CIRCLE_DEGREES': return AssetTelemetryValue.CIRCLE_DEGREES;
        case r'MILLIMETER_PER_SECOND': return AssetTelemetryValue.MILLIMETER_PER_SECOND;
        case r'HECTO_PASCAL': return AssetTelemetryValue.HECTO_PASCAL;
        case r'PERCENTAGE': return AssetTelemetryValue.PERCENTAGE;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AssetTelemetryValueTypeTransformer] instance.
  static AssetTelemetryValueTypeTransformer? _instance;
}

