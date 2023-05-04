# BackendAPI.api.TaskManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**allocateComponentsTaskManagerTaskIdAllocateComponentsGet**](TaskManagerApi.md#allocatecomponentstaskmanagertaskidallocatecomponentsget) | **GET** /task-manager/{task_id}/allocate_components | Allocate Components
[**cancelTaskTaskManagerTaskIdDelete**](TaskManagerApi.md#canceltasktaskmanagertaskiddelete) | **DELETE** /task-manager/{task_id} | Cancel Task
[**changeDetailsTaskManagerTaskIdChangeDetailsPost**](TaskManagerApi.md#changedetailstaskmanagertaskidchangedetailspost) | **POST** /task-manager/{task_id}/change_details | Change Details
[**completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPost**](TaskManagerApi.md#completetaskitemstaskmanagertaskidcompetetaskitmespost) | **POST** /task-manager/{task_id}/compete_task_itmes | Complete Task Items
[**createComponentTaskTaskManagerCreateChangeComponentTaskPost**](TaskManagerApi.md#createcomponenttasktaskmanagercreatechangecomponenttaskpost) | **POST** /task-manager/create_change_component_task | Create Component Task
[**createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPost**](TaskManagerApi.md#createserviceremotetasktaskmanagercreateserviceremotetaskpost) | **POST** /task-manager/create_service_remote_task | Create Service Remote Task
[**loadAllTaskManagerGetTasksGet**](TaskManagerApi.md#loadalltaskmanagergettasksget) | **GET** /task-manager/get_tasks | Load All
[**loadByIdTaskManagerGetTaskGet**](TaskManagerApi.md#loadbyidtaskmanagergettaskget) | **GET** /task-manager/get_task | Load By Id
[**loadTaskManagerGetComponentTaskTaskIdGet**](TaskManagerApi.md#loadtaskmanagergetcomponenttasktaskidget) | **GET** /task-manager/get_component_task/{task_id} | Load


# **allocateComponentsTaskManagerTaskIdAllocateComponentsGet**
> String allocateComponentsTaskManagerTaskIdAllocateComponentsGet(taskId)

Allocate Components

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

final api_instance = TaskManagerApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.allocateComponentsTaskManagerTaskIdAllocateComponentsGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->allocateComponentsTaskManagerTaskIdAllocateComponentsGet: $e\n');
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

# **cancelTaskTaskManagerTaskIdDelete**
> String cancelTaskTaskManagerTaskIdDelete(taskId)

Cancel Task

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

final api_instance = TaskManagerApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.cancelTaskTaskManagerTaskIdDelete(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->cancelTaskTaskManagerTaskIdDelete: $e\n');
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

# **changeDetailsTaskManagerTaskIdChangeDetailsPost**
> String changeDetailsTaskManagerTaskIdChangeDetailsPost(taskId, newName, newDescription)

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

final api_instance = TaskManagerApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final newName = newName_example; // String | 
final newDescription = newDescription_example; // String | 

try {
    final result = api_instance.changeDetailsTaskManagerTaskIdChangeDetailsPost(taskId, newName, newDescription);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->changeDetailsTaskManagerTaskIdChangeDetailsPost: $e\n');
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

# **completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPost**
> String completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPost(taskId, taskChangeComponentRequestCompleted)

Complete Task Items

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

final api_instance = TaskManagerApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final taskChangeComponentRequestCompleted = [List<TaskChangeComponentRequestCompleted>()]; // List<TaskChangeComponentRequestCompleted> | 

try {
    final result = api_instance.completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPost(taskId, taskChangeComponentRequestCompleted);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->completeTaskItemsTaskManagerTaskIdCompeteTaskItmesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **String**|  | 
 **taskChangeComponentRequestCompleted** | [**List<TaskChangeComponentRequestCompleted>**](TaskChangeComponentRequestCompleted.md)|  | 

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createComponentTaskTaskManagerCreateChangeComponentTaskPost**
> String createComponentTaskTaskManagerCreateChangeComponentTaskPost(taskChangeComponentsNewSchema)

Create Component Task

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

final api_instance = TaskManagerApi();
final taskChangeComponentsNewSchema = TaskChangeComponentsNewSchema(); // TaskChangeComponentsNewSchema | 

try {
    final result = api_instance.createComponentTaskTaskManagerCreateChangeComponentTaskPost(taskChangeComponentsNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->createComponentTaskTaskManagerCreateChangeComponentTaskPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskChangeComponentsNewSchema** | [**TaskChangeComponentsNewSchema**](TaskChangeComponentsNewSchema.md)|  | 

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPost**
> String createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPost(taskServiceRemoteNewSchema)

Create Service Remote Task

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

final api_instance = TaskManagerApi();
final taskServiceRemoteNewSchema = TaskServiceRemoteNewSchema(); // TaskServiceRemoteNewSchema | 

try {
    final result = api_instance.createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPost(taskServiceRemoteNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->createServiceRemoteTaskTaskManagerCreateServiceRemoteTaskPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskServiceRemoteNewSchema** | [**TaskServiceRemoteNewSchema**](TaskServiceRemoteNewSchema.md)|  | 

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadAllTaskManagerGetTasksGet**
> List<TaskSchema> loadAllTaskManagerGetTasksGet(stationId, filterState)

Load All

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

final api_instance = TaskManagerApi();
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final filterState = []; // List<TaskState> | 

try {
    final result = api_instance.loadAllTaskManagerGetTasksGet(stationId, filterState);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->loadAllTaskManagerGetTasksGet: $e\n');
}
```

### Parameters

 Name            | Type                                | Description | Notes                            
-----------------|-------------------------------------|-------------|----------------------------------
 **stationId**   | **String**                          |             | [optional]                       
 **filterState** | [**List<TaskState>**](TaskState.md) |             | [optional] [default to const []] 

### Return type

[**List<TaskSchema>**](TaskSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadByIdTaskManagerGetTaskGet**
> TaskSchema loadByIdTaskManagerGetTaskGet(taskId)

Load By Id

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

final api_instance = TaskManagerApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.loadByIdTaskManagerGetTaskGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->loadByIdTaskManagerGetTaskGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **String**|  | 

### Return type

[**TaskSchema**](TaskSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadTaskManagerGetComponentTaskTaskIdGet**
> TaskChangeComponentsSchema loadTaskManagerGetComponentTaskTaskIdGet(taskId)

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

final api_instance = TaskManagerApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.loadTaskManagerGetComponentTaskTaskIdGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->loadTaskManagerGetComponentTaskTaskIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **taskId** | **String**|  | 

### Return type

[**TaskChangeComponentsSchema**](TaskChangeComponentsSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

