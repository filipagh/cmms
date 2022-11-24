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

  /// Load By Id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<Response> loadByIdTaskManagerGetTaskGetWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/get_task';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'task_id', taskId));

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

  /// Load By Id
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<TaskSchema?> loadByIdTaskManagerGetTaskGet(String taskId,) async {
    final response = await loadByIdTaskManagerGetTaskGetWithHttpInfo(taskId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TaskSchema',) as TaskSchema;
    
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
  Future<Response> loadTaskManagerGetComponentTaskTaskIdGetWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/get_component_task/{task_id}'
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
  Future<TaskChangeComponentsSchema?> loadTaskManagerGetComponentTaskTaskIdGet(String taskId,) async {
    final response = await loadTaskManagerGetComponentTaskTaskIdGetWithHttpInfo(taskId,);
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

  /// Load
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] stationId:
  Future<Response> loadTaskManagerGetTasksGetWithHttpInfo({ String? stationId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/get_tasks';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (stationId != null) {
      queryParams.addAll(_queryParams('', 'station_id', stationId));
    }

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
  /// * [String] stationId:
  Future<List<TaskSchema>?> loadTaskManagerGetTasksGet({ String? stationId, }) async {
    final response = await loadTaskManagerGetTasksGetWithHttpInfo( stationId: stationId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<TaskSchema>') as List)
        .cast<TaskSchema>()
        .toList();

    }
    return null;
  }
}
