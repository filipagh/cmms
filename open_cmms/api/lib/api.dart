//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api/action_history_api.dart';
part 'api/asset_manager_api.dart';
part 'api/assigned_components_api.dart';
part 'api/auth_api.dart';
part 'api/default_api.dart';
part 'api/issues_api.dart';
part 'api/redmine_api.dart';
part 'api/road_segment_manager_api.dart';
part 'api/service_contract_api.dart';
part 'api/station_api.dart';
part 'api/storage_manager_api.dart';
part 'api/task_manager_api.dart';
part 'api/task_service_on_site_api.dart';
part 'api/task_service_remote_api.dart';
part 'api_client.dart';
part 'api_exception.dart';
part 'api_helper.dart';
part 'auth/api_key_auth.dart';
part 'auth/authentication.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';
part 'auth/oauth.dart';
part 'model/action_history_schema.dart';
part 'model/add_component_request_schema.dart';
part 'model/asset_category_new_schema.dart';
part 'model/asset_category_schema.dart';
part 'model/asset_categoty_id_schema.dart';
part 'model/asset_id_schema.dart';
part 'model/asset_item_to_add.dart';
part 'model/asset_new_schema.dart';
part 'model/asset_schema.dart';
part 'model/asset_telemetry.dart';
part 'model/asset_telemetry_type.dart';
part 'model/asset_telemetry_value.dart';
part 'model/assigned_component_id_schema.dart';
part 'model/assigned_component_new_schema.dart';
part 'model/assigned_component_schema.dart';
part 'model/assigned_component_state.dart';
part 'model/http_validation_error.dart';
part 'model/issue_new_schema.dart';
part 'model/issue_schema.dart';
part 'model/redmine_auth_response_schema.dart';
part 'model/redmine_auth_schema.dart';
part 'model/redmine_comment_data_schema.dart';
part 'model/redmine_issue_data_schema.dart';
part 'model/redmine_object_schema.dart';
part 'model/redmine_setup_request_schema.dart';
part 'model/remove_component_request_schema.dart';
part 'model/road_segment_id_schema.dart';
part 'model/road_segment_new_schema.dart';
part 'model/road_segment_schema.dart';
part 'model/role.dart';
part 'model/service_contract_new_schema.dart';
part 'model/service_contract_schema.dart';
part 'model/setting_schema.dart';
part 'model/settings_enum.dart';
part 'model/station_id_schema.dart';
part 'model/station_new_schema.dart';
part 'model/station_public_schema.dart';
part 'model/station_schema.dart';
part 'model/storage_item_schema.dart';
part 'model/task_change_component_request_completed.dart';
part 'model/task_change_components_new_schema.dart';
part 'model/task_change_components_schema.dart';
part 'model/task_component_add_new_schema.dart';
part 'model/task_component_remove_new_schema.dart';
part 'model/task_component_state.dart';
part 'model/task_schema.dart';
part 'model/task_service_on_site_new_schema.dart';
part 'model/task_service_on_site_schema.dart';
part 'model/task_service_remote_new_schema.dart';
part 'model/task_service_remote_schema.dart';
part 'model/task_state.dart';
part 'model/task_type.dart';
part 'model/telemetry_options.dart';
part 'model/user_schema.dart';
part 'model/validation_error.dart';


const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ApiClient defaultApiClient = ApiClient();
