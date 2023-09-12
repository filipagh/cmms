# BackendAPI.api.AssignedComponentsApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

 Method                                                                                                                                                                        | HTTP request                                             | Description                
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|----------------------------
 [**createInstalledComponentAssignedComponentsCreateInstalledComponentPost**](AssignedComponentsApi.md#createinstalledcomponentassignedcomponentscreateinstalledcomponentpost) | **POST** /assigned_components/create_installed_component | Create Installed Component 
 [**getAllAssignedComponentsComponentsGet**](AssignedComponentsApi.md#getallassignedcomponentscomponentsget)                                                                   | **GET** /assigned_components/components                  | Get All                    
 [**getReplacmentWarrantyAssignedComponentsReplacmentWarranryGet**](AssignedComponentsApi.md#getreplacmentwarrantyassignedcomponentsreplacmentwarranryget)                     | **GET** /assigned_components/replacment_warranry         | Get Replacment Warranty    
 [**overrideWarrantyAssignedComponentsOverrideWarrantyPost**](AssignedComponentsApi.md#overridewarrantyassignedcomponentsoverridewarrantypost)                                 | **POST** /assigned_components/override_warranty          | Override Warranty          
 [**removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost**](AssignedComponentsApi.md#removeinstalledcomponentassignedcomponentsremoveinstalledcomponentpost) | **POST** /assigned_components/remove_installed_component | Remove Installed Component 


# **createInstalledComponentAssignedComponentsCreateInstalledComponentPost**

> List<String> createInstalledComponentAssignedComponentsCreateInstalledComponentPost(componentsWarrantySource,
> installationDate, assignedComponentNewSchema, componentWarrantyId, componentWarrantyUntil, paidServiceUntil)

Create Installed Component

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

final api_instance = AssignedComponentsApi();
final componentsWarrantySource = ; // ComponentWarrantySource | 
final installationDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final assignedComponentNewSchema = [List<AssignedComponentNewSchema>()]; // List<AssignedComponentNewSchema> | 
final componentWarrantyId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final componentWarrantyUntil = 2013-10-20T19:20:30+01:00; // DateTime | 
final paidServiceUntil = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final result = api_instance.createInstalledComponentAssignedComponentsCreateInstalledComponentPost(componentsWarrantySource, installationDate, assignedComponentNewSchema, componentWarrantyId, componentWarrantyUntil, paidServiceUntil);
    print(result);
} catch (e) {
    print('Exception when calling AssignedComponentsApi->createInstalledComponentAssignedComponentsCreateInstalledComponentPost: $e\n');
}
```

### Parameters

 Name                           | Type                                                                  | Description | Notes      
--------------------------------|-----------------------------------------------------------------------|-------------|------------
 **componentsWarrantySource**   | [**ComponentWarrantySource**](.md)                                    |             |
 **installationDate**           | **DateTime**                                                          |             |
 **assignedComponentNewSchema** | [**List<AssignedComponentNewSchema>**](AssignedComponentNewSchema.md) |             |
 **componentWarrantyId**        | **String**                                                            |             | [optional] 
 **componentWarrantyUntil**     | **DateTime**                                                          |             | [optional] 
 **paidServiceUntil**           | **DateTime**                                                          |             | [optional] 

### Return type

**List<String>**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllAssignedComponentsComponentsGet**
> List<AssignedComponentSchema> getAllAssignedComponentsComponentsGet(stationId)

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

final api_instance = AssignedComponentsApi();
final stationId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final result = api_instance.getAllAssignedComponentsComponentsGet(stationId);
    print(result);
} catch (e) {
    print('Exception when calling AssignedComponentsApi->getAllAssignedComponentsComponentsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **stationId** | **String**|  | [optional] 

### Return type

[**List<AssignedComponentSchema>**](AssignedComponentSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReplacmentWarrantyAssignedComponentsReplacmentWarranryGet**

> ComponentWarranty getReplacmentWarrantyAssignedComponentsReplacmentWarranryGet(componentId)

Get Replacment Warranty

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

final api_instance = AssignedComponentsApi();
final componentId = 38400000 - 8
cf0-11
bd-b23e-10
b96e4ef00d; // String | 

try {
final result = api_instance.getReplacmentWarrantyAssignedComponentsReplacmentWarranryGet(componentId);
print(result);
} catch
(
e) {
print('Exception when calling AssignedComponentsApi->getReplacmentWarrantyAssignedComponentsReplacmentWarranryGet: $e\n');
}
```

### Parameters

 Name            | Type       | Description | Notes      
-----------------|------------|-------------|------------
 **componentId** | **String** |             | [optional] 

### Return type

[**ComponentWarranty**](ComponentWarranty.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **overrideWarrantyAssignedComponentsOverrideWarrantyPost**

> String overrideWarrantyAssignedComponentsOverrideWarrantyPost(componentId, componentWarrantySource,
> componentWarrantyId, componentWarrantyUntil, paidServiceUntil, serviceContractsId)

Override Warranty

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

final api_instance = AssignedComponentsApi();
final componentId = 38400000 - 8
cf0-11
bd-b23e-10
b96e4ef00d; // String | 
final componentWarrantySource =; // ComponentWarrantySource | 
final componentWarrantyId = 38400000 - 8
cf0-11
bd-b23e-10
b96e4ef00d; // String | 
final componentWarrantyUntil = 2013 - 10 - 20
T19:20
:
30
+
01
:
00; // DateTime | 
final paidServiceUntil = 2013 - 10 - 20
T19:20
:
30
+
01
:
00; // DateTime | 
final serviceContractsId = []; // List<String> | 

try {
final result = api_instance.overrideWarrantyAssignedComponentsOverrideWarrantyPost(componentId, componentWarrantySource, componentWarrantyId, componentWarrantyUntil, paidServiceUntil, serviceContractsId);
print(result);
} catch
(
e) {
print('Exception when calling AssignedComponentsApi->overrideWarrantyAssignedComponentsOverrideWarrantyPost: $e\n');
}
```

### Parameters

 Name                        | Type                               | Description | Notes                            
-----------------------------|------------------------------------|-------------|----------------------------------
 **componentId**             | **String**                         |             |
 **componentWarrantySource** | [**ComponentWarrantySource**](.md) |             |
 **componentWarrantyId**     | **String**                         |             | [optional]                       
 **componentWarrantyUntil**  | **DateTime**                       |             | [optional]                       
 **paidServiceUntil**        | **DateTime**                       |             | [optional]                       
 **serviceContractsId**      | [**List<String>**](String.md)      |             | [optional] [default to const []] 

### Return type

**String**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost**

> List<String> removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(uninstallDate,
> assignedComponentIdSchema)

Remove Installed Component

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

final api_instance = AssignedComponentsApi();
final uninstallDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final assignedComponentIdSchema = [List<AssignedComponentIdSchema>()]; // List<AssignedComponentIdSchema> | 

try {
    final result = api_instance.removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost(uninstallDate, assignedComponentIdSchema);
    print(result);
} catch (e) {
    print('Exception when calling AssignedComponentsApi->removeInstalledComponentAssignedComponentsRemoveInstalledComponentPost: $e\n');
}
```

### Parameters

 Name                          | Type                                                                | Description | Notes 
-------------------------------|---------------------------------------------------------------------|-------------|-------
 **uninstallDate**             | **DateTime**                                                        |             |
 **assignedComponentIdSchema** | [**List<AssignedComponentIdSchema>**](AssignedComponentIdSchema.md) |             |

### Return type

**List<String>**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

