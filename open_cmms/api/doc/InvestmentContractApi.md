# BackendAPI.api.InvestmentContractApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                | HTTP request                                  | Description     
---------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|-----------------
 [**createContractInvestmentContractCreateContractPost**](InvestmentContractApi.md#createcontractinvestmentcontractcreatecontractpost) | **POST** /investment-contract/create_contract | Create Contract 
 [**getContractInvestmentContractContractGet**](InvestmentContractApi.md#getcontractinvestmentcontractcontractget)                     | **GET** /investment-contract/contract         | Get Contract    
 [**getContractsInvestmentContractContractsGet**](InvestmentContractApi.md#getcontractsinvestmentcontractcontractsget)                 | **GET** /investment-contract/contracts        | Get Contracts   


# **createContractInvestmentContractCreateContractPost**
> String createContractInvestmentContractCreateContractPost(investmentContractNewSchema)

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

final api_instance = InvestmentContractApi();
final investmentContractNewSchema = InvestmentContractNewSchema(); // InvestmentContractNewSchema | 

try {
    final result = api_instance.createContractInvestmentContractCreateContractPost(investmentContractNewSchema);
    print(result);
} catch (e) {
    print('Exception when calling InvestmentContractApi->createContractInvestmentContractCreateContractPost: $e\n');
}
```

### Parameters

 Name                            | Type                                                              | Description | Notes 
---------------------------------|-------------------------------------------------------------------|-------------|-------
 **investmentContractNewSchema** | [**InvestmentContractNewSchema**](InvestmentContractNewSchema.md) |             |

### Return type

**String**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContractInvestmentContractContractGet**
> InvestmentContractSchema getContractInvestmentContractContractGet(contractId)

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

final api_instance = InvestmentContractApi();
final contractId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getContractInvestmentContractContractGet(contractId);
    print(result);
} catch (e) {
    print('Exception when calling InvestmentContractApi->getContractInvestmentContractContractGet: $e\n');
}
```

### Parameters

 Name           | Type       | Description | Notes 
----------------|------------|-------------|-------
 **contractId** | **String** |             |

### Return type

[**InvestmentContractSchema**](InvestmentContractSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getContractsInvestmentContractContractsGet**
> List<InvestmentContractSchema> getContractsInvestmentContractContractsGet(onlyActive)

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

final api_instance = InvestmentContractApi();
final onlyActive = ; // Object | 

try {
    final result = api_instance.getContractsInvestmentContractContractsGet(onlyActive);
    print(result);
} catch (e) {
    print('Exception when calling InvestmentContractApi->getContractsInvestmentContractContractsGet: $e\n');
}
```

### Parameters

 Name           | Type              | Description | Notes                        
----------------|-------------------|-------------|------------------------------
 **onlyActive** | [**Object**](.md) |             | [optional] [default to true] 

### Return type

[**List<InvestmentContractSchema>**](InvestmentContractSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

