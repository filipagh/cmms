//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class StationApi {
  StationApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Station
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StationNewSchema] stationNewSchema (required):
  Future<Response> createStationStationCreateStationPostWithHttpInfo(StationNewSchema stationNewSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/station/create_station';

    // ignore: prefer_final_locals
    Object? postBody = stationNewSchema;

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

  /// Create Station
  ///
  /// Parameters:
  ///
  /// * [StationNewSchema] stationNewSchema (required):
  Future<String?> createStationStationCreateStationPost(StationNewSchema stationNewSchema,) async {
    final response = await createStationStationCreateStationPostWithHttpInfo(stationNewSchema,);
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
  /// * [String] roadSegmentId:
  Future<Response> getAllStationStationsGetWithHttpInfo({ String? roadSegmentId, }) async {
    // ignore: prefer_const_declarations
    final path = r'/station/stations';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (roadSegmentId != null) {
      queryParams.addAll(_queryParams('', 'road_segment_id', roadSegmentId));
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

  /// Get All
  ///
  /// Parameters:
  ///
  /// * [String] roadSegmentId:
  Future<List<StationSchema>?> getAllStationStationsGet({ String? roadSegmentId, }) async {
    final response = await getAllStationStationsGetWithHttpInfo( roadSegmentId: roadSegmentId, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<StationSchema>') as List)
        .cast<StationSchema>()
        .toList();

    }
    return null;
  }

  /// Get By Id
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] segmentId (required):
  Future<Response> getByIdStationStationGetWithHttpInfo(String segmentId,) async {
    // ignore: prefer_const_declarations
    final path = r'/station/station';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'segment_id', segmentId));

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

  /// Get By Id
  ///
  /// Parameters:
  ///
  /// * [String] segmentId (required):
  Future<StationSchema?> getByIdStationStationGet(String segmentId,) async {
    final response = await getByIdStationStationGetWithHttpInfo(segmentId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StationSchema',) as StationSchema;

    }
    return null;
  }

  /// Remove Station
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StationIdSchema] stationIdSchema (required):
  Future<Response> removeStationStationRemoveStationDeleteWithHttpInfo(StationIdSchema stationIdSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/station/remove_station';

    // ignore: prefer_final_locals
    Object? postBody = stationIdSchema;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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

  /// Remove Station
  ///
  /// Parameters:
  ///
  /// * [StationIdSchema] stationIdSchema (required):
  Future<String?> removeStationStationRemoveStationDelete(
    StationIdSchema stationIdSchema,
  ) async {
    final response = await removeStationStationRemoveStationDeleteWithHttpInfo(
      stationIdSchema,
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
}
