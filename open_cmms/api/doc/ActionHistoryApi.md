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
> List<ActionHistorySchema> getByStationActionHistoryByStationGet(page, pageSize, stationId)

Get By Station

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

final api_instance = ActionHistoryApi();
final page = 56; // int | 
final pageSize = 56; // int | 
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getByStationActionHistoryByStationGet(page, pageSize, stationId);
    print(result);
} catch (e) {
    print('Exception when calling ActionHistoryApi->getByStationActionHistoryByStationGet: $e\n');
}
```

### Parameters

 Name          | Type       | Description | Notes 
---------------|------------|-------------|-------
 **page**      | **int**    |             |
 **pageSize**  | **int**    |             |
 **stationId** | **String** |             |

### Return type

[**List<ActionHistorySchema>**](ActionHistorySchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

