# BackendAPI.api.TaskServiceOnSiteApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelTaskServiceOnSiteTaskIdDelete**](TaskServiceOnSiteApi.md#canceltaskserviceonsitetaskiddelete) | **DELETE** /task/service_on_site/{task_id} | Cancel
[**changeDetailsTaskServiceOnSiteTaskIdChangeDetailsPost**](TaskServiceOnSiteApi.md#changedetailstaskserviceonsitetaskidchangedetailspost) | **POST** /task/service_on_site/{task_id}/change_details | Change Details
[**completeTaskServiceOnSiteTaskIdCompleteGet**](TaskServiceOnSiteApi.md#completetaskserviceonsitetaskidcompleteget) | **GET** /task/service_on_site/{task_id}/complete | Complete
[**createTaskServiceOnSiteCreateServiceOnSideTaskPost**](TaskServiceOnSiteApi.md#createtaskserviceonsitecreateserviceonsidetaskpost) | **POST** /task/service_on_site/create_service_on_side_task | Create
[**loadTaskServiceOnSiteTaskIdGet**](TaskServiceOnSiteApi.md#loadtaskserviceonsitetaskidget) | **GET** /task/service_on_site/{task_id} | Load


# **cancelTaskServiceOnSiteTaskIdDelete**
> String cancelTaskServiceOnSiteTaskIdDelete(taskId)

Cancel

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

final api_instance = TaskServiceOnSiteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.cancelTaskServiceOnSiteTaskIdDelete(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceOnSiteApi->cancelTaskServiceOnSiteTaskIdDelete: $e\n');
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

# **changeDetailsTaskServiceOnSiteTaskIdChangeDetailsPost**
> String changeDetailsTaskServiceOnSiteTaskIdChangeDetailsPost(taskId, newName, newDescription)

Change Details

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

final api_instance = TaskServiceOnSiteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final newName = newName_example; // String | 
final newDescription = newDescription_example; // String | 

try {
    final result = api_instance.changeDetailsTaskServiceOnSiteTaskIdChangeDetailsPost(taskId, newName, newDescription);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceOnSiteApi->changeDetailsTaskServiceOnSiteTaskIdChangeDetailsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **String**|  | 
 **newName** | **String**|  | [optional] 
 **newDescription** | **String**|  | [optional] 

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeTaskServiceOnSiteTaskIdCompleteGet**
> String completeTaskServiceOnSiteTaskIdCompleteGet(taskId)

Complete

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

final api_instance = TaskServiceOnSiteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.completeTaskServiceOnSiteTaskIdCompleteGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceOnSiteApi->completeTaskServiceOnSiteTaskIdCompleteGet: $e\n');
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

# **createTaskServiceOnSiteCreateServiceOnSideTaskPost**
> List<String> createTaskServiceOnSiteCreateServiceOnSideTaskPost(taskServiceOnSiteNewSchema)

Create

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

final api_instance = TaskServiceOnSiteApi();
final taskServiceOnSiteNewSchema = [List<TaskServiceOnSiteNewSchema>()]; // List<TaskServiceOnSiteNewSchema> | 

try {
final result = api_instance.createTaskServiceOnSiteCreateServiceOnSideTaskPost(taskServiceOnSiteNewSchema);
print(result);
} catch
(
e) {
print('Exception when calling TaskServiceOnSiteApi->createTaskServiceOnSiteCreateServiceOnSideTaskPost: $e\n');
}
```

### Parameters

 Name                           | Type                                                                  | Description | Notes 
--------------------------------|-----------------------------------------------------------------------|-------------|-------
 **taskServiceOnSiteNewSchema** | [**List<TaskServiceOnSiteNewSchema>**](TaskServiceOnSiteNewSchema.md) |             |

### Return type

**List<String>**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadTaskServiceOnSiteTaskIdGet**
> TaskServiceOnSiteSchema loadTaskServiceOnSiteTaskIdGet(taskId)

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

final api_instance = TaskServiceOnSiteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.loadTaskServiceOnSiteTaskIdGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceOnSiteApi->loadTaskServiceOnSiteTaskIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **String**|  | 

### Return type

[**TaskServiceOnSiteSchema**](TaskServiceOnSiteSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

