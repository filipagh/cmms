//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class IssuesApi {
  IssuesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] subject (required):
  ///
  /// * [String] description (required):
  ///
  /// * [String] user (required):
  ///
  /// * [String] stationId:
  ///
  /// * [String] componentId:
  Future<Response> createIssuesPostWithHttpInfo(String subject, String description, String user, { String? stationId, String? componentId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/issues/';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'subject', subject));
      queryParams.addAll(_queryParams('', 'description', description));
      queryParams.addAll(_queryParams('', 'user', user));
    if (stationId != null) {
      queryParams.addAll(_queryParams('', 'station_id', stationId));
    }
    if (componentId != null) {
      queryParams.addAll(_queryParams('', 'component_id', componentId));
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

  /// Create
  ///
  /// Parameters:
  ///
  /// * [String] subject (required):
  ///
  /// * [String] description (required):
  ///
  /// * [String] user (required):
  ///
  /// * [String] stationId:
  ///
  /// * [String] componentId:
  Future<String?> createIssuesPost(String subject, String description, String user, { String? stationId, String? componentId, }) async {
    final response = await createIssuesPostWithHttpInfo(subject, description, user,  stationId: stationId, componentId: componentId, );
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

  /// Get Active Issues
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getActiveIssuesIssuesActiveGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/issues/active';

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

  /// Get Active Issues
  Future<List<IssueSchema>?> getActiveIssuesIssuesActiveGet() async {
    final response = await getActiveIssuesIssuesActiveGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<IssueSchema>') as List)
        .cast<IssueSchema>()
        .toList();

    }
    return null;
  }

  /// Get Issue
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<Response> getIssueIssuesTaskIdGetWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/issues/{task_id}'
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

  /// Get Issue
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<IssueSchema?> getIssueIssuesTaskIdGet(
    String taskId,
  ) async {
    final response = await getIssueIssuesTaskIdGetWithHttpInfo(
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
        'IssueSchema',
      ) as IssueSchema;
    }
    return null;
  }

  /// Resolve Auto Reported
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response>
      resolveAutoReportedIssuesResolveAllAutoReportedGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/issues/resolve-all-auto-reported/';

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

  /// Resolve Auto Reported
  Future<String?> resolveAutoReportedIssuesResolveAllAutoReportedGet() async {
    final response =
        await resolveAutoReportedIssuesResolveAllAutoReportedGetWithHttpInfo();
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

  /// Resolve Issue
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<Response> resolveIssueIssuesResolveTaskIdPostWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/issues/resolve/{task_id}'
      .replaceAll('{task_id}', taskId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

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

  /// Resolve Issue
  ///
  /// Parameters:
  ///
  /// * [String] taskId (required):
  Future<String?> resolveIssueIssuesResolveTaskIdPost(String taskId,) async {
    final response = await resolveIssueIssuesResolveTaskIdPostWithHttpInfo(taskId,);
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
}
