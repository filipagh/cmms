# BackendAPI.api.StorageManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                | HTTP request                                  | Description           
---------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|-----------------------
 [**getAllStorageItemsStorageManagerAllStorageDataGet**](StorageManagerApi.md#getallstorageitemsstoragemanagerallstoragedataget)       | **GET** /storage-manager/all-storage-data     | Get All Storage Items 
 [**storeItemOverrideStorageManagerStoreItemOverridePost**](StorageManagerApi.md#storeitemoverridestoragemanagerstoreitemoverridepost) | **POST** /storage-manager/store-item_override | Store Item Override   
 [**storeNewAssetsStorageManagerStoreNewAssetsPost**](StorageManagerApi.md#storenewassetsstoragemanagerstorenewassetspost)             | **POST** /storage-manager/store-new-assets    | Store New Assets      


# **getAllStorageItemsStorageManagerAllStorageDataGet**
> List<StorageItemSchema> getAllStorageItemsStorageManagerAllStorageDataGet()

Get All Storage Items

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StorageManagerApi();

try {
    final result = api_instance.getAllStorageItemsStorageManagerAllStorageDataGet();
    print(result);
} catch (e) {
    print('Exception when calling StorageManagerApi->getAllStorageItemsStorageManagerAllStorageDataGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<StorageItemSchema>**](StorageItemSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storeItemOverrideStorageManagerStoreItemOverridePost**
> String storeItemOverrideStorageManagerStoreItemOverridePost(storageItemOverrideSchema)

Store Item Override

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StorageManagerApi();
final storageItemOverrideSchema = StorageItemOverrideSchema(); // StorageItemOverrideSchema | 

try {
    final result = api_instance.storeItemOverrideStorageManagerStoreItemOverridePost(storageItemOverrideSchema);
    print(result);
} catch (e) {
    print('Exception when calling StorageManagerApi->storeItemOverrideStorageManagerStoreItemOverridePost: $e\n');
}
```

### Parameters

 Name                          | Type                                                          | Description | Notes 
-------------------------------|---------------------------------------------------------------|-------------|-------
 **storageItemOverrideSchema** | [**StorageItemOverrideSchema**](StorageItemOverrideSchema.md) |             |

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storeNewAssetsStorageManagerStoreNewAssetsPost**
> List<AssetItemToAdd> storeNewAssetsStorageManagerStoreNewAssetsPost(assetItemToAdd)

Store New Assets

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StorageManagerApi();
final assetItemToAdd = [List<AssetItemToAdd>()]; // List<AssetItemToAdd> | 

try {
    final result = api_instance.storeNewAssetsStorageManagerStoreNewAssetsPost(assetItemToAdd);
    print(result);
} catch (e) {
    print('Exception when calling StorageManagerApi->storeNewAssetsStorageManagerStoreNewAssetsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **assetItemToAdd** | [**List<AssetItemToAdd>**](AssetItemToAdd.md)|  | 

### Return type

[**List<AssetItemToAdd>**](AssetItemToAdd.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

