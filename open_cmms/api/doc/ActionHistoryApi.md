# BackendAPI.api.ActionHistoryApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getByStationActionHistoryByStationGet**](ActionHistoryApi.md#getbystationactionhistorybystationget) | **GET** /action_history/by_station | Get By Station


# **getByStationActionHistoryByStationGet**
> List<ActionHistorySchema> getByStationActionHistoryByStationGet(stationId)

Get By Station

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = ActionHistoryApi();
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getByStationActionHistoryByStationGet(stationId);
    print(result);
} catch (e) {
    print('Exception when calling ActionHistoryApi->getByStationActionHistoryByStationGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stationId** | **String**|  | 

### Return type

[**List<ActionHistorySchema>**](ActionHistorySchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

