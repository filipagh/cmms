//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AssignedComponentsApi {
  AssignedComponentsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Installed Component
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AssignedComponentNewSchema] assignedComponentNewSchema (required):
  Future<Response> createInstalledComponentAssignedComponentsCreateInstalledComponentPostWithHttpInfo(AssignedComponentNewSchema assignedComponentNewSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/assigned_components/create_installed_component';

    // ignore: prefer_final_locals
    Object? postBody = assignedComponentNewSchema;

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

  /// Create Installed Component
  ///
  /// Parameters:
  ///
  /// * [AssignedComponentNewSchema] assignedComponentNewSchema (required):
  Future<String?> createInstalledComponentAssignedComponentsCreateInstalledComponentPost(AssignedComponentNewSchema assignedComponentNewSchema,) async {
    final response = await createInstalledComponentAssignedComponentsCreateInstalledComponentPostWithHttpInfo(assignedComponentNewSchema,);
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

  /// Get All
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] stationId (required):
  Future<Response> getAllAssignedComponentsComponentsGetWithHttpInfo(String stationId,) async {
    // ignore: prefer_const_declarations
    final path = r'/assigned_components/components';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'station_id', stationId));

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

  /// Get All
  ///
  /// Parameters:
  ///
  /// * [String] stationId (required):
  Future<List<AssignedComponentSchema>?> getAllAssignedComponentsComponentsGet(String stationId,) async {
    final response = await getAllAssignedComponentsComponentsGetWithHttpInfo(stationId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AssignedComponentSchema>') as List)
        .cast<AssignedComponentSchema>()
        .toList();

    }
    return null;
  }
}
