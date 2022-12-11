# BackendAPI.api.TaskServiceOnSiteApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                                                 | HTTP request                                               | Description                 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------|-----------------------------
 [**cancelTaskTaskServiceOnSiteTaskIdDelete**](TaskServiceOnSiteApi.md#canceltasktaskserviceonsitetaskiddelete)                                                         | **DELETE** /task/service_on_site/{task_id}                 | Cancel Task                 
 [**createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPost**](TaskServiceOnSiteApi.md#createserviceonsitetasktaskserviceonsitecreateserviceonsidetaskpost) | **POST** /task/service_on_site/create_service_on_side_task | Create Service On Site Task 
 [**loadTaskServiceOnSiteTaskIdGet**](TaskServiceOnSiteApi.md#loadtaskserviceonsitetaskidget)                                                                           | **GET** /task/service_on_site/{task_id}                    | Load                        


# **cancelTaskTaskServiceOnSiteTaskIdDelete**
> String cancelTaskTaskServiceOnSiteTaskIdDelete(taskId)

Cancel Task

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceOnSiteApi();
final taskId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.cancelTaskTaskServiceOnSiteTaskIdDelete(taskId);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceOnSiteApi->cancelTaskTaskServiceOnSiteTaskIdDelete: $e\n');
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

# **createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPost**
> String createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPost(taskServiceOnSiteNewSchema)

Create Service On Site Task

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = TaskServiceOnSiteApi();
final taskServiceOnSiteNewSchema = TaskServiceOnSiteNewSchema(); // TaskServiceOnSiteNewSchema | 

try {
    final result = api_instance.createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPost(taskServiceOnSiteNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling TaskServiceOnSiteApi->createServiceOnSiteTaskTaskServiceOnSiteCreateServiceOnSideTaskPost: $e\n');
}
```

### Parameters

 Name                           | Type                                                            | Description | Notes 
--------------------------------|-----------------------------------------------------------------|-------------|-------
 **taskServiceOnSiteNewSchema** | [**TaskServiceOnSiteNewSchema**](TaskServiceOnSiteNewSchema.md) |             |

### Return type

**String**

### Authorization

No authorization required

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

 Name       | Type       | Description | Notes 
------------|------------|-------------|-------
 **taskId** | **String** |             |

### Return type

[**TaskServiceOnSiteSchema**](TaskServiceOnSiteSchema.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

