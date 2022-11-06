# BackendAPI.api.StationManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createStationStationCreateStationPost**](StationManagerApi.md#createstationstationcreatestationpost) | **POST** /station/create_station | Create Station
[**getAllStationSegmentsGet**](StationManagerApi.md#getallstationsegmentsget) | **GET** /station/segments | Get All
[**getByIdStationStationGet**](StationManagerApi.md#getbyidstationstationget) | **GET** /station/station | Get By Id


# **createStationStationCreateStationPost**
> String createStationStationCreateStationPost(stationNewSchema)

Create Station

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StationManagerApi();
final stationNewSchema = StationNewSchema(); // StationNewSchema | 

try {
    final result = api_instance.createStationStationCreateStationPost(stationNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling StationManagerApi->createStationStationCreateStationPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stationNewSchema** | [**StationNewSchema**](StationNewSchema.md)|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllStationSegmentsGet**
> List<StationSchema> getAllStationSegmentsGet()

Get All

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StationManagerApi();

try {
    final result = api_instance.getAllStationSegmentsGet();
    print(result);
} catch (e) {
    print('Exception when calling StationManagerApi->getAllStationSegmentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<StationSchema>**](StationSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByIdStationStationGet**
> StationSchema getByIdStationStationGet(segmentId)

Get By Id

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StationManagerApi();
final segmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getByIdStationStationGet(segmentId);
    print(result);
} catch (e) {
    print('Exception when calling StationManagerApi->getByIdStationStationGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **segmentId** | **String**|  | 

### Return type

[**StationSchema**](StationSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

