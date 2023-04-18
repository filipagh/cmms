//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class RedmineApi {
  RedmineApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Auth
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RedmineAuthSchema] redmineAuthSchema (required):
  Future<Response> authRedmineAuthPostWithHttpInfo(RedmineAuthSchema redmineAuthSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/redmine/auth';

    // ignore: prefer_final_locals
    Object? postBody = redmineAuthSchema;

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

  /// Auth
  ///
  /// Parameters:
  ///
  /// * [RedmineAuthSchema] redmineAuthSchema (required):
  Future<RedmineAuthResponseSchema?> authRedmineAuthPost(RedmineAuthSchema redmineAuthSchema,) async {
    final response = await authRedmineAuthPostWithHttpInfo(redmineAuthSchema,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RedmineAuthResponseSchema',) as RedmineAuthResponseSchema;
    
    }
    return null;
  }

  /// Auth
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RedmineSetupRequestSchema] redmineSetupRequestSchema (required):
  Future<Response> authRedmineSetupPostWithHttpInfo(RedmineSetupRequestSchema redmineSetupRequestSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/redmine/setup';

    // ignore: prefer_final_locals
    Object? postBody = redmineSetupRequestSchema;

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

  /// Auth
  ///
  /// Parameters:
  ///
  /// * [RedmineSetupRequestSchema] redmineSetupRequestSchema (required):
  Future<String?> authRedmineSetupPost(RedmineSetupRequestSchema redmineSetupRequestSchema,) async {
    final response = await authRedmineSetupPostWithHttpInfo(redmineSetupRequestSchema,);
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
  Future<Response> loadRedmineTaskIdLoadGetWithHttpInfo(String taskId,) async {
    // ignore: prefer_const_declarations
    final path = r'/redmine/{task_id}/load'
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
  Future<RedmineIssueDataSchema?> loadRedmineTaskIdLoadGet(String taskId,) async {
    final response = await loadRedmineTaskIdLoadGetWithHttpInfo(taskId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RedmineIssueDataSchema',) as RedmineIssueDataSchema;
    
    }
    return null;
  }

  /// Remove Integration
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> removeIntegrationRedmineSetupDeleteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/redmine/setup';

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

  /// Remove Integration
  Future<String?> removeIntegrationRedmineSetupDelete() async {
    final response = await removeIntegrationRedmineSetupDeleteWithHttpInfo();
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
