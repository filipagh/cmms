//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ServiceContractApi {
  ServiceContractApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Contract
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ServiceContractNewSchema] serviceContractNewSchema (required):
  Future<Response> createContractServiceContractCreateContractPostWithHttpInfo(ServiceContractNewSchema serviceContractNewSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/service-contract/create_contract';

    // ignore: prefer_final_locals
    Object? postBody = serviceContractNewSchema;

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

  /// Create Contract
  ///
  /// Parameters:
  ///
  /// * [ServiceContractNewSchema] serviceContractNewSchema (required):
  Future<String?> createContractServiceContractCreateContractPost(ServiceContractNewSchema serviceContractNewSchema,) async {
    final response = await createContractServiceContractCreateContractPostWithHttpInfo(serviceContractNewSchema,);
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

  /// Get Contract
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] contractId (required):
  Future<Response> getContractServiceContractContractGetWithHttpInfo(String contractId,) async {
    // ignore: prefer_const_declarations
    final path = r'/service-contract/contract';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'contract_id', contractId));

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

  /// Get Contract
  ///
  /// Parameters:
  ///
  /// * [String] contractId (required):
  Future<ServiceContractSchema?> getContractServiceContractContractGet(String contractId,) async {
    final response = await getContractServiceContractContractGetWithHttpInfo(contractId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ServiceContractSchema',) as ServiceContractSchema;
    }
    return null;
  }

  /// Get Contracts
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getContractsServiceContractContractsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/service-contract/contracts';

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

  /// Get Contracts
  Future<List<ServiceContractSchema>?> getContractsServiceContractContractsGet() async {
    final response = await getContractsServiceContractContractsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ServiceContractSchema>') as List)
        .cast<ServiceContractSchema>()
        .toList();

    }
    return null;
  }

  /// Get
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] stationId (required):
  Future<Response> getServiceContractContractForStationGetWithHttpInfo(String stationId,) async {
    // ignore: prefer_const_declarations
    final path = r'/service-contract/contract_for_station';

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

  /// Get
  ///
  /// Parameters:
  ///
  /// * [String] stationId (required):
  Future<List<ServiceContractSchema>?> getServiceContractContractForStationGet(String stationId,) async {
    final response = await getServiceContractContractForStationGetWithHttpInfo(stationId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<ServiceContractSchema>') as List)
          .cast<ServiceContractSchema>()
          .toList();
    }
    return null;
  }

  /// Get Stations Without Contract Export
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response>
      getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/service-contract/stations_without_contract/export_xsl';

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

  /// Get Stations Without Contract Export
  Future<void>
      getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGet() async {
    final response =
        await getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get Stations Without Contract
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response>
      getStationsWithoutContractServiceContractStationsWithoutContractGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/service-contract/stations_without_contract';

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

  /// Get Stations Without Contract
  Future<List<StationIdSchema>?> getStationsWithoutContractServiceContractStationsWithoutContractGet() async {
    final response = await getStationsWithoutContractServiceContractStationsWithoutContractGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(
              responseBody, 'List<StationIdSchema>') as List)
          .cast<StationIdSchema>()
          .toList();
    }
    return null;
  }

  /// Search
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] query (required):
  Future<Response> searchServiceContractContractsSearchGetWithHttpInfo(
    String query,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/service-contract/contracts_search';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    queryParams.addAll(_queryParams('', 'query', query));

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

  /// Search
  ///
  /// Parameters:
  ///
  /// * [String] query (required):
  Future<List<ServiceContractSchema>?> searchServiceContractContractsSearchGet(
    String query,
  ) async {
    final response = await searchServiceContractContractsSearchGetWithHttpInfo(
      query,
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
      return (await apiClient.deserializeAsync(
              responseBody, 'List<ServiceContractSchema>') as List)
          .cast<ServiceContractSchema>()
          .toList();
    }
    return null;
  }
}
