# BackendAPI.api.RoadSegmentManagerApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                            | HTTP request                                       | Description         
---------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|---------------------
 [**createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost**](RoadSegmentManagerApi.md#createroadsegmentroadsegmentmanagercreateroadsegmentpost) | **POST** /road-segment-manager/create_road_segment | Create Road Segment 
 [**getAllPublicRoadSegmentManagerSegmentsPublicGet**](RoadSegmentManagerApi.md#getallpublicroadsegmentmanagersegmentspublicget)                   | **GET** /road-segment-manager/segments_public      | Get All Public      
 [**getAllRoadSegmentManagerSegmentsGet**](RoadSegmentManagerApi.md#getallroadsegmentmanagersegmentsget)                                           | **GET** /road-segment-manager/segments             | Get All             
 [**getByIdRoadSegmentManagerSegmentGet**](RoadSegmentManagerApi.md#getbyidroadsegmentmanagersegmentget)                                           | **GET** /road-segment-manager/segment              | Get By Id           
 [**removeSegmentRoadSegmentManagerRemoveSegmentDelete**](RoadSegmentManagerApi.md#removesegmentroadsegmentmanagerremovesegmentdelete)             | **DELETE** /road-segment-manager/remove_segment    | Remove Segment      
 [**searchRoadSegmentManagerSegmentsSearchGet**](RoadSegmentManagerApi.md#searchroadsegmentmanagersegmentssearchget)                               | **GET** /road-segment-manager/segments_search      | Search              


# **createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost**
> String createRoadSegmentRoadSegmentManagerCreateRoadSegmentPost(roadSegmentNewSchema)

Create Road Segment

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

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

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllPublicRoadSegmentManagerSegmentsPublicGet**
> List<RoadSegmentSchema> getAllPublicRoadSegmentManagerSegmentsPublicGet()

Get All Public

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = RoadSegmentManagerApi();

try {
    final result = api_instance.getAllPublicRoadSegmentManagerSegmentsPublicGet();
    print(result);
} catch (e) {
    print('Exception when calling RoadSegmentManagerApi->getAllPublicRoadSegmentManagerSegmentsPublicGet: $e\n');
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

# **getAllRoadSegmentManagerSegmentsGet**
> List<RoadSegmentSchema> getAllRoadSegmentManagerSegmentsGet(onlyActive)

Get All

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = RoadSegmentManagerApi();
final onlyActive = true; // bool | 

try {
    final result = api_instance.getAllRoadSegmentManagerSegmentsGet(onlyActive);
    print(result);
} catch (e) {
    print('Exception when calling RoadSegmentManagerApi->getAllRoadSegmentManagerSegmentsGet: $e\n');
}
```

### Parameters

 Name           | Type     | Description | Notes                         
----------------|----------|-------------|-------------------------------
 **onlyActive** | **bool** |             | [optional] [default to false] 

### Return type

[**List<RoadSegmentSchema>**](RoadSegmentSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

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
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

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

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeSegmentRoadSegmentManagerRemoveSegmentDelete**
> String removeSegmentRoadSegmentManagerRemoveSegmentDelete(roadSegmentIdSchema)

Remove Segment

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = RoadSegmentManagerApi();
final roadSegmentIdSchema = RoadSegmentIdSchema(); // RoadSegmentIdSchema | 

try {
    final result = api_instance.removeSegmentRoadSegmentManagerRemoveSegmentDelete(roadSegmentIdSchema);
    print(result);
} catch (e) {
    print('Exception when calling RoadSegmentManagerApi->removeSegmentRoadSegmentManagerRemoveSegmentDelete: $e\n');
}
```

### Parameters

 Name                    | Type                                              | Description | Notes 
-------------------------|---------------------------------------------------|-------------|-------
 **roadSegmentIdSchema** | [**RoadSegmentIdSchema**](RoadSegmentIdSchema.md) |             |

### Return type

**String**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchRoadSegmentManagerSegmentsSearchGet**
> List<RoadSegmentSchema> searchRoadSegmentManagerSegmentsSearchGet(query, onlyActive)

Search

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = RoadSegmentManagerApi();
final query = query_example; // String | 
final onlyActive = true; // bool | 

try {
    final result = api_instance.searchRoadSegmentManagerSegmentsSearchGet(query, onlyActive);
    print(result);
} catch (e) {
    print('Exception when calling RoadSegmentManagerApi->searchRoadSegmentManagerSegmentsSearchGet: $e\n');
}
```

### Parameters

 Name           | Type       | Description | Notes                         
----------------|------------|-------------|-------------------------------
 **query**      | **String** |             |
 **onlyActive** | **bool**   |             | [optional] [default to false] 

### Return type

[**List<RoadSegmentSchema>**](RoadSegmentSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

