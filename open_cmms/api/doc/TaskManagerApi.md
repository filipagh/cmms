# BackendAPI.api.TaskManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createComponentTaskTaskManagerCreateChangeComponentTaskPost**](TaskManagerApi.md#createcomponenttasktaskmanagercreatechangecomponenttaskpost) | **POST** /task-manager/create_change_component_task | Create Component Task
[**loadTaskManagerGetComponentTaskTaskIdGet**](TaskManagerApi.md#loadtaskmanagergetcomponenttasktaskidget) | **GET** /task-manager/get_component_task/{task_id} | Load
[**loadTaskManagerGetTasksGet**](TaskManagerApi.md#loadtaskmanagergettasksget) | **GET** /task-manager/get_tasks | Load


# **createComponentTaskTaskManagerCreateChangeComponentTaskPost**
> String createComponentTaskTaskManagerCreateChangeComponentTaskPost(taskChangeComponentsNewSchema)

Create Component Task

### Example
```dart
import 'package:BackendAPI/api.dart';

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

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadTaskManagerGetComponentTaskTaskIdGet**
> TaskChangeComponentsSchema loadTaskManagerGetComponentTaskTaskIdGet(taskId)

Load

### Example
```dart
import 'package:BackendAPI/api.dart';

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

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadTaskManagerGetTasksGet**
> List<TaskSchema> loadTaskManagerGetTasksGet(stationId)

Load

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskManagerApi();
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.loadTaskManagerGetTasksGet(stationId);
    print(result);
} catch (e) {
    print('Exception when calling TaskManagerApi->loadTaskManagerGetTasksGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stationId** | **String**|  | [optional] 

### Return type

[**List<TaskSchema>**](TaskSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)
