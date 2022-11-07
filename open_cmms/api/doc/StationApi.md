# BackendAPI.api.StationApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createStationStationCreateStationPost**](StationApi.md#createstationstationcreatestationpost) | **POST** /station/create_station | Create Station
[**getAllStationStationsGet**](StationApi.md#getallstationstationsget) | **GET** /station/stations | Get All
[**getByIdStationStationGet**](StationApi.md#getbyidstationstationget) | **GET** /station/station | Get By Id


# **createStationStationCreateStationPost**
> String createStationStationCreateStationPost(stationNewSchema)

Create Station

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StationApi();
final stationNewSchema = StationNewSchema(); // StationNewSchema | 

try {
    final result = api_instance.createStationStationCreateStationPost(stationNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->createStationStationCreateStationPost: $e\n');
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

# **getAllStationStationsGet**
> List<StationSchema> getAllStationStationsGet(roadSegmentId)

Get All

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StationApi();
final roadSegmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getAllStationStationsGet(roadSegmentId);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->getAllStationStationsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **roadSegmentId** | **String**|  | [optional] 

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

final api_instance = StationApi();
final segmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getByIdStationStationGet(segmentId);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->getByIdStationStationGet: $e\n');
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

