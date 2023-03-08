# BackendAPI.api.DefaultApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authCallbackAuthCallbackGet**](DefaultApi.md#authcallbackauthcallbackget) | **GET** /auth-callback | Auth Callback
[**authTestAuthTestGet**](DefaultApi.md#authtestauthtestget) | **GET** /auth_test | Auth Test
[**loggedOutLoggedOutGet**](DefaultApi.md#loggedoutloggedoutget) | **GET** /logged_out | Logged Out
[**loginLoginGet**](DefaultApi.md#loginloginget) | **GET** /login | Login
[**logoutLogoutGet**](DefaultApi.md#logoutlogoutget) | **GET** /logout | Logout
[**rootGet**](DefaultApi.md#rootget) | **GET** / | Root


# **authCallbackAuthCallbackGet**
> Object authCallbackAuthCallbackGet(code)

Auth Callback

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = DefaultApi();
final code = code_example; // String | 

try {
    final result = api_instance.authCallbackAuthCallbackGet(code);
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->authCallbackAuthCallbackGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **code** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authTestAuthTestGet**
> Object authTestAuthTestGet()

Auth Test

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: APIKeyCookie
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyCookie').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyCookie').apiKeyPrefix = 'Bearer';
// TODO Configure API key authorization: APIKeyHeader
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyHeader').apiKeyPrefix = 'Bearer';
// TODO Configure OAuth2 access token for authorization: OAuth2AuthorizationCodeBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2AuthorizationCodeBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DefaultApi();

try {
    final result = api_instance.authTestAuthTestGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->authTestAuthTestGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

[APIKeyCookie](../README.md#APIKeyCookie), [APIKeyHeader](../README.md#APIKeyHeader), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loggedOutLoggedOutGet**
> Object loggedOutLoggedOutGet()

Logged Out

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.loggedOutLoggedOutGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->loggedOutLoggedOutGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loginLoginGet**
> Object loginLoginGet()

Login

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: APIKeyCookie
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyCookie').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('APIKeyCookie').apiKeyPrefix = 'Bearer';

final api_instance = DefaultApi();

try {
    final result = api_instance.loginLoginGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->loginLoginGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

[APIKeyCookie](../README.md#APIKeyCookie)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logoutLogoutGet**
> Object logoutLogoutGet()

Logout

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.logoutLogoutGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->logoutLogoutGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **rootGet**
> Object rootGet()

Root

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.rootGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->rootGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

