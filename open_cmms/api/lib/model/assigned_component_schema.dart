//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AssignedComponentSchema {
  /// Returns a new [AssignedComponentSchema] instance.
  AssignedComponentSchema({
    required this.assetId,
    required this.stationId,
    this.serialNumber,
    required this.id,
    required this.status,
    this.taskId,
    required this.installedAt,
    this.removedAt,
    required this.warrantyPeriodDays,
    this.warrantyPeriodUntil,
  });

  String assetId;

  String stationId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serialNumber;

  String id;

  AssignedComponentState status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? taskId;

  DateTime installedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? removedAt;

  int warrantyPeriodDays;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? warrantyPeriodUntil;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AssignedComponentSchema &&
     other.assetId == assetId &&
     other.stationId == stationId &&
     other.serialNumber == serialNumber &&
     other.id == id &&
     other.status == status &&
     other.taskId == taskId &&
     other.installedAt == installedAt &&
     other.removedAt == removedAt &&
     other.warrantyPeriodDays == warrantyPeriodDays &&
     other.warrantyPeriodUntil == warrantyPeriodUntil;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (assetId.hashCode) +
    (stationId.hashCode) +
    (serialNumber == null ? 0 : serialNumber!.hashCode) +
    (id.hashCode) +
    (status.hashCode) +
    (taskId == null ? 0 : taskId!.hashCode) +
    (installedAt.hashCode) +
    (removedAt == null ? 0 : removedAt!.hashCode) +
    (warrantyPeriodDays.hashCode) +
    (warrantyPeriodUntil == null ? 0 : warrantyPeriodUntil!.hashCode);

  @override
  String toString() => 'AssignedComponentSchema[assetId=$assetId, stationId=$stationId, serialNumber=$serialNumber, id=$id, status=$status, taskId=$taskId, installedAt=$installedAt, removedAt=$removedAt, warrantyPeriodDays=$warrantyPeriodDays, warrantyPeriodUntil=$warrantyPeriodUntil]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'asset_id'] = this.assetId;
    json[r'station_id'] = this.stationId;
    if (this.serialNumber != null) {
      json[r'serial_number'] = this.serialNumber;
    } else {
      json[r'serial_number'] = null;
    }
    json[r'id'] = this.id;
    json[r'status'] = this.status;
    if (this.taskId != null) {
      json[r'task_id'] = this.taskId;
    } else {
      json[r'task_id'] = null;
    }
    json[r'installed_at'] = this.installedAt.toUtc().toIso8601String();
    if (this.removedAt != null) {
      json[r'removed_at'] = this.removedAt!.toUtc().toIso8601String();
    } else {
      json[r'removed_at'] = null;
    }
    json[r'warranty_period_days'] = this.warrantyPeriodDays;
    if (this.warrantyPeriodUntil != null) {
      json[r'warranty_period_until'] =
          _dateFormatter.format(this.warrantyPeriodUntil!.toUtc());
    } else {
      json[r'warranty_period_until'] = null;
    }
    return json;
  }

  /// Returns a new [AssignedComponentSchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AssignedComponentSchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AssignedComponentSchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AssignedComponentSchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AssignedComponentSchema(
        assetId: mapValueOfType<String>(json, r'asset_id')!,
        stationId: mapValueOfType<String>(json, r'station_id')!,
        serialNumber: mapValueOfType<String>(json, r'serial_number'),
        id: mapValueOfType<String>(json, r'id')!,
        status: AssignedComponentState.fromJson(json[r'status'])!,
        taskId: mapValueOfType<String>(json, r'task_id'),
        installedAt: mapDateTime(json, r'installed_at', '')!,
        removedAt: mapDateTime(json, r'removed_at', ''),
        warrantyPeriodDays: mapValueOfType<int>(json, r'warranty_period_days')!,
        warrantyPeriodUntil: mapDateTime(json, r'warranty_period_until', ''),
      );
    }
    return null;
  }

  static List<AssignedComponentSchema> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AssignedComponentSchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AssignedComponentSchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AssignedComponentSchema> mapFromJson(dynamic json) {
    final map = <String, AssignedComponentSchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AssignedComponentSchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AssignedComponentSchema-objects as value to a dart map
  static Map<String, List<AssignedComponentSchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AssignedComponentSchema>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AssignedComponentSchema.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'asset_id',
    'station_id',
    'id',
    'status',
    'installed_at',
    'warranty_period_days',
  };
}

