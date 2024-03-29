# BackendAPI.api.AuthApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authTestAuthAuthTestGet**](AuthApi.md#authtestauthauthtestget) | **GET** /auth/auth_test | Auth Test
[**getAllAuthUsersGet**](AuthApi.md#getallauthusersget) | **GET** /auth/users | Get All
[**getMeAuthMeGet**](AuthApi.md#getmeauthmeget) | **GET** /auth/me | Get Me
[**loginAuthLoginGet**](AuthApi.md#loginauthloginget) | **GET** /auth/login | Login
[**logoutAuthLogoutGet**](AuthApi.md#logoutauthlogoutget) | **GET** /auth/logout | Logout
[**updateUserRoleAuthUserUserIdRolePost**](AuthApi.md#updateuserroleauthuseruseridrolepost) | **POST** /auth/user/{user_id}/role | Update User Role


# **authTestAuthAuthTestGet**
> String authTestAuthAuthTestGet()

Auth Test

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

final api_instance = AuthApi();

try {
    final result = api_instance.authTestAuthAuthTestGet();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authTestAuthAuthTestGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/html

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllAuthUsersGet**
> List<UserSchema> getAllAuthUsersGet()

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

final api_instance = AuthApi();

try {
    final result = api_instance.getAllAuthUsersGet();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->getAllAuthUsersGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<UserSchema>**](UserSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMeAuthMeGet**
> UserSchema getMeAuthMeGet()

Get Me

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

final api_instance = AuthApi();

try {
    final result = api_instance.getMeAuthMeGet();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->getMeAuthMeGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserSchema**](UserSchema.md)

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loginAuthLoginGet**
> String loginAuthLoginGet()

Login

### Example
```dart
import 'package:BackendAPI/api.dart';
// TODO Configure API key authorization: user_session
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('user_session').apiKeyPrefix = 'Bearer';

final api_instance = AuthApi();

try {
    final result = api_instance.loginAuthLoginGet();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->loginAuthLoginGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

[user_session](../README.md#user_session)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/html

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logoutAuthLogoutGet**
> Object logoutAuthLogoutGet()

Logout

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = AuthApi();

try {
    final result = api_instance.logoutAuthLogoutGet();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->logoutAuthLogoutGet: $e\n');
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

# **updateUserRoleAuthUserUserIdRolePost**
> String updateUserRoleAuthUserUserIdRolePost(userId, role)

Update User Role

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

final api_instance = AuthApi();
final userId = ; // Object | 
final role = ; // Role | 

try {
    final result = api_instance.updateUserRoleAuthUserUserIdRolePost(userId, role);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->updateUserRoleAuthUserUserIdRolePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | [**Object**](.md)|  | 
 **role** | [**Role**](.md)|  | 

### Return type

**String**

### Authorization

[user_session](../README.md#user_session), [api_key](../README.md#api_key), [OAuth2AuthorizationCodeBearer](../README.md#OAuth2AuthorizationCodeBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

