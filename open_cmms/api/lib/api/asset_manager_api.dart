//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AssetManagerApi {
  AssetManagerApi([ApiClient? apiClient])
      : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Archive Asset
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] assetId (required):
  Future<Response> archiveAssetAssetManagerAssetAssetIdDeleteWithHttpInfo(
    String assetId,
  ) async {
    // ignore: prefer_const_declarations
    final path =
        r'/assetManager/asset/{asset_id}'.replaceAll('{asset_id}', assetId);

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

  /// Archive Asset
  ///
  /// Parameters:
  ///
  /// * [String] assetId (required):
  Future<String?> archiveAssetAssetManagerAssetAssetIdDelete(
    String assetId,
  ) async {
    final response =
        await archiveAssetAssetManagerAssetAssetIdDeleteWithHttpInfo(
      assetId,
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

  /// Create New Asset
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AssetNewSchema] assetNewSchema (required):
  Future<Response> createNewAssetAssetManagerNewAssetPostWithHttpInfo(
    AssetNewSchema assetNewSchema,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/assetManager/newAsset';

    // ignore: prefer_final_locals
    Object? postBody = assetNewSchema;

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

  /// Create New Asset
  ///
  /// Parameters:
  ///
  /// * [AssetNewSchema] assetNewSchema (required):
  Future<AssetIdSchema?> createNewAssetAssetManagerNewAssetPost(AssetNewSchema assetNewSchema,) async {
    final response = await createNewAssetAssetManagerNewAssetPostWithHttpInfo(assetNewSchema,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AssetIdSchema',) as AssetIdSchema;
    }
    return null;
  }

  /// Create New Category
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AssetCategoryNewSchema] assetCategoryNewSchema (required):
  Future<Response> createNewCategoryAssetManagerNewCategoryPostWithHttpInfo(AssetCategoryNewSchema assetCategoryNewSchema,) async {
    // ignore: prefer_const_declarations
    final path = r'/assetManager/newCategory';

    // ignore: prefer_final_locals
    Object? postBody = assetCategoryNewSchema;

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

  /// Create New Category
  ///
  /// Parameters:
  ///
  /// * [AssetCategoryNewSchema] assetCategoryNewSchema (required):
  Future<AssetCategotyIdSchema?> createNewCategoryAssetManagerNewCategoryPost(AssetCategoryNewSchema assetCategoryNewSchema,) async {
    final response = await createNewCategoryAssetManagerNewCategoryPostWithHttpInfo(assetCategoryNewSchema,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AssetCategotyIdSchema',) as AssetCategotyIdSchema;
    }
    return null;
  }

  /// Get Asset Categories
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAssetCategoriesAssetManagerAssetCategoriesGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/assetManager/asset-categories';

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

  /// Get Asset Categories
  Future<List<AssetCategorySchema>?> getAssetCategoriesAssetManagerAssetCategoriesGet() async {
    final response = await getAssetCategoriesAssetManagerAssetCategoriesGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AssetCategorySchema>') as List)
        .cast<AssetCategorySchema>()
        .toList();

    }
    return null;
  }

  /// Get Assets
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAssetsAssetManagerAssetsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/assetManager/assets';

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

  /// Get Assets
  Future<List<AssetSchema>?> getAssetsAssetManagerAssetsGet() async {
    final response = await getAssetsAssetManagerAssetsGetWithHttpInfo();
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
              responseBody, 'List<AssetSchema>') as List)
          .cast<AssetSchema>()
          .toList();
    }
    return null;
  }

  /// Get Assets Search
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] query (required):
  Future<Response> getAssetsSearchAssetManagerAssetsSearchGetWithHttpInfo(
    String query,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/assetManager/assets_search';

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

  /// Get Assets Search
  ///
  /// Parameters:
  ///
  /// * [String] query (required):
  Future<List<AssetSchema>?> getAssetsSearchAssetManagerAssetsSearchGet(
    String query,
  ) async {
    final response =
        await getAssetsSearchAssetManagerAssetsSearchGetWithHttpInfo(
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
              responseBody, 'List<AssetSchema>') as List)
          .cast<AssetSchema>()
          .toList();
    }
    return null;
  }

  /// Get Telemetry Options
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response>
      getTelemetryOptionsAssetManagerTelemetryOptionsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/assetManager/telemetry_options';

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

  /// Get Telemetry Options
  Future<TelemetryOptions?> getTelemetryOptionsAssetManagerTelemetryOptionsGet() async {
    final response = await getTelemetryOptionsAssetManagerTelemetryOptionsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TelemetryOptions',) as TelemetryOptions;
    }
    return null;
  }
}
