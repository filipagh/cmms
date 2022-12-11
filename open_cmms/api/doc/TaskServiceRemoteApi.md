# BackendAPI.api.TaskServiceRemoteApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                             | HTTP request                                             | Description         
----------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|---------------------
 [**cancelTaskServiceRemoteTaskIdDelete**](TaskServiceRemoteApi.md#canceltaskserviceremotetaskiddelete)                                             | **DELETE** /task/service_remote/{task_id}                | Cancel              
 [**completeTaskItemsTaskServiceRemoteTaskIdChangeDetailsPost**](TaskServiceRemoteApi.md#completetaskitemstaskserviceremotetaskidchangedetailspost) | **POST** /task/service_remote/{task_id}/change_details   | Complete Task Items 
 [**completeTaskServiceRemoteTaskIdCompleteGet**](TaskServiceRemoteApi.md#completetaskserviceremotetaskidcompleteget)                               | **GET** /task/service_remote/{task_id}/complete          | Complete            
 [**createTaskServiceRemoteCreateServiceRemoteTaskPost**](TaskServiceRemoteApi.md#createtaskserviceremotecreateserviceremotetaskpost)               | **POST** /task/service_remote/create_service_remote_task | Create              
 [**loadTaskServiceRemoteTaskIdGet**](TaskServiceRemoteApi.md#loadtaskserviceremotetaskidget)                                                       | **GET** /task/service_remote/{task_id}                   | Load                


# **cancelTaskServiceRemoteTaskIdDelete**
> String cancelTaskServiceRemoteTaskIdDelete(taskId)

Cancel

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceRemoteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.cancelTaskServiceRemoteTaskIdDelete(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceRemoteApi->cancelTaskServiceRemoteTaskIdDelete: $e\n');
}
```

### Parameters

 Name       | Type       | Description | Notes 
------------|------------|-------------|-------
 **taskId** | **String** |             |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeTaskItemsTaskServiceRemoteTaskIdChangeDetailsPost**

> String completeTaskItemsTaskServiceRemoteTaskIdChangeDetailsPost(taskId, newName, newDescription)

Complete Task Items

### Example

```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceRemoteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final newName = newName_example; // String | 
final newDescription = newDescription_example; // String | 

try {
    final result = api_instance.completeTaskItemsTaskServiceRemoteTaskIdChangeDetailsPost(taskId, newName, newDescription);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceRemoteApi->completeTaskItemsTaskServiceRemoteTaskIdChangeDetailsPost: $e\n');
}
```

### Parameters

 Name               | Type       | Description | Notes      
--------------------|------------|-------------|------------
 **taskId**         | **String** |             |
 **newName**        | **String** |             | [optional] 
 **newDescription** | **String** |             | [optional] 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeTaskServiceRemoteTaskIdCompleteGet**

> String completeTaskServiceRemoteTaskIdCompleteGet(taskId)

Complete

### Example

```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceRemoteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.completeTaskServiceRemoteTaskIdCompleteGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceRemoteApi->completeTaskServiceRemoteTaskIdCompleteGet: $e\n');
}
```

### Parameters

 Name       | Type       | Description | Notes 
------------|------------|-------------|-------
 **taskId** | **String** |             |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createTaskServiceRemoteCreateServiceRemoteTaskPost**
> String createTaskServiceRemoteCreateServiceRemoteTaskPost(taskServiceRemoteNewSchema)

Create

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceRemoteApi();
final taskServiceRemoteNewSchema = TaskServiceRemoteNewSchema(); // TaskServiceRemoteNewSchema | 

try {
    final result = api_instance.createTaskServiceRemoteCreateServiceRemoteTaskPost(taskServiceRemoteNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceRemoteApi->createTaskServiceRemoteCreateServiceRemoteTaskPost: $e\n');
}
```

### Parameters

 Name                           | Type                                                            | Description | Notes 
--------------------------------|-----------------------------------------------------------------|-------------|-------
 **taskServiceRemoteNewSchema** | [**TaskServiceRemoteNewSchema**](TaskServiceRemoteNewSchema.md) |             |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadTaskServiceRemoteTaskIdGet**
> TaskServiceRemoteSchema loadTaskServiceRemoteTaskIdGet(taskId)

Load

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceRemoteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.loadTaskServiceRemoteTaskIdGet(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceRemoteApi->loadTaskServiceRemoteTaskIdGet: $e\n');
}
```

### Parameters

 Name       | Type       | Description | Notes 
------------|------------|-------------|-------
 **taskId** | **String** |             |

### Return type

[**TaskServiceRemoteSchema**](TaskServiceRemoteSchema.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

