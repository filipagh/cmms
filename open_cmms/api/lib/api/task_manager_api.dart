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

  /// Allocate Components
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<Response> allocateComponentsTaskManagerTaskIdAllocateComponentsGetWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/{task_id}/allocate_components'
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

  /// Allocate Components
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<String?> allocateComponentsTaskManagerTaskIdAllocateComponentsGet(String taskId,) async {
    final response = await allocateComponentsTaskManagerTaskIdAllocateComponentsGetWithHttpInfo(taskId,);
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

  /// Cancel Task
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<Response> cancelTaskTaskManagerTaskIdDeleteWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/{task_id}'
      .replaceAll('{task_id}', taskId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Cancel Task
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<String?> cancelTaskTaskManagerTaskIdDelete(String taskId,) async {
    final response = await cancelTaskTaskManagerTaskIdDeleteWithHttpInfo(taskId,);
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

  /// Change Details
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  ///
  /// * [String] newName:
  ///
  /// * [String] newDescription:
  Future<Response> changeDetailsTaskManagerTaskIdChangeDetailsPostWithHttpInfo(String taskId, { String? newName, String? newDescription, }) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/{task_id}/change_details'
      .replaceAll('{task_id}', taskId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (newName != null) {
      queryParams.addAll(_queryParams('', 'new_name', newName));
    }
    if (newDescription != null) {
      queryParams.addAll(_queryParams('', 'new_description', newDescription));
    }

    const contentTypes = <String>[];


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

  /// Change Details
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  ///
  /// * [String] newName:
  ///
  /// * [String] newDescription:
  Future<String?> changeDetailsTaskManagerTaskIdChangeDetailsPost(String taskId, { String? newName, String? newDescription, }) async {
    final response = await changeDetailsTaskManagerTaskIdChangeDetailsPostWithHttpInfo(taskId,  newName: newName, newDescription: newDescription, );
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

  /// Complete Task Items
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  ///
  /// * [List<TaskChangeComponentRequestCompleted>] taskChangeComponentRequestCompleted (required):
  Future<Response> completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPostWithHttpInfo(String taskId, List<TaskChangeComponentRequestCompleted> taskChangeComponentRequestCompleted,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/{task_id}/compete_task_itmes'
      .replaceAll('{task_id}', taskId);

    // ignore: prefer_final_locals
    Object? postBody = taskChangeComponentRequestCompleted;

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

  /// Complete Task Items
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  ///
  /// * [List<TaskChangeComponentRequestCompleted>] taskChangeComponentRequestCompleted (required):
  Future<String?> completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPost(String taskId, List<TaskChangeComponentRequestCompleted> taskChangeComponentRequestCompleted,) async {
    final response = await completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPostWithHttpInfo(taskId, taskChangeComponentRequestCompleted,);
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

  /// Create Service Remote Task
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TaskServiceRemoteNewSchema] taskServiceRemoteNewSchema (required):
  Future<Response> createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPostWithHttpInfo(TaskServiceRemoteNewSchema taskServiceRemoteNewSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/create_service_remote_task';

    // ignore: prefer_final_locals
    Object? postBody = taskServiceRemoteNewSchema;

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

  /// Create Service Remote Task
  ///
  /// Parameters:
  ///
  /// * [TaskServiceRemoteNewSchema] taskServiceRemoteNewSchema (required):
  Future<String?> createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPost(TaskServiceRemoteNewSchema taskServiceRemoteNewSchema,) async {
    final response = await createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPostWithHttpInfo(taskServiceRemoteNewSchema,);
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

  /// Load All
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] page (required):
  ///
  /// * [int] pageSize (required):
  ///
  /// * [String] stationId:
  ///
  /// * [List<TaskState>] filterState:
  Future<Response> loadAllTaskManagerGetTasksGetWithHttpInfo(
    int page,
    int pageSize, {
    String? stationId,
    List<TaskState>? filterState,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/task-manager/get_tasks';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'page', page));
    queryParams.addAll(_queryParams('', 'page_size', pageSize));
    if (stationId != null) {
      queryParams.addAll(_queryParams('', 'station_id', stationId));
    }
    if (filterState != null) {
      queryParams.addAll(_queryParams('multi', 'filter_state', filterState));
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

  /// Load All
  ///
  /// Parameters:
  ///
  /// * [int] page (required):
  ///
  /// * [int] pageSize (required):
  ///
  /// * [String] stationId:
  ///
  /// * [List<TaskState>] filterState:
  Future<List<TaskSchema>?> loadAllTaskManagerGetTasksGet(
    int page,
    int pageSize, {
    String? stationId,
    List<TaskState>? filterState,
  }) async {
    final response = await loadAllTaskManagerGetTasksGetWithHttpInfo(
      page,
      pageSize,
      stationId: stationId,
      filterState: filterState,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<TaskSchema>')
              as List)
          .cast<TaskSchema>()
          .toList();
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
}
