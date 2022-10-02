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
  AssetManagerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create New Main Category
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AssetCategoryNewSchema] assetCategoryNewSchema (required):
  Future<Response> createNewMainCategoryAssetManagerNewCategoryPostWithHttpInfo(AssetCategoryNewSchema assetCategoryNewSchema,) async {
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

  /// Create New Main Category
  ///
  /// Parameters:
  ///
  /// * [AssetCategoryNewSchema] assetCategoryNewSchema (required):
  Future<Object?> createNewMainCategoryAssetManagerNewCategoryPost(AssetCategoryNewSchema assetCategoryNewSchema,) async {
    final response = await createNewMainCategoryAssetManagerNewCategoryPostWithHttpInfo(assetCategoryNewSchema,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }
}
