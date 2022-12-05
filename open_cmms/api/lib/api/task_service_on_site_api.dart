//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TaskServiceOnSiteApi {
  TaskServiceOnSiteApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Cancel Task
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<Response> cancelTaskTaskServiceOnSiteTaskIdDeleteWithHttpInfo(
    String taskId,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/task/service_on_site/{task_id}'.replaceAll('{task_id}', taskId);

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
  Future<String?> cancelTaskTaskServiceOnSiteTaskIdDelete(
    String taskId,
  ) async {
    final response = await cancelTaskTaskServiceOnSiteTaskIdDeleteWithHttpInfo(
      taskId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
    }
    return null;
  }

  /// Create Service On Site Task
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [TaskServiceOnSiteNewSchema] taskServiceOnSiteNewSchema (required):
  Future<Response>
      createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPostWithHttpInfo(
    TaskServiceOnSiteNewSchema taskServiceOnSiteNewSchema,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/task/service_on_site/create_service_on_side_task';

    // ignore: prefer_final_locals
    Object? postBody = taskServiceOnSiteNewSchema;

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

  /// Create Service On Site Task
  ///
  /// Parameters:
  ///
  /// * [TaskServiceOnSiteNewSchema] taskServiceOnSiteNewSchema (required):
  Future<String?>
      createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPost(
    TaskServiceOnSiteNewSchema taskServiceOnSiteNewSchema,
  ) async {
    final response =
        await createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPostWithHttpInfo(
      taskServiceOnSiteNewSchema,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'String',
      ) as String;
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
  Future<Response> loadTaskServiceOnSiteTaskIdGetWithHttpInfo(
    String taskId,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/task/service_on_site/{task_id}'.replaceAll('{task_id}', taskId);

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
  Future<TaskServiceOnSiteSchema?> loadTaskServiceOnSiteTaskIdGet(
    String taskId,
  ) async {
    final response = await loadTaskServiceOnSiteTaskIdGetWithHttpInfo(
      taskId,
    );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(
        await _decodeBodyBytes(response),
        'TaskServiceOnSiteSchema',
      ) as TaskServiceOnSiteSchema;
    }
    return null;
  }
}
