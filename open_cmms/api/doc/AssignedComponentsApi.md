# BackendAPI.api.AssignedComponentsApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createInstalledComponentAssignedComponentsCreateInstalledComponentPost**](AssignedComponentsApi.md#createinstalledcomponentassignedcomponentscreateinstalledcomponentpost) | **POST** /assigned_components/create_installed_component | Create Installed Component
[**getAllAssignedComponentsComponentsGet**](AssignedComponentsApi.md#getallassignedcomponentscomponentsget) | **GET** /assigned_components/components | Get All
[**removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost**](AssignedComponentsApi.md#removeinstalledcomponentassignedcomponentsremoveinstalledcomponentpost) | **POST** /assigned_components/remove_installed_component | Remove Installed Component


# **createInstalledComponentAssignedComponentsCreateInstalledComponentPost**
> List<String> createInstalledComponentAssignedComponentsCreateInstalledComponentPost(warrantyPeriodDays, assignedComponentNewSchema)

Create Installed Component

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = AssignedComponentsApi();
final warrantyPeriodDays = 56; // int | 
final assignedComponentNewSchema = [List<AssignedComponentNewSchema>()]; // List<AssignedComponentNewSchema> | 

try {
    final result = api_instance.createInstalledComponentAssignedComponentsCreateInstalledComponentPost(warrantyPeriodDays, assignedComponentNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling AssignedComponentsApi->createInstalledComponentAssignedComponentsCreateInstalledComponentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **warrantyPeriodDays** | **int**|  | 
 **assignedComponentNewSchema** | [**List<AssignedComponentNewSchema>**](AssignedComponentNewSchema.md)|  | 

### Return type

**List<String>**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllAssignedComponentsComponentsGet**
> List<AssignedComponentSchema> getAllAssignedComponentsComponentsGet(stationId)

Get All

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = AssignedComponentsApi();
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getAllAssignedComponentsComponentsGet(stationId);
    print(result);
} catch (e) {
    print('Exception when calling AssignedComponentsApi->getAllAssignedComponentsComponentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stationId** | **String**|  | [optional] 

### Return type

[**List<AssignedComponentSchema>**](AssignedComponentSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost**
> List<String> removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(assignedComponentIdSchema)

Remove Installed Component

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = AssignedComponentsApi();
final assignedComponentIdSchema = [List<AssignedComponentIdSchema>()]; // List<AssignedComponentIdSchema> | 

try {
    final result = api_instance.removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(assignedComponentIdSchema);
    print(result);
} catch (e) {
    print('Exception when calling AssignedComponentsApi->removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **assignedComponentIdSchema** | [**List<AssignedComponentIdSchema>**](AssignedComponentIdSchema.md)|  | 

### Return type

**List<String>**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

