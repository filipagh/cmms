//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ActionHistorySchema {
  /// Returns a new [ActionHistorySchema] instance.
  ActionHistorySchema({
    required this.stationId,
    required this.text,
    required this.datetime,
    required this.id,
  });

  String stationId;

  String text;

  DateTime datetime;

  String id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ActionHistorySchema &&
     other.stationId == stationId &&
     other.text == text &&
     other.datetime == datetime &&
     other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (stationId.hashCode) +
    (text.hashCode) +
    (datetime.hashCode) +
    (id.hashCode);

  @override
  String toString() => 'ActionHistorySchema[stationId=$stationId, text=$text, datetime=$datetime, id=$id]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'station_id'] = stationId;
      _json[r'text'] = text;
      _json[r'datetime'] = datetime.toUtc().toIso8601String();
      _json[r'id'] = id;
    return _json;
  }

  /// Returns a new [ActionHistorySchema] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ActionHistorySchema? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ActionHistorySchema[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ActionHistorySchema[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ActionHistorySchema(
        stationId: mapValueOfType<String>(json, r'station_id')!,
        text: mapValueOfType<String>(json, r'text')!,
        datetime: mapDateTime(json, r'datetime', '')!,
        id: mapValueOfType<String>(json, r'id')!,
      );
    }
    return null;
  }

  static List<ActionHistorySchema>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ActionHistorySchema>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ActionHistorySchema.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ActionHistorySchema> mapFromJson(dynamic json) {
    final map = <String, ActionHistorySchema>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActionHistorySchema.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ActionHistorySchema-objects as value to a dart map
  static Map<String, List<ActionHistorySchema>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ActionHistorySchema>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ActionHistorySchema.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'station_id',
    'text',
    'datetime',
    'id',
  };
}

