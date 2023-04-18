# BackendAPI.api.DefaultApi

## Load the API package
```dart
import 'package:BackendAPI/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**rootGet**](DefaultApi.md#rootget) | **GET** / | Root
[**settingsSettingsGet**](DefaultApi.md#settingssettingsget) | **GET** /settings | Settings


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

# **settingsSettingsGet**
> List<SettingSchema> settingsSettingsGet()

Settings

### Example
```dart
import 'package:BackendAPI/api.dart';

final api_instance = DefaultApi();

try {
    final result = api_instance.settingsSettingsGet();
    print(result);
} catch (e) {
    print('Exception when calling DefaultApi->settingsSettingsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<SettingSchema>**](SettingSchema.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

