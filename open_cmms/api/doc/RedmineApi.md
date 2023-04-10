# BackendAPI.api.RedmineApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                       | HTTP request                    | Description        
----------------------------------------------------------------------------------------------|---------------------------------|--------------------
 [**authRedmineAuthPost**](RedmineApi.md#authredmineauthpost)                                 | **POST** /redmine/auth          | Auth               
 [**authRedmineSetupPost**](RedmineApi.md#authredminesetuppost)                               | **POST** /redmine/setup         | Auth               
 [**loadRedmineTaskIdLoadGet**](RedmineApi.md#loadredminetaskidloadget)                       | **GET** /redmine/{task_id}/load | Load               
 [**removeIntegrationRedmineSetupDelete**](RedmineApi.md#removeintegrationredminesetupdelete) | **DELETE** /redmine/setup       | Remove Integration 


# **authRedmineAuthPost**
> RedmineAuthResponseSchema authRedmineAuthPost(redmineAuthSchema)

Auth

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

final api_instance = RedmineApi();
final redmineAuthSchema = RedmineAuthSchema(); // RedmineAuthSchema | 

try {
    final result = api_instance.authRedmineAuthPost(redmineAuthSchema);
    print(result);
} catch (e) {
    print('Exception when calling RedmineApi->authRedmineAuthPost: $e\n');
}
```

### Parameters

 Name                  | Type                                          | Description | Notes 
-----------------------|-----------------------------------------------|-------------|-------
 **redmineAuthSchema** | [**RedmineAuthSchema**](RedmineAuthSchema.md) |             |

### Return type

[**RedmineAuthResponseSchema**](RedmineAuthResponseSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRedmineSetupPost**
> String authRedmineSetupPost(redmineSetupRequestSchema)

Auth

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

final api_instance = RedmineApi();
final redmineSetupRequestSchema = RedmineSetupRequestSchema(); // RedmineSetupRequestSchema | 

try {
    final result = api_instance.authRedmineSetupPost(redmineSetupRequestSchema);
    print(result);
} catch (e) {
    print('Exception when calling RedmineApi->authRedmineSetupPost: $e\n');
}
```

### Parameters

 Name                          | Type                                                          | Description | Notes 
-------------------------------|---------------------------------------------------------------|-------------|-------
 **redmineSetupRequestSchema** | [**RedmineSetupRequestSchema**](RedmineSetupRequestSchema.md) |             |

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadRedmineTaskIdLoadGet**
> RedmineIssueDataSchema loadRedmineTaskIdLoadGet(taskId)

Load

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

final api_instance = RedmineApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.loadRedmineTaskIdLoadGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling RedmineApi->loadRedmineTaskIdLoadGet: $e\n');
}
```

### Parameters

 Name       | Type       | Description | Notes 
------------|------------|-------------|-------
 **taskId** | **String** |             |

### Return type

[**RedmineIssueDataSchema**](RedmineIssueDataSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeIntegrationRedmineSetupDelete**
> String removeIntegrationRedmineSetupDelete()

Remove Integration

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

final api_instance = RedmineApi();

try {
    final result = api_instance.removeIntegrationRedmineSetupDelete();
    print(result);
} catch (e) {
    print('Exception when calling RedmineApi->removeIntegrationRedmineSetupDelete: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

