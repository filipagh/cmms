# BackendAPI.api.ServiceContractApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createContractServiceContractCreateContractPost**](ServiceContractApi.md#createcontractservicecontractcreatecontractpost) | **POST** /service-contract/create_contract | Create Contract
[**getContractServiceContractContractGet**](ServiceContractApi.md#getcontractservicecontractcontractget) | **GET** /service-contract/contract | Get Contract
[**getContractsServiceContractContractsGet**](ServiceContractApi.md#getcontractsservicecontractcontractsget) | **GET** /service-contract/contracts | Get Contracts
[**getServiceContractContractForStationGet**](ServiceContractApi.md#getservicecontractcontractforstationget) | **GET** /service-contract/contract_for_station | Get


# **createContractServiceContractCreateContractPost**
> String createContractServiceContractCreateContractPost(serviceContractNewSchema)

Create Contract

### Example
```dart
import 'package:BackendAPI/api.dart';

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

No authorization required

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

No authorization required

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

No authorization required

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

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)
