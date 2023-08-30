# BackendAPI.api.AssetManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                          | HTTP request                              | Description           
---------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|-----------------------
 [**archiveAssetAssetManagerAssetAssetIdDelete**](AssetManagerApi.md#archiveassetassetmanagerassetassetiddelete)                 | **DELETE** /assetManager/asset/{asset_id} | Archive Asset         
 [**createNewAssetAssetManagerNewAssetPost**](AssetManagerApi.md#createnewassetassetmanagernewassetpost)                         | **POST** /assetManager/newAsset           | Create New Asset      
 [**createNewCategoryAssetManagerNewCategoryPost**](AssetManagerApi.md#createnewcategoryassetmanagernewcategorypost)             | **POST** /assetManager/newCategory        | Create New Category   
 [**getAssetCategoriesAssetManagerAssetCategoriesGet**](AssetManagerApi.md#getassetcategoriesassetmanagerassetcategoriesget)     | **GET** /assetManager/asset-categories    | Get Asset Categories  
 [**getAssetsAssetManagerAssetsGet**](AssetManagerApi.md#getassetsassetmanagerassetsget)                                         | **GET** /assetManager/assets              | Get Assets            
 [**getAssetsSearchAssetManagerAssetsSearchGet**](AssetManagerApi.md#getassetssearchassetmanagerassetssearchget)                 | **GET** /assetManager/assets_search       | Get Assets Search     
 [**getTelemetryOptionsAssetManagerTelemetryOptionsGet**](AssetManagerApi.md#gettelemetryoptionsassetmanagertelemetryoptionsget) | **GET** /assetManager/telemetry_options   | Get Telemetry Options 


# **archiveAssetAssetManagerAssetAssetIdDelete**
> String archiveAssetAssetManagerAssetAssetIdDelete(assetId)

Archive Asset

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AssetManagerApi();
final assetId = assetId_example; // String | 

try {
    final result = api_instance.archiveAssetAssetManagerAssetAssetIdDelete(assetId);
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->archiveAssetAssetManagerAssetAssetIdDelete: $e\n');
}
```

### Parameters

 Name        | Type       | Description | Notes 
-------------|------------|-------------|-------
 **assetId** | **String** |             |

### Return type

**String**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createNewAssetAssetManagerNewAssetPost**
> AssetIdSchema createNewAssetAssetManagerNewAssetPost(assetNewSchema)

Create New Asset

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AssetManagerApi();
final assetNewSchema = AssetNewSchema(); // AssetNewSchema | 

try {
    final result = api_instance.createNewAssetAssetManagerNewAssetPost(assetNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->createNewAssetAssetManagerNewAssetPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **assetNewSchema** | [**AssetNewSchema**](AssetNewSchema.md)|  | 

### Return type

[**AssetIdSchema**](AssetIdSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createNewCategoryAssetManagerNewCategoryPost**
> AssetCategotyIdSchema createNewCategoryAssetManagerNewCategoryPost(assetCategoryNewSchema)

Create New Category

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AssetManagerApi();
final assetCategoryNewSchema = AssetCategoryNewSchema(); // AssetCategoryNewSchema | 

try {
    final result = api_instance.createNewCategoryAssetManagerNewCategoryPost(assetCategoryNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->createNewCategoryAssetManagerNewCategoryPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **assetCategoryNewSchema** | [**AssetCategoryNewSchema**](AssetCategoryNewSchema.md)|  | 

### Return type

[**AssetCategotyIdSchema**](AssetCategotyIdSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAssetCategoriesAssetManagerAssetCategoriesGet**
> List<AssetCategorySchema> getAssetCategoriesAssetManagerAssetCategoriesGet()

Get Asset Categories

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AssetManagerApi();

try {
    final result = api_instance.getAssetCategoriesAssetManagerAssetCategoriesGet();
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->getAssetCategoriesAssetManagerAssetCategoriesGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<AssetCategorySchema>**](AssetCategorySchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAssetsAssetManagerAssetsGet**
> List<AssetSchema> getAssetsAssetManagerAssetsGet()

Get Assets

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AssetManagerApi();

try {
    final result = api_instance.getAssetsAssetManagerAssetsGet();
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->getAssetsAssetManagerAssetsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<AssetSchema>**](AssetSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAssetsSearchAssetManagerAssetsSearchGet**
> List<AssetSchema> getAssetsSearchAssetManagerAssetsSearchGet(query)

Get Assets Search

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = AssetManagerApi();
final query = query_example; // String | 

try {
    final result = api_instance.getAssetsSearchAssetManagerAssetsSearchGet(query);
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->getAssetsSearchAssetManagerAssetsSearchGet: $e\n');
}
```

### Parameters

 Name      | Type       | Description | Notes 
-----------|------------|-------------|-------
 **query** | **String** |             |

### Return type

[**List<AssetSchema>**](AssetSchema.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getTelemetryOptionsAssetManagerTelemetryOptionsGet**
> TelemetryOptions getTelemetryOptionsAssetManagerTelemetryOptionsGet()

Get Telemetry Options

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AssetManagerApi();

try {
    final result = api_instance.getTelemetryOptionsAssetManagerTelemetryOptionsGet();
    print(result);
} catch (e) {
    print('Exception when calling AssetManagerApi->getTelemetryOptionsAssetManagerTelemetryOptionsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**TelemetryOptions**](TelemetryOptions.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

