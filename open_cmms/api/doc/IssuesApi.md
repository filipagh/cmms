# BackendAPI.api.IssuesApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                    | HTTP request                               | Description           
---------------------------------------------------------------------------------------------------------------------------|--------------------------------------------|-----------------------
 [**createIssuesPost**](IssuesApi.md#createissuespost)                                                                     | **POST** /issues/                          | Create                
 [**getActiveIssuesIssuesActiveGet**](IssuesApi.md#getactiveissuesissuesactiveget)                                         | **GET** /issues/active                     | Get Active Issues     
 [**getIssueIssuesTaskIdGet**](IssuesApi.md#getissueissuestaskidget)                                                       | **GET** /issues/{task_id}                  | Get Issue             
 [**resolveAutoReportedIssuesResolveAllAutoReportedGet**](IssuesApi.md#resolveautoreportedissuesresolveallautoreportedget) | **GET** /issues/resolve-all-auto-reported/ | Resolve Auto Reported 
 [**resolveIssueIssuesResolveTaskIdPost**](IssuesApi.md#resolveissueissuesresolvetaskidpost)                               | **POST** /issues/resolve/{task_id}         | Resolve Issue         


# **createIssuesPost**
> String createIssuesPost(issueNewSchema)

Create

### Example

```dart
import 'package:BackendAPI/api.dart';

final api_instance = IssuesApi();
final issueNewSchema = IssueNewSchema(); // IssueNewSchema | 

try {
    final result = api_instance.createIssuesPost(issueNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling IssuesApi->createIssuesPost: $e\n');
}
```

### Parameters

 Name               | Type                                    | Description | Notes 
--------------------|-----------------------------------------|-------------|-------
 **issueNewSchema** | [**IssueNewSchema**](IssueNewSchema.md) |             |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getActiveIssuesIssuesActiveGet**
> List<IssueSchema> getActiveIssuesIssuesActiveGet()

Get Active Issues

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

final api_instance = IssuesApi();

try {
    final result = api_instance.getActiveIssuesIssuesActiveGet();
    print(result);
} catch (e) {
    print('Exception when calling IssuesApi->getActiveIssuesIssuesActiveGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<IssueSchema>**](IssueSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getIssueIssuesTaskIdGet**
> IssueSchema getIssueIssuesTaskIdGet(taskId)

Get Issue

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

final api_instance = IssuesApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getIssueIssuesTaskIdGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling IssuesApi->getIssueIssuesTaskIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **String**|  | 

### Return type

[**IssueSchema**](IssueSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resolveAutoReportedIssuesResolveAllAutoReportedGet**
> String resolveAutoReportedIssuesResolveAllAutoReportedGet()

Resolve Auto Reported

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = IssuesApi();

try {
    final result = api_instance.resolveAutoReportedIssuesResolveAllAutoReportedGet();
    print(result);
} catch (e) {
    print('Exception when calling IssuesApi->resolveAutoReportedIssuesResolveAllAutoReportedGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resolveIssueIssuesResolveTaskIdPost**
> String resolveIssueIssuesResolveTaskIdPost(taskId)

Resolve Issue

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

final api_instance = IssuesApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.resolveIssueIssuesResolveTaskIdPost(taskId);
    print(result);
} catch (e) {
    print('Exception when calling IssuesApi->resolveIssueIssuesResolveTaskIdPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **String**|  | 

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

