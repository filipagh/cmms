# BackendAPI.api.StationApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                           | HTTP request                              | Description               
----------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|---------------------------
 [**createStationStationCreateStationPost**](StationApi.md#createstationstationcreatestationpost)                                 | **POST** /station/create_station          | Create Station            
 [**exportStationStationExportXslGet**](StationApi.md#exportstationstationexportxslget)                                           | **GET** /station/station/export_xsl       | Export                    
 [**getAllPublicStationStationsPublicGet**](StationApi.md#getallpublicstationstationspublicget)                                   | **GET** /station/stations_public          | Get All Public            
 [**getAllStationStationsGet**](StationApi.md#getallstationstationsget)                                                           | **GET** /station/stations                 | Get All                   
 [**getByIdStationStationGet**](StationApi.md#getbyidstationstationget)                                                           | **GET** /station/station                  | Get By Id                 
 [**getRoadSegmentStationsStationStationsOfRoadSegmentGet**](StationApi.md#getroadsegmentstationsstationstationsofroadsegmentget) | **GET** /station/stations_of_road_segment | Get Road Segment Stations 
 [**relocateStationStationRelocateStationPost**](StationApi.md#relocatestationstationrelocatestationpost)                         | **POST** /station/relocate_station        | Relocate Station          
 [**removeStationStationRemoveStationDelete**](StationApi.md#removestationstationremovestationdelete)                             | **DELETE** /station/remove_station        | Remove Station            
 [**searchStationsStationStationsSearchGet**](StationApi.md#searchstationsstationstationssearchget)                               | **GET** /station/stations_search          | Search Stations           


# **createStationStationCreateStationPost**
> String createStationStationCreateStationPost(stationNewSchema)

Create Station

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

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

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **exportStationStationExportXslGet**
> exportStationStationExportXslGet(segmentId)

Export

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StationApi();
final segmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    api_instance.exportStationStationExportXslGet(segmentId);
} catch (e) {
    print('Exception when calling StationApi->exportStationStationExportXslGet: $e\n');
}
```

### Parameters

 Name          | Type       | Description | Notes 
---------------|------------|-------------|-------
 **segmentId** | **String** |             |

### Return type

void (empty response body)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllPublicStationStationsPublicGet**
> List<StationPublicSchema> getAllPublicStationStationsPublicGet(roadSegmentId)

Get All Public

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = StationApi();
final roadSegmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getAllPublicStationStationsPublicGet(roadSegmentId);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->getAllPublicStationStationsPublicGet: $e\n');
}
```

### Parameters

 Name              | Type       | Description | Notes 
-------------------|------------|-------------|-------
 **roadSegmentId** | **String** |             |

### Return type

[**List<StationPublicSchema>**](StationPublicSchema.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllStationStationsGet**

> List<StationSchema> getAllStationStationsGet(page, pageSize, roadSegmentId, onlyActive)

Get All

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StationApi();
final page = 56; // int | 
final pageSize = 56; // int | 
final roadSegmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final onlyActive = true; // bool | 

try {
    final result = api_instance.getAllStationStationsGet(page, pageSize, roadSegmentId, onlyActive);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->getAllStationStationsGet: $e\n');
}
```

### Parameters

 Name              | Type       | Description | Notes                         
-------------------|------------|-------------|-------------------------------
 **page**          | **int**    |             |
 **pageSize**      | **int**    |             |
 **roadSegmentId** | **String** |             | [optional]                    
 **onlyActive**    | **bool**   |             | [optional] [default to false] 

### Return type

[**List<StationSchema>**](StationSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getByIdStationStationGet**
> StationSchema getByIdStationStationGet(stationId)

Get By Id

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StationApi();
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getByIdStationStationGet(stationId);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->getByIdStationStationGet: $e\n');
}
```

### Parameters

 Name          | Type       | Description | Notes 
---------------|------------|-------------|-------
 **stationId** | **String** |             |

### Return type

[**StationSchema**](StationSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRoadSegmentStationsStationStationsOfRoadSegmentGet**

> List<StationSchema> getRoadSegmentStationsStationStationsOfRoadSegmentGet(roadSegmentId, onlyActive)

Get Road Segment Stations

### Example

```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StationApi();
final roadSegmentId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final onlyActive = true; // bool | 

try {
    final result = api_instance.getRoadSegmentStationsStationStationsOfRoadSegmentGet(roadSegmentId, onlyActive);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->getRoadSegmentStationsStationStationsOfRoadSegmentGet: $e\n');
}
```

### Parameters

 Name              | Type       | Description | Notes                         
-------------------|------------|-------------|-------------------------------
 **roadSegmentId** | **String** |             |
 **onlyActive**    | **bool**   |             | [optional] [default to false] 

### Return type

[**List<StationSchema>**](StationSchema.md)

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **relocateStationStationRelocateStationPost**

> String relocateStationStationRelocateStationPost(stationRelocateSchema)

Relocate Station

### Example

```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StationApi();
final stationRelocateSchema = StationRelocateSchema(); // StationRelocateSchema | 

try {
    final result = api_instance.relocateStationStationRelocateStationPost(stationRelocateSchema);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->relocateStationStationRelocateStationPost: $e\n');
}
```

### Parameters

 Name                      | Type                                                  | Description | Notes 
---------------------------|-------------------------------------------------------|-------------|-------
 **stationRelocateSchema** | [**StationRelocateSchema**](StationRelocateSchema.md) |             |

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeStationStationRemoveStationDelete**
> String removeStationStationRemoveStationDelete(stationIdSchema)

Remove Station

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = StationApi();
final stationIdSchema = StationIdSchema(); // StationIdSchema | 

try {
    final result = api_instance.removeStationStationRemoveStationDelete(stationIdSchema);
    print(result);
} catch (e) {
    print('Exception when calling StationApi->removeStationStationRemoveStationDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stationIdSchema** | [**StationIdSchema**](StationIdSchema.md)|  | 

### Return type

**String**

### Authorization

[OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer), [api_key](../README.md#api_key), [user_session](../README.md#user_session)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchStationsStationStationsSearchGet**

> List<StationSchema> searchStationsStationStationsSearchGet(query, page, pageSize, onlyActive)

Search Stations

### Example

```dart
import 'package:BackendAPI/api.dart';

final api_instance = StationApi();
final query = query_example; // String | 
final page = 56; // int | 
final pageSize = 56; // int | 
final onlyActive = true; // bool | 

try {
final result = api_instance.searchStationsStationStationsSearchGet(query, page, pageSize, onlyActive);
print(result);
} catch
(
e) {
print('Exception when calling StationApi->searchStationsStationStationsSearchGet: $e\n');
}
```

### Parameters

 Name           | Type       | Description | Notes                         
----------------|------------|-------------|-------------------------------
 **query**      | **String** |             |
 **page**       | **int**    |             |
 **pageSize**   | **int**    |             |
 **onlyActive** | **bool**   |             | [optional] [default to false] 

### Return type

[**List<StationSchema>**](StationSchema.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

