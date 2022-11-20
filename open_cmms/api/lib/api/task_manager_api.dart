//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class TaskManagerApi {
  TaskManagerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Component Task
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TaskChangeComponentsNewSchema] taskChangeComponentsNewSchema (required):
  Future<Response> createComponentTaskTaskManagerCreateChangeComponentTaskPostWithHttpInfo(TaskChangeComponentsNewSchema taskChangeComponentsNewSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/create_change_component_task';

    // ignore: prefer_final_locals
    Object? postBody = taskChangeComponentsNewSchema;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create Component Task
  ///
  /// Parameters:
  ///
  /// * [TaskChangeComponentsNewSchema] taskChangeComponentsNewSchema (required):
  Future<String?> createComponentTaskTaskManagerCreateChangeComponentTaskPost(TaskChangeComponentsNewSchema taskChangeComponentsNewSchema,) async {
    final response = await createComponentTaskTaskManagerCreateChangeComponentTaskPostWithHttpInfo(taskChangeComponentsNewSchema,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'String',) as String;
    
    }
    return null;
  }

  /// Load
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<Response> loadTaskManagerLoadComponentTaskTaskIdGetWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/load_component_task/{task_id}'
      .replaceAll('{task_id}', taskId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Load
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<TaskChangeComponentsSchema?> loadTaskManagerLoadComponentTaskTaskIdGet(String taskId,) async {
    final response = await loadTaskManagerLoadComponentTaskTaskIdGetWithHttpInfo(taskId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TaskChangeComponentsSchema',) as TaskChangeComponentsSchema;
    
    }
    return null;
  }
}
