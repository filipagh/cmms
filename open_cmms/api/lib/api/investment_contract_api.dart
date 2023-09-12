//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InvestmentContractApi {
  InvestmentContractApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Contract
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [InvestmentContractNewSchema] investmentContractNewSchema (required):
  Future<Response>
      createContractInvestmentContractCreateContractPostWithHttpInfo(
    InvestmentContractNewSchema investmentContractNewSchema,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/investment-contract/create_contract';

    // ignore: prefer_final_locals
    Object? postBody = investmentContractNewSchema;

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
  /// * [InvestmentContractNewSchema] investmentContractNewSchema (required):
  Future<String?> createContractInvestmentContractCreateContractPost(
    InvestmentContractNewSchema investmentContractNewSchema,
  ) async {
    final response =
        await createContractInvestmentContractCreateContractPostWithHttpInfo(
      investmentContractNewSchema,
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

  /// Get Contract
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] contractId (required):
  Future<Response> getContractInvestmentContractContractGetWithHttpInfo(
    String contractId,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/investment-contract/contract';

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
  Future<InvestmentContractSchema?> getContractInvestmentContractContractGet(
    String contractId,
  ) async {
    final response = await getContractInvestmentContractContractGetWithHttpInfo(
      contractId,
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
        'InvestmentContractSchema',
      ) as InvestmentContractSchema;
    }
    return null;
  }

  /// Get Contracts
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [Object] onlyActive:
  Future<Response> getContractsInvestmentContractContractsGetWithHttpInfo({
    Object? onlyActive,
  }) async {
    // ignore: prefer_const_declarations
    final path = r'/investment-contract/contracts';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (onlyActive != null) {
      queryParams.addAll(_queryParams('', 'only_active', onlyActive));
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

  /// Get Contracts
  ///
  /// Parameters:
  ///
  /// * [Object] onlyActive:
  Future<List<InvestmentContractSchema>?>
      getContractsInvestmentContractContractsGet({
    Object? onlyActive,
  }) async {
    final response =
        await getContractsInvestmentContractContractsGetWithHttpInfo(
      onlyActive: onlyActive,
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
              responseBody, 'List<InvestmentContractSchema>') as List)
          .cast<InvestmentContractSchema>()
          .toList();
    }
    return null;
  }
}
