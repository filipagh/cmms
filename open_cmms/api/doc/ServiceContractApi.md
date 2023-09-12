# BackendAPI.api.ServiceContractApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                                                                             | HTTP request                                                   | Description                          
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------|--------------------------------------
 [**createContractServiceContractCreateContractPost**](ServiceContractApi.md#createcontractservicecontractcreatecontractpost)                                                                       | **POST** /service-contract/create_contract                     | Create Contract                      
 [**getContractServiceContractContractGet**](ServiceContractApi.md#getcontractservicecontractcontractget)                                                                                           | **GET** /service-contract/contract                             | Get Contract                         
 [**getContractsServiceContractContractsGet**](ServiceContractApi.md#getcontractsservicecontractcontractsget)                                                                                       | **GET** /service-contract/contracts                            | Get Contracts                        
 [**getServiceContractContractForStationGet**](ServiceContractApi.md#getservicecontractcontractforstationget)                                                                                       | **GET** /service-contract/contract_for_station                 | Get                                  
 [**getServiceContractContractsForComponentGet**](ServiceContractApi.md#getservicecontractcontractsforcomponentget)                                                                                 | **GET** /service-contract/contracts_for_component              | Get                                  
 [**getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGet**](ServiceContractApi.md#getstationswithoutcontractexportservicecontractstationswithoutcontractexportxslget) | **GET** /service-contract/stations_without_contract/export_xsl | Get Stations Without Contract Export 
 [**getStationsWithoutContractServiceContractStationsWithoutContractGet**](ServiceContractApi.md#getstationswithoutcontractservicecontractstationswithoutcontractget)                               | **GET** /service-contract/stations_without_contract            | Get Stations Without Contract        
 [**searchServiceContractContractsSearchGet**](ServiceContractApi.md#searchservicecontractcontractssearchget)                                                                                       | **GET** /service-contract/contracts_search                     | Search                               


# **createContractServiceContractCreateContractPost**
> String createContractServiceContractCreateContractPost(serviceContractNewSchema)

Create Contract

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

final api_instance = ServiceContractApi();
final serviceContractNewSchema = ServiceContractNewSchema(); // ServiceContractNewSchema | 

try {
    final result = api_instance.createContractServiceContractCreateContractPost(serviceContractNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling ServiceContractApi->createContractServiceContractCreateContractPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **serviceContractNewSchema** | [**ServiceContractNewSchema**](ServiceContractNewSchema.md)|  | 

### Return type

**String**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContractServiceContractContractGet**
> ServiceContractSchema getContractServiceContractContractGet(contractId)

Get Contract

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

final api_instance = ServiceContractApi();
final contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getContractServiceContractContractGet(contractId);
    print(result);
} catch (e) {
    print('Exception when calling ServiceContractApi->getContractServiceContractContractGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contractId** | **String**|  | 

### Return type

[**ServiceContractSchema**](ServiceContractSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContractsServiceContractContractsGet**
> List<ServiceContractSchema> getContractsServiceContractContractsGet()

Get Contracts

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

final api_instance = ServiceContractApi();

try {
    final result = api_instance.getContractsServiceContractContractsGet();
    print(result);
} catch (e) {
    print('Exception when calling ServiceContractApi->getContractsServiceContractContractsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<ServiceContractSchema>**](ServiceContractSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getServiceContractContractForStationGet**
> List<ServiceContractSchema> getServiceContractContractForStationGet(stationId)

Get

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

final api_instance = ServiceContractApi();
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getServiceContractContractForStationGet(stationId);
    print(result);
} catch (e) {
    print('Exception when calling ServiceContractApi->getServiceContractContractForStationGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stationId** | **String**|  | 

### Return type

[**List<ServiceContractSchema>**](ServiceContractSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getServiceContractContractsForComponentGet**

> List<ServiceContractSchema> getServiceContractContractsForComponentGet(componentId)

Get

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

final api_instance = ServiceContractApi();
final componentId = 38400000 - 8
cf0-11
bd-b23e-10
b96e4ef00d; // String | 

try {
final result = api_instance.getServiceContractContractsForComponentGet(componentId);
print(result);
} catch
(
e) {
print('Exception when calling ServiceContractApi->getServiceContractContractsForComponentGet: $e\n');
}
```

### Parameters

 Name            | Type       | Description | Notes 
-----------------|------------|-------------|-------
 **componentId** | **String** |             |

### Return type

[**List<ServiceContractSchema>**](ServiceContractSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGet**
> getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGet()

Get Stations Without Contract Export

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

final api_instance = ServiceContractApi();

try {
    api_instance.getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGet();
} catch (e) {
    print('Exception when calling ServiceContractApi->getStationsWithoutContractExportServiceContractStationsWithoutContractExportXslGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStationsWithoutContractServiceContractStationsWithoutContractGet**
> List<StationIdSchema> getStationsWithoutContractServiceContractStationsWithoutContractGet()

Get Stations Without Contract

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

final api_instance = ServiceContractApi();

try {
    final result = api_instance.getStationsWithoutContractServiceContractStationsWithoutContractGet();
    print(result);
} catch (e) {
    print('Exception when calling ServiceContractApi->getStationsWithoutContractServiceContractStationsWithoutContractGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<StationIdSchema>**](StationIdSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchServiceContractContractsSearchGet**
> List<ServiceContractSchema> searchServiceContractContractsSearchGet(query)

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

final api_instance = ServiceContractApi();
final query = query_example; // String | 

try {
    final result = api_instance.searchServiceContractContractsSearchGet(query);
    print(result);
} catch (e) {
    print('Exception when calling ServiceContractApi->searchServiceContractContractsSearchGet: $e\n');
}
```

### Parameters

 Name      | Type       | Description | Notes 
-----------|------------|-------------|-------
 **query** | **String** |             |

### Return type

[**List<ServiceContractSchema>**](ServiceContractSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

