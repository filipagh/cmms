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
class TaskState {
  /// Instantiate a new enum with the provided [value].
  const TaskState._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const open = TaskState._(r'open');
  static const ready = TaskState._(r'ready');
  static const done = TaskState._(r'done');
  static const removed = TaskState._(r'removed');

  /// List of all possible values in this [enum][TaskState].
  static const values = <TaskState>[
    open,
    ready,
    done,
    removed,
  ];

  static TaskState? fromJson(dynamic value) => TaskStateTypeTransformer().decode(value);

  static List<TaskState> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <TaskState>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TaskState.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TaskState] to String,
/// and [decode] dynamic data back to [TaskState].
class TaskStateTypeTransformer {
  factory TaskStateTypeTransformer() => _instance ??= const TaskStateTypeTransformer._();

  const TaskStateTypeTransformer._();

  String encode(TaskState data) => data.value;

  /// Decodes a [dynamic value][data] to a TaskState.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TaskState? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'open': return TaskState.open;
        case r'ready': return TaskState.ready;
        case r'done': return TaskState.done;
        case r'removed': return TaskState.removed;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TaskStateTypeTransformer] instance.
  static TaskStateTypeTransformer? _instance;
}

