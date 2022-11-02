# BackendAPI.api.RoadSegmentManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost**](RoadSegmentManagerApi.md#createroadsegmentroadsegmentmanagercreateroadsegmentpost) | **POST** /road-segment-manager/create_road_segment | Create Road Segment
[**getAllRoadSegmentManagerSegmentsGet**](RoadSegmentManagerApi.md#getallroadsegmentmanagersegmentsget) | **GET** /road-segment-manager/segments | Get All
[**getByIdRoadSegmentManagerSegmentGet**](RoadSegmentManagerApi.md#getbyidroadsegmentmanagersegmentget) | **GET** /road-segment-manager/segment | Get By Id


# **createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost**
> String createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost(roadSegmentNewSchema)

Create Road Segment

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = RoadSegmentManagerApi();
final roadSegmentNewSchema = RoadSegmentNewSchema(); // RoadSegmentNewSchema | 

try {
    final result = api_instance.createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost(roadSegmentNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling RoadSegmentManagerApi->createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **roadSegmentNewSchema** | [**RoadSegmentNewSchema**](RoadSegmentNewSchema.md)|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllRoadSegmentManagerSegmentsGet**
> List<RoadSegmentSchema> getAllRoadSegmentManagerSegmentsGet()

Get All

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = RoadSegmentManagerApi();

try {
    final result = api_instance.getAllRoadSegmentManagerSegmentsGet();
    print(result);
} catch (e) {
    print('Exception when calling RoadSegmentManagerApi->getAllRoadSegmentManagerSegmentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<RoadSegmentSchema>**](RoadSegmentSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByIdRoadSegmentManagerSegmentGet**
> RoadSegmentSchema getByIdRoadSegmentManagerSegmentGet(segmentId)

Get By Id

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = RoadSegmentManagerApi();
final segmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getByIdRoadSegmentManagerSegmentGet(segmentId);
    print(result);
} catch (e) {
    print('Exception when calling RoadSegmentManagerApi->getByIdRoadSegmentManagerSegmentGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **segmentId** | **String**|  | 

### Return type

[**RoadSegmentSchema**](RoadSegmentSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

