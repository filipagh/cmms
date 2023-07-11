//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class StorageManagerApi {
  StorageManagerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get All Storage Items
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllStorageItemsStorageManagerAllStorageDataGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/storage-manager/all-storage-data';

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

  /// Get All Storage Items
  Future<List<StorageItemSchema>?> getAllStorageItemsStorageManagerAllStorageDataGet() async {
    final response = await getAllStorageItemsStorageManagerAllStorageDataGetWithHttpInfo();
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
              responseBody, 'List<StorageItemSchema>') as List)
          .cast<StorageItemSchema>()
          .toList();
    }
    return null;
  }

  /// Store Item Override
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [StorageItemOverrideSchema] storageItemOverrideSchema (required):
  Future<Response>
      storeItemOverrideStorageManagerStoreItemOverridePostWithHttpInfo(
    StorageItemOverrideSchema storageItemOverrideSchema,
  ) async {
    // ignore: prefer_const_declarations
    final path = r'/storage-manager/store-item_override';

    // ignore: prefer_final_locals
    Object? postBody = storageItemOverrideSchema;

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

  /// Store Item Override
  ///
  /// Parameters:
  ///
  /// * [StorageItemOverrideSchema] storageItemOverrideSchema (required):
  Future<String?> storeItemOverrideStorageManagerStoreItemOverridePost(
    StorageItemOverrideSchema storageItemOverrideSchema,
  ) async {
    final response =
        await storeItemOverrideStorageManagerStoreItemOverridePostWithHttpInfo(
      storageItemOverrideSchema,
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

  /// Store New Assets
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [List<AssetItemToAdd>] assetItemToAdd (required):
  Future<Response> storeNewAssetsStorageManagerStoreNewAssetsPostWithHttpInfo(List<AssetItemToAdd> assetItemToAdd,) async {
    // ignore: prefer_const_declarations
    final path = r'/storage-manager/store-new-assets';

    // ignore: prefer_final_locals
    Object? postBody = assetItemToAdd;

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

  /// Store New Assets
  ///
  /// Parameters:
  ///
  /// * [List<AssetItemToAdd>] assetItemToAdd (required):
  Future<List<AssetItemToAdd>?> storeNewAssetsStorageManagerStoreNewAssetsPost(List<AssetItemToAdd> assetItemToAdd,) async {
    final response = await storeNewAssetsStorageManagerStoreNewAssetsPostWithHttpInfo(assetItemToAdd,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<AssetItemToAdd>') as List)
        .cast<AssetItemToAdd>()
        .toList();

    }
    return null;
  }
}
