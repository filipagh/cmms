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
class SettingsEnum {
  /// Instantiate a new enum with the provided [value].
  const SettingsEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const feature = SettingsEnum._(r'redmine_feature');
  static const url = SettingsEnum._(r'redmine_url');
  static const apiKey = SettingsEnum._(r'redmine_api_key');
  static const projectId = SettingsEnum._(r'redmine_project_id');
  static const trackerId = SettingsEnum._(r'redmine_tracker_id');
  static const supervisorId = SettingsEnum._(r'redmine_supervisor_id');

  /// List of all possible values in this [enum][SettingsEnum].
  static const values = <SettingsEnum>[
    feature,
    url,
    apiKey,
    projectId,
    trackerId,
    supervisorId,
  ];

  static SettingsEnum? fromJson(dynamic value) =>
      SettingsEnumTypeTransformer().decode(value);

  static List<SettingsEnum>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <SettingsEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SettingsEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SettingsEnum] to String,
/// and [decode] dynamic data back to [SettingsEnum].
class SettingsEnumTypeTransformer {
  factory SettingsEnumTypeTransformer() =>
      _instance ??= const SettingsEnumTypeTransformer._();

  const SettingsEnumTypeTransformer._();

  String encode(SettingsEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a SettingsEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SettingsEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'redmine_feature':
          return SettingsEnum.feature;
        case r'redmine_url':
          return SettingsEnum.url;
        case r'redmine_api_key':
          return SettingsEnum.apiKey;
        case r'redmine_project_id':
          return SettingsEnum.projectId;
        case r'redmine_tracker_id':
          return SettingsEnum.trackerId;
        case r'redmine_supervisor_id':
          return SettingsEnum.supervisorId;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SettingsEnumTypeTransformer] instance.
  static SettingsEnumTypeTransformer? _instance;
}

