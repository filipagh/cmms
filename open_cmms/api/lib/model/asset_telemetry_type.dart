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
class AssetTelemetryType {
  /// Instantiate a new enum with the provided [value].
  const AssetTelemetryType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const AIR_TEMPERATURE = AssetTelemetryType._(r'AIR_TEMPERATURE');
  static const GROUND_TEMPERATURE = AssetTelemetryType._(r'GROUND_TEMPERATURE');
  static const ROAD_TEMPERATURE = AssetTelemetryType._(r'ROAD_TEMPERATURE');
  static const DEW_POINT_TEMPERATURE =
      AssetTelemetryType._(r'DEW_POINT_TEMPERATURE');
  static const VISIBILITY = AssetTelemetryType._(r'VISIBILITY');
  static const WIND_SPEED = AssetTelemetryType._(r'WIND_SPEED');
  static const WIND_DIRECTION = AssetTelemetryType._(r'WIND_DIRECTION');
  static const RAINFALL_INTENSITY = AssetTelemetryType._(r'RAINFALL_INTENSITY');
  static const WIND_GUST_SPEED = AssetTelemetryType._(r'WIND_GUST_SPEED');
  static const WIND_GUST_DIRECTION =
      AssetTelemetryType._(r'WIND_GUST_DIRECTION');
  static const AIR_PRESSURE = AssetTelemetryType._(r'AIR_PRESSURE');
  static const AIR_HUMIDITY = AssetTelemetryType._(r'AIR_HUMIDITY');
  static const ROAD_WARNING_STATUS =
      AssetTelemetryType._(r'ROAD_WARNING_STATUS');
  static const ROAD_RAIN_STATUS = AssetTelemetryType._(r'ROAD_RAIN_STATUS');
  static const ROAD_SURFACE_STATUS = AssetTelemetryType._(r'ROAD_SURFACE_STATUS');
  static const GRIP = AssetTelemetryType._(r'GRIP');
  static const WATER_HEIGHT = AssetTelemetryType._(r'WATER_HEIGHT');
  static const SNOW_HEIGHT = AssetTelemetryType._(r'SNOW_HEIGHT');
  static const ICE_HEIGHT = AssetTelemetryType._(r'ICE_HEIGHT');

  /// List of all possible values in this [enum][AssetTelemetryType].
  static const values = <AssetTelemetryType>[
    AIR_TEMPERATURE,
    GROUND_TEMPERATURE,
    ROAD_TEMPERATURE,
    DEW_POINT_TEMPERATURE,
    VISIBILITY,
    WIND_SPEED,
    WIND_DIRECTION,
    RAINFALL_INTENSITY,
    WIND_GUST_SPEED,
    WIND_GUST_DIRECTION,
    AIR_PRESSURE,
    AIR_HUMIDITY,
    ROAD_WARNING_STATUS,
    ROAD_RAIN_STATUS,
    ROAD_SURFACE_STATUS,
    GRIP,
    WATER_HEIGHT,
    SNOW_HEIGHT,
    ICE_HEIGHT,
  ];

  static AssetTelemetryType? fromJson(dynamic value) => AssetTelemetryTypeTypeTransformer().decode(value);

  static List<AssetTelemetryType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AssetTelemetryType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssetTelemetryType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AssetTelemetryType] to String,
/// and [decode] dynamic data back to [AssetTelemetryType].
class AssetTelemetryTypeTypeTransformer {
  factory AssetTelemetryTypeTypeTransformer() => _instance ??= const AssetTelemetryTypeTypeTransformer._();

  const AssetTelemetryTypeTypeTransformer._();

  String encode(AssetTelemetryType data) => data.value;

  /// Decodes a [dynamic value][data] to a AssetTelemetryType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AssetTelemetryType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'AIR_TEMPERATURE': return AssetTelemetryType.AIR_TEMPERATURE;
        case r'GROUND_TEMPERATURE': return AssetTelemetryType.GROUND_TEMPERATURE;
        case r'ROAD_TEMPERATURE':
          return AssetTelemetryType.ROAD_TEMPERATURE;
        case r'DEW_POINT_TEMPERATURE':
          return AssetTelemetryType.DEW_POINT_TEMPERATURE;
        case r'VISIBILITY':
          return AssetTelemetryType.VISIBILITY;
        case r'WIND_SPEED': return AssetTelemetryType.WIND_SPEED;
        case r'WIND_DIRECTION': return AssetTelemetryType.WIND_DIRECTION;
        case r'RAINFALL_INTENSITY': return AssetTelemetryType.RAINFALL_INTENSITY;
        case r'WIND_GUST_SPEED': return AssetTelemetryType.WIND_GUST_SPEED;
        case r'WIND_GUST_DIRECTION': return AssetTelemetryType.WIND_GUST_DIRECTION;
        case r'AIR_PRESSURE': return AssetTelemetryType.AIR_PRESSURE;
        case r'AIR_HUMIDITY': return AssetTelemetryType.AIR_HUMIDITY;
        case r'ROAD_WARNING_STATUS': return AssetTelemetryType.ROAD_WARNING_STATUS;
        case r'ROAD_RAIN_STATUS': return AssetTelemetryType.ROAD_RAIN_STATUS;
        case r'ROAD_SURFACE_STATUS': return AssetTelemetryType.ROAD_SURFACE_STATUS;
        case r'GRIP': return AssetTelemetryType.GRIP;
        case r'WATER_HEIGHT': return AssetTelemetryType.WATER_HEIGHT;
        case r'SNOW_HEIGHT': return AssetTelemetryType.SNOW_HEIGHT;
        case r'ICE_HEIGHT': return AssetTelemetryType.ICE_HEIGHT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AssetTelemetryTypeTypeTransformer] instance.
  static AssetTelemetryTypeTypeTransformer? _instance;
}

