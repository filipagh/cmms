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
class AssignedComponentState {
  /// Instantiate a new enum with the provided [value].
  const AssignedComponentState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const awaiting = AssignedComponentState._(r'awaiting');
  static const installed = AssignedComponentState._(r'installed');
  static const willBeRemoved = AssignedComponentState._(r'willBeRemoved');
  static const removed = AssignedComponentState._(r'removed');

  /// List of all possible values in this [enum][AssignedComponentState].
  static const values = <AssignedComponentState>[
    awaiting,
    installed,
    willBeRemoved,
    removed,
  ];

  static AssignedComponentState? fromJson(dynamic value) => AssignedComponentStateTypeTransformer().decode(value);

  static List<AssignedComponentState> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AssignedComponentState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssignedComponentState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AssignedComponentState] to String,
/// and [decode] dynamic data back to [AssignedComponentState].
class AssignedComponentStateTypeTransformer {
  factory AssignedComponentStateTypeTransformer() => _instance ??= const AssignedComponentStateTypeTransformer._();

  const AssignedComponentStateTypeTransformer._();

  String encode(AssignedComponentState data) => data.value;

  /// Decodes a [dynamic value][data] to a AssignedComponentState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AssignedComponentState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'awaiting': return AssignedComponentState.awaiting;
        case r'installed': return AssignedComponentState.installed;
        case r'willBeRemoved': return AssignedComponentState.willBeRemoved;
        case r'removed': return AssignedComponentState.removed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AssignedComponentStateTypeTransformer] instance.
  static AssignedComponentStateTypeTransformer? _instance;
}

