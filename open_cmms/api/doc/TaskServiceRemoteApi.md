# BackendAPI.api.TaskServiceRemoteApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                                                 | HTTP request                                             | Description                 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|-----------------------------
 [**cancelTaskTaskServiceRemoteTaskIdDelete**](TaskServiceRemoteApi.md#canceltasktaskserviceremotetaskiddelete)                                                         | **DELETE** /task/service_remote/{task_id}                | Cancel Task                 
 [**createServiceOnSiteTaskTaskServiceRemoteCreateServiceRemoteTaskPost**](TaskServiceRemoteApi.md#createserviceonsitetasktaskserviceremotecreateserviceremotetaskpost) | **POST** /task/service_remote/create_service_Remote_task | Create Service On Site Task 
 [**loadTaskServiceRemoteTaskIdGet**](TaskServiceRemoteApi.md#loadtaskserviceremotetaskidget)                                                                           | **GET** /task/service_remote/{task_id}                   | Load                        


# **cancelTaskTaskServiceRemoteTaskIdDelete**
> String cancelTaskTaskServiceRemoteTaskIdDelete(taskId)

Cancel Task

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceRemoteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.cancelTaskTaskServiceRemoteTaskIdDelete(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceRemoteApi->cancelTaskTaskServiceRemoteTaskIdDelete: $e\n');
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

# **createServiceOnSiteTaskTaskServiceRemoteCreateServiceRemoteTaskPost**
> String createServiceOnSiteTaskTaskServiceRemoteCreateServiceRemoteTaskPost(taskServiceRemoteNewSchema)

Create Service On Site Task

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceRemoteApi();
final taskServiceRemoteNewSchema = TaskServiceRemoteNewSchema(); // TaskServiceRemoteNewSchema | 

try {
    final result = api_instance.createServiceOnSiteTaskTaskServiceRemoteCreateServiceRemoteTaskPost(taskServiceRemoteNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceRemoteApi->createServiceOnSiteTaskTaskServiceRemoteCreateServiceRemoteTaskPost: $e\n');
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

