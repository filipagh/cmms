# BackendAPI.api.AssignedComponentsApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllAssignedComponentsComponentsGet**](AssignedComponentsApi.md#getallassignedcomponentscomponentsget) | **GET** /assigned_components/components | Get All


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

